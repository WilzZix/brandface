part of 'fill_profile_bloc.dart';

@freezed
class FillProfileEvent with _$FillProfileEvent {
  const factory FillProfileEvent.started() = _Started;

  const factory FillProfileEvent.fillProfile({
    required String profile,
    required FillInfluencerProfileParam params,
  }) = _FillProfile;
}
