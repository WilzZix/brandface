import 'package:bloc/bloc.dart';
import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/services/app_auth_local_service.dart';
import '../../../utils/services/profile_service.dart';

part 'init_app_state.dart';

part 'init_app_cubit.freezed.dart';

class InitAppCubit extends Cubit<InitAppState> {
  InitAppCubit({
    required IAuthLocalService sharedPrefService,
    required ProfileService profileService,
    required DioClient dioClient,
  }) : _sharedPrefService = sharedPrefService,
       _profileService = profileService,
       _dioClient = dioClient,
       super(const InitAppState.initial());

  final IAuthLocalService _sharedPrefService;
  final ProfileService _profileService;
  final DioClient _dioClient;

  Future<void> initApp() async {
    await Future.delayed(const Duration(seconds: 3));

    final hasToken = _sharedPrefService.isLoggedIn();
    bool effectiveLoggedIn = hasToken;

    if (hasToken) {
      effectiveLoggedIn = await _validateSession();
      if (!effectiveLoggedIn) {
        await _sharedPrefService.clearCache();
      }
    }

    emit(
      InitAppState.appInitialized(
        effectiveLoggedIn,
        role: _profileService.getRole(),
        hasSeenOnboarding: _sharedPrefService.hasSeenOnboarding(),
      ),
    );
  }

  Future<bool> _validateSession() async {
    try {
      final response = await _dioClient.get(
        ApiRoutes.me,
        options: Options(extra: const {'skipUnauthorizedDialog': true}),
      );
      final ok = response.statusCode != null && response.statusCode! < 400;
      if (ok) {
        // Backend role'ni lokal cache bilan sinxronlash — user appdan tashqarida
        // role'ni o'rnatgan bo'lishi mumkin (yoki avvalgi sessiyada cache 'guest'
        // bilan qolib ketgan).
        final data = response.data;
        final payload = data is Map && data['data'] is Map
            ? Map<String, dynamic>.from(data['data'] as Map)
            : (data is Map ? Map<String, dynamic>.from(data) : null);
        final role = payload?['role'];
        if (role is String && role.isNotEmpty) {
          await _profileService.setRole(role);
        }
        final id = payload?['id'];
        if (id is int) {
          await _profileService.setProfileId(id);
        }
      }
      return ok;
    } on DioException {
      return false;
    } catch (_) {
      return false;
    }
  }
}
