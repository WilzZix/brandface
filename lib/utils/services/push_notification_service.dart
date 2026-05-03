import 'dart:async';

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

  PushNotificationService({
    required FirebaseMessaging messaging,
    required FlutterLocalNotificationsPlugin localNotifications,
    required NotificationTokenRepository tokenRepository,
  })  : _messaging = messaging,
        _localNotifications = localNotifications,
        _tokenRepository = tokenRepository;

  Future<void> init() async {
    await _initLocalNotifications();
    await _requestPermission();
    await _retrieveAndStoreToken();
    _listenForTokenRefresh();
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

    await _localNotifications.initialize(settings: initSettings);

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

  Future<void> dispose() async {
    await _tokenRefreshSub?.cancel();
    _tokenRefreshSub = null;
  }
}
