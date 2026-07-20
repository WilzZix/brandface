import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:brandface/presentation/login/ui/login_page.dart';
import 'package:brandface/utils/services/firebase/fcm_service.dart';
import 'package:brandface/utils/services/firebase/firebase_bootstrap.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AuthLogoutService {
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
    // Prefs tozalashdan OLDIN — access token hali amal qilayotganda backenddan
    // qurilma tokenini o'chiramiz, aks holda qurilma push olishda davom etadi.
    await FcmService.instance.unregister();
    await _clearSessionPrefs();
    await FirebaseBootstrap.clearUser();
    if (!context.mounted) return;
    context.read<LoginBloc>().add(const LoginEvent.reset());
    context.go(LoginPage.tag);
  }
}
