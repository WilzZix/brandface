import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Firebase'ni ishga tushiruvchi yagona kirish nuqtasi.
///
/// `runApp()` dan oldin `main()` ichida chaqirilishi kerak. Platforma config
/// fayllari (iOS: GoogleService-Info.plist, Android: google-services.json)
/// hali joylashtirilmagan bo'lsa, init muvaffaqiyatsiz bo'ladi va appni crash
/// qildirmasdan log'ga yozadi — Firebase xizmatlari oddiy "no-op" bo'lib turadi.
final class FirebaseBootstrap {
  FirebaseBootstrap._();

  static bool _initialized = false;

  static bool get isInitialized => _initialized;

  /// Foydalanuvchini Crashlytics/Analytics dashboard'larida ID bo'yicha
  /// kuzatish uchun login muvaffaqiyatdan keyin chaqiriladi.
  static Future<void> setUser({required int id, String? role}) async {
    if (!_initialized) return;
    try {
      final idString = id.toString();
      await FirebaseCrashlytics.instance.setUserIdentifier(idString);
      await FirebaseAnalytics.instance.setUserId(id: idString);
      if (role != null && role.isNotEmpty) {
        await FirebaseCrashlytics.instance.setCustomKey('role', role);
        await FirebaseAnalytics.instance.setUserProperty(
          name: 'role',
          value: role,
        );
      }
    } catch (e) {
      debugPrint('[Firebase] setUser failed: $e');
    }
  }

  /// Logout/account-delete'dan keyin user'ni Firebase'da tozalash.
  static Future<void> clearUser() async {
    if (!_initialized) return;
    try {
      await FirebaseCrashlytics.instance.setUserIdentifier('');
      await FirebaseAnalytics.instance.setUserId(id: null);
    } catch (_) {}
  }

  /// Returns true if Firebase initialized successfully.
  static Future<bool> initialize() async {
    if (_initialized) return true;
    try {
      await Firebase.initializeApp();
      _initialized = true;

      // Crashlytics — har doim yoqilgan. Debug rejimida sinab ko'rish uchun
      // ham xatolar Firebase Console DebugView'ga keladi. Release'da haqiqiy
      // crash'lar avtomatik yuboriladi.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

      // Flutter framework xatolari va Dart asyncxron xatolari Crashlytics'ga
      // yo'naltiriladi.
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      // Analytics avto-yig'ish (debug'da ham yoqiladi — test event'lari uchun).
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

      // Remote Config — minimal default sozlama. Foydalanish: keyinroq
      // `FirebaseRemoteConfig.instance.getString('flag_name')`.
      try {
        final rc = FirebaseRemoteConfig.instance;
        await rc.setConfigSettings(
          RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 10),
            minimumFetchInterval: kDebugMode
                ? Duration.zero
                : const Duration(hours: 1),
          ),
        );
        await rc.fetchAndActivate();
      } catch (e) {
        debugPrint('[Firebase] RemoteConfig fetch failed: $e');
      }

      debugPrint('[Firebase] initialized');
      return true;
    } on FirebaseException catch (e) {
      debugPrint('[Firebase] init skipped: ${e.code} ${e.message}');
      return false;
    } on PlatformException catch (e) {
      // GoogleService-Info.plist / google-services.json yo'q bo'lganda shu
      // exception kelishi mumkin.
      debugPrint('[Firebase] init skipped (platform): ${e.message}');
      return false;
    } catch (e) {
      debugPrint('[Firebase] init unexpected error: $e');
      return false;
    }
  }
}
