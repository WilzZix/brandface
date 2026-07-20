import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'firebase_bootstrap.dart';

/// FCM (Firebase Cloud Messaging) bilan ishlashning yagona joyi.
///
/// `FirebaseBootstrap.initialize()` muvaffaqiyatli o'tgan keyin
/// `FcmService.instance.start()` chaqirilishi kerak (odatda main.dart yoki
/// splash/login muvaffaqiyat oqimida).
///
/// Token backendga yuborilishi uchun [registerToken] callback ulanadi.
final class FcmService {
  FcmService._();
  static final FcmService instance = FcmService._();

  StreamSubscription<RemoteMessage>? _foregroundSub;
  StreamSubscription<String>? _tokenRefreshSub;
  bool _started = false;

  /// Backendga FCM tokenini yuborish uchun callback (PUT device-token).
  /// App ishga tushganda [start] ichida ulanadi. Faqat user login qilgan
  /// bo'lsa haqiqiy so'rov yuborishi kerak (guard callback ichida).
  Future<void> Function(String token)? onTokenAvailable;

  /// Backenddan tokenni o'chirish uchun callback (DELETE device-token).
  /// Logout'dan oldin [unregister] orqali chaqiriladi.
  Future<void> Function()? onTokenDelete;

  /// Push xabar foreground'da kelganda chaqiriladigan callback.
  void Function(RemoteMessage message)? onForegroundMessage;

  /// Foydalanuvchi notification'ni bosib appni ochganda chaqiriladi.
  void Function(RemoteMessage message)? onMessageOpenedApp;

  Future<void> start() async {
    if (_started || !FirebaseBootstrap.isInitialized) return;
    try {
      final messaging = FirebaseMessaging.instance;

      // iOS uchun permission so'rash. Android 13+ uchun ham (POST_NOTIFICATIONS).
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint('[FCM] permission: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        return;
      }

      // iOS foreground bildirishnoma ko'rsatish (Android'da odatdek).
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Token olish.
      final token = await messaging.getToken();
      if (token != null) {
        debugPrint('[FCM] token: ${token.substring(0, 16)}…');
        await onTokenAvailable?.call(token);
      }

      // Token yangilanganda backendga qayta yuborish.
      _tokenRefreshSub = messaging.onTokenRefresh.listen((t) {
        debugPrint('[FCM] token refreshed: ${t.substring(0, 16)}…');
        onTokenAvailable?.call(t);
      });

      // Foreground'da kelgan xabarlar.
      _foregroundSub = FirebaseMessaging.onMessage.listen((msg) {
        debugPrint('[FCM] foreground: ${msg.notification?.title}');
        onForegroundMessage?.call(msg);
      });

      // App background bo'lganda push bosilib ochilganda.
      FirebaseMessaging.onMessageOpenedApp.listen((msg) {
        debugPrint('[FCM] opened from background: ${msg.data}');
        onMessageOpenedApp?.call(msg);
      });

      // App butunlay yopiq holatdan push orqali ochilganda.
      final initialMessage = await messaging.getInitialMessage();
      if (initialMessage != null) {
        onMessageOpenedApp?.call(initialMessage);
      }

      _started = true;
    } catch (e) {
      debugPrint('[FCM] start failed: $e');
    }
  }

  /// Joriy FCM tokenni qayta olib backendga yuborish. Login muvaffaqiyatidan
  /// keyin chaqiriladi — o'sha paytda access token tayyor bo'lgani uchun PUT
  /// haqiqiy bajariladi (app ochilishidagi [start] user login qilmagan bo'lsa
  /// tokenni yubormay o'tkazib yuborgan bo'lishi mumkin).
  Future<void> syncToken() async {
    if (!FirebaseBootstrap.isInitialized) return;
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await onTokenAvailable?.call(token);
      }
    } catch (e) {
      debugPrint('[FCM] syncToken failed: $e');
    }
  }

  /// Logout'dan oldin chaqiriladi: backenddan qurilma tokenini o'chiradi
  /// (access token hali amal qilayotganda), so'ng lokal FCM tokenni bekor
  /// qiladi. Xatolar logout oqimini to'xtatmasligi kerak.
  Future<void> unregister() async {
    try {
      await onTokenDelete?.call();
    } catch (e) {
      debugPrint('[FCM] unregister (backend) failed: $e');
    }
    await deleteToken();
  }

  Future<void> stop() async {
    await _foregroundSub?.cancel();
    await _tokenRefreshSub?.cancel();
    _foregroundSub = null;
    _tokenRefreshSub = null;
    _started = false;
  }

  Future<void> deleteToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (_) {}
  }
}
