import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/services/shared_pref_service.dart';

part 'init_app_state.dart';

part 'init_app_cubit.freezed.dart';

class InitAppCubit extends Cubit<InitAppState> {
  InitAppCubit({required IAuthLocalService sharedPrefService})
    : _sharedPrefService = sharedPrefService,
      super(const InitAppState.initial());
  final IAuthLocalService _sharedPrefService;

  Future<void> initApp() async {
    await Future.delayed(Duration(seconds: 3));
    emit(InitAppState.appInitialized(_sharedPrefService.isLoggedIn()));
  }
}
