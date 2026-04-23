part of 'audience_cubit.dart';

@freezed
class AudienceState with _$AudienceState {
  const factory AudienceState.initial() = _Initial;

  const factory AudienceState.loading() = _Loading;

  const factory AudienceState.failure({required Failure failure}) = _Failure;

  const factory AudienceState.loaded({
    required SocialMediaAccountStatsEntity data,
  }) = _Loaded;
}
