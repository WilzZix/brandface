import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthLocalService {
  Future<void> saveTokens({required String accessToken, required String refreshToken});

  String? getAccessToken();

  String? getRefreshToken();

  Future<void> clearCache();

  bool isLoggedIn();
}

class AuthLocalService implements IAuthLocalService {
  final SharedPreferences _prefs;

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  AuthLocalService(this._prefs);

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _prefs.setString(_accessTokenKey, accessToken);
    await _prefs.setString(_refreshTokenKey, refreshToken);
  }

  @override
  String? getAccessToken() => _prefs.getString(_accessTokenKey);

  @override
  String? getRefreshToken() => _prefs.getString(_refreshTokenKey);

  @override
  bool isLoggedIn() {
    final token = getAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> clearCache() async {
    await _prefs.remove(_accessTokenKey);
    await _prefs.remove(_refreshTokenKey);
    await _prefs.clear();
  }
}
