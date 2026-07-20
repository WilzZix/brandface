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

      // Token olish (iOS'da APNS tokeni kelguncha kutiladi).
      final token = await _fetchToken();
      if (token != null) {
        debugPrint('[FCM] token: ${token.substring(0, 16)}…');
        await onTokenAvailable?.call(token);
      }

      // Token yangilanganda backendga qayta yuborish. iOS'da APNS tokeni
      // start paytida hali kelmagan bo'lsa, FCM token keyinroq shu yerda
      // paydo bo'ladi va backendga yuboriladi.
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
    debugPrint('[FCM] syncToken() called');
    if (!FirebaseBootstrap.isInitialized) {
      debugPrint('[FCM] syncToken skipped: Firebase not initialized');
      return;
    }
    try {
      final token = await _fetchToken();
      debugPrint('[FCM] getToken -> ${token == null ? "null" : "${token.substring(0, 16)}…"}');
      if (token != null) {
        if (onTokenAvailable == null) {
          debugPrint('[FCM] syncToken: onTokenAvailable callback ULANMAGAN!');
        }
        await onTokenAvailable?.call(token);
      }
    } catch (e) {
      debugPrint('[FCM] syncToken failed: $e');
    }
  }

  /// FCM tokenini oladi. iOS'da `getToken()` avval APNS tokenini talab qiladi —
  /// u odatda app ochilgach bir-necha soniyada keladi. Shuning uchun APNS
  /// tokeni paydo bo'lguncha qisqa muddat (max ~10s) poll qilamiz.
  /// Simulyatorda APNS umuman kelmasligi mumkin — u holda `null` qaytadi
  /// (crash bo'lmaydi) va token keyin `onTokenRefresh` orqali yuboriladi.
  Future<String?> _fetchToken() async {
    final messaging = FirebaseMessaging.instance;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      var apns = await messaging.getAPNSToken();
      var tries = 0;
      while (apns == null && tries < 10) {
        await Future.delayed(const Duration(seconds: 1));
        apns = await messaging.getAPNSToken();
        tries++;
      }
      debugPrint('[FCM] APNS token: ${apns == null ? "null (kelmadi — simulyator?)" : "bor"}');
      if (apns == null) return null;
    }
    final token = await messaging.getToken();
    // Firebase Console'dan test push yuborish uchun to'liq token (faqat debug).
    if (kDebugMode && token != null) {
      debugPrint('[FCM] FULL TOKEN (test uchun): $token');
    }
    return token;
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
