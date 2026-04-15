part of 'get_profile_cubit.dart';

@freezed
class GetProfileState with _$GetProfileState {
  const factory GetProfileState.initial() = _Initial;

  const factory GetProfileState.profileLoaded({
    required ProfileEntity profile,
  }) = _ProfileLoaded;

  const factory GetProfileState.profileLoadFailure({required Failure fl}) =
      _ProfileLoadFailure;

  const factory GetProfileState.profileLoading() = _ProfileLoading;
}
