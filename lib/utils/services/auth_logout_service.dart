import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:brandface/presentation/login/ui/login_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLogoutService {
  final SharedPreferences _prefs;

  AuthLogoutService(this._prefs);

  static const _preserveKeys = {'app_locale'};

  Future<void> _clearSessionPrefs() async {
    final keys = _prefs.getKeys().where((k) => !_preserveKeys.contains(k));
    for (final key in keys) {
      await _prefs.remove(key);
    }
  }

  Future<void> logout(BuildContext context) async {
    await _clearSessionPrefs();
    if (!context.mounted) return;
    context.read<LoginBloc>().add(const LoginEvent.reset());
    context.go(LoginPage.tag);
  }
}
