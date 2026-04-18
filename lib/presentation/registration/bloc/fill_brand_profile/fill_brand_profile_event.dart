part of 'fill_brand_profile_bloc.dart';

@freezed
class FillBrandProfileEvent with _$FillBrandProfileEvent {
  const factory FillBrandProfileEvent.started() = _Started;

  const factory FillBrandProfileEvent.fillBrandProfile({
    required String profileId,
    required FillBrandProfileParam params,
  }) = _FillBrandProfile;
}
