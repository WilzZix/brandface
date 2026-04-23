import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/services/app_auth_local_service.dart';
import '../../../utils/services/profile_service.dart';

part 'init_app_state.dart';

part 'init_app_cubit.freezed.dart';

class InitAppCubit extends Cubit<InitAppState> {
  InitAppCubit({
    required IAuthLocalService sharedPrefService,
    required ProfileService profileService,
  }) : _sharedPrefService = sharedPrefService,
       _profileService = profileService,
       super(const InitAppState.initial());

  final IAuthLocalService _sharedPrefService;
  final ProfileService _profileService;

  Future<void> initApp() async {
    await Future.delayed(Duration(seconds: 3));
    emit(InitAppState.appInitialized(
      _sharedPrefService.isLoggedIn(),
      role: _profileService.getRole(),
    ));
  }
}
