import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// App foreground (ochiq) bo'lganda kelgan push'ni tizim banner'i sifatida
/// ko'rsatadi.
///
/// iOS: FCM foreground banner'ni o'zi ko'rsatadi
/// ([FcmService.setForegroundNotificationPresentationOptions] orqali) — shuning
/// uchun bu servis faqat **Android**da ishlaydi (Android foreground'da push
/// banner'ini avtomatik ko'rsatmaydi).
final class LocalNotificationService {
  LocalNotificationService._();
  static final LocalNotificationService instance = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Bildirishnomalar',
    description: 'Push bildirishnomalari uchun kanal',
    importance: Importance.high,
  );

  Future<void> init() async {
    if (_initialized) return;
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    // iOS'da ruxsatlarni FCM allaqachon so'ragan — qayta so'ramaymiz.
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
    );

    // Android 8+ uchun kanal oldindan yaratiladi.
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);

    _initialized = true;
  }

  /// Foreground push'ni banner sifatida ko'rsatadi (faqat Android).
  Future<void> showFromMessage(RemoteMessage message) async {
    if (!Platform.isAndroid) return;
    final notification = message.notification;
    if (notification == null) return; // faqat notification-type xabarlar

    try {
      await _plugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: message.data.isEmpty ? null : message.data.toString(),
      );
    } catch (e) {
      debugPrint('[LocalNotif] show failed: $e');
    }
  }
}
