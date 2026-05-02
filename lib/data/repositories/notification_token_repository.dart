import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationTokenRepository {
  static const String _kFcmTokenKey = 'fcm_token';

  final SharedPreferences _prefs;

  const NotificationTokenRepository({required SharedPreferences prefs})
      : _prefs = prefs;

  String? getCachedToken() => _prefs.getString(_kFcmTokenKey);

  Future<void> saveToken(String token) async {
    await _prefs.setString(_kFcmTokenKey, token);
    if (kDebugMode) {
      debugPrint('[FCM] token saved locally: ${_preview(token)}');
    }
  }

  Future<void> clearToken() async {
    await _prefs.remove(_kFcmTokenKey);
  }

  // TODO(backend): wire this to the backend endpoint once available
  // (e.g. POST /api/users/fcm-token via DioClient). For now, log only so
  // that the call site can already invoke it without behavioral change.
  Future<void> sendTokenToBackend(String token) async {
    if (kDebugMode) {
      debugPrint('[FCM] sendTokenToBackend (stub): ${_preview(token)}');
    }
  }

  String _preview(String token) =>
      token.length <= 12 ? token : '${token.substring(0, 12)}...';
}
