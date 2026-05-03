import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../data/repositories/notification_token_repository.dart';

class PushNotificationService {
  static const String androidChannelId = 'brandface_default';
  static const String androidChannelName = 'Brandface notifications';
  static const String androidChannelDescription =
      'Default channel for brandface push notifications';

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final NotificationTokenRepository _tokenRepository;

  StreamSubscription<String>? _tokenRefreshSub;
  StreamSubscription<RemoteMessage>? _foregroundSub;
  StreamSubscription<RemoteMessage>? _openedAppSub;

  PushNotificationService({
    required FirebaseMessaging messaging,
    required FlutterLocalNotificationsPlugin localNotifications,
    required NotificationTokenRepository tokenRepository,
  })  : _messaging = messaging,
        _localNotifications = localNotifications,
        _tokenRepository = tokenRepository;

  /// Invoked when the user taps a notification (foreground banner, background
  /// tap, or terminated-state launch). Set this from the caller (e.g. main.dart)
  /// to route via go_router.
  void Function(Map<String, dynamic> data)? onNotificationTap;

  Future<void> init() async {
    await _initLocalNotifications();
    await _requestPermission();
    await _retrieveAndStoreToken();
    _listenForTokenRefresh();

    _foregroundSub?.cancel();
    _openedAppSub?.cancel();
    _foregroundSub = FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    _openedAppSub =
        FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      _dispatchTap(initial.data);
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      if (kDebugMode) debugPrint('[FCM] subscribed to topic: $topic');
    } catch (e, st) {
      debugPrint('[FCM] subscribeToTopic($topic) failed: $e\n$st');
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      if (kDebugMode) debugPrint('[FCM] unsubscribed from topic: $topic');
    } catch (e, st) {
      debugPrint('[FCM] unsubscribeFromTopic($topic) failed: $e\n$st');
    }
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );

    const androidChannel = AndroidNotificationChannel(
      androidChannelId,
      androidChannelName,
      description: androidChannelDescription,
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  Future<void> _requestPermission() async {
    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (kDebugMode) {
        debugPrint('[FCM] permission status: ${settings.authorizationStatus}');
      }
    } catch (e, st) {
      debugPrint('[FCM] requestPermission failed: $e\n$st');
    }
  }

  Future<void> _retrieveAndStoreToken() async {
    try {
      final token = await _messaging.getToken();
      if (token == null) {
        debugPrint('[FCM] getToken returned null');
        return;
      }
      await _tokenRepository.saveToken(token);
      await _tokenRepository.sendTokenToBackend(token);
    } catch (e, st) {
      debugPrint('[FCM] getToken failed: $e\n$st');
    }
  }

  void _listenForTokenRefresh() {
    _tokenRefreshSub?.cancel();
    _tokenRefreshSub = _messaging.onTokenRefresh.listen(
      (token) async {
        await _tokenRepository.saveToken(token);
        await _tokenRepository.sendTokenToBackend(token);
      },
      onError: (Object e, StackTrace st) {
        debugPrint('[FCM] onTokenRefresh error: $e\n$st');
      },
    );
  }

  Future<void> _onForegroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      debugPrint('[FCM][fg] id=${message.messageId} data=${message.data}');
    }

    final notification = message.notification;
    if (notification == null) return;

    await _localNotifications.show(
      id: (message.messageId?.hashCode ?? notification.hashCode) & 0x7FFFFFFF,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannelId,
          androidChannelName,
          channelDescription: androidChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: _encodePayload(message.data),
    );
  }

  void _onMessageOpenedApp(RemoteMessage message) {
    if (kDebugMode) {
      debugPrint('[FCM][open] id=${message.messageId} data=${message.data}');
    }
    _dispatchTap(message.data);
  }

  void _onLocalNotificationTap(NotificationResponse response) {
    final raw = response.payload;
    if (raw == null || raw.isEmpty) {
      _dispatchTap(const {});
      return;
    }
    _dispatchTap(_decodePayload(raw));
  }

  void _dispatchTap(Map<String, dynamic> data) {
    final cb = onNotificationTap;
    if (cb == null) {
      debugPrint('[FCM] onNotificationTap not set; dropping tap. data=$data');
      return;
    }
    cb(data);
  }

  String _encodePayload(Map<String, dynamic> data) {
    if (data.isEmpty) return '';
    return jsonEncode(data);
  }

  Map<String, dynamic> _decodePayload(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
      return {};
    } catch (_) {
      return {};
    }
  }

  Future<void> dispose() async {
    await _tokenRefreshSub?.cancel();
    await _foregroundSub?.cancel();
    await _openedAppSub?.cancel();
    _tokenRefreshSub = null;
    _foregroundSub = null;
    _openedAppSub = null;
  }
}
