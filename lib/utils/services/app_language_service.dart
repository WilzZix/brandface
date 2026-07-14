import 'package:brandface/core/i18n/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AppLanguageService {
  final SharedPreferences _prefs;

  const AppLanguageService({required SharedPreferences prefs}) : _prefs = prefs;

  Future<void> setAppLocal(AppLocale local) async {
    _prefs.setString('app_locale', local.name);
  }

  Future<AppLocale> getAppLocale() async {
    final String appLocal = _prefs.getString('app_locale') ?? 'uz';

    switch (appLocal) {
      case 'ru':
        return AppLocale.ru;
      case 'en':
        return AppLocale.en;
      case 'uz':
      default:
        return AppLocale.uz;
    }
  }
}
