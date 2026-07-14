import 'package:shared_preferences/shared_preferences.dart';

final class ProfileService {
  final SharedPreferences _prefs;

  ProfileService(this._prefs);

  // Profile ID saqlash
  Future<bool> setProfileId(int id) async {
    return await _prefs.setInt('profile_id', id);
  }

  int? getProfileId() {
    return _prefs.getInt('profile_id');
  }

  // User Role saqlash
  Future<bool> setRole(String role) async {
    return await _prefs.setString('user_role', role);
  }

  String? getRole() {
    return _prefs.getString('user_role');
  }

  String getResolvedRole({required String fallback}) {
    final stored = _prefs.getString('user_role');
    if (stored == null || stored.isEmpty || stored.toLowerCase() == 'guest') {
      return fallback;
    }
    return stored;
  }

  // Ma'lumotlarni o'chirish (Logout uchun)
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
