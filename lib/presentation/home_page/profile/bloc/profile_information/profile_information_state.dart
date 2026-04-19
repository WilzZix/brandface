part of 'profile_information_cubit.dart';

@freezed
class ProfileInformationState with _$ProfileInformationState {
  const factory ProfileInformationState.initial() = _Initial;

  const factory ProfileInformationState.loading() = _Loading;

  const factory ProfileInformationState.infoLoaded({
    required InfluencerProfileInformationEntity data,
  }) = _Loaded;

  const factory ProfileInformationState.failure(
      {required Failure failure}) = _Failure;
}
