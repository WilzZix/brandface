part of 'init_app_cubit.dart';

@freezed
class InitAppState with _$InitAppState {
  const factory InitAppState.initial() = _Initial;

  const factory InitAppState.appInitialized(bool isLoggedIn, {String? role}) = _AppInitialized;
}
