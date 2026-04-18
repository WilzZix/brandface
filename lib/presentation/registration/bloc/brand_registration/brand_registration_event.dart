part of 'brand_registration_bloc.dart';

@freezed
class BrandRegistrationEvent with _$BrandRegistrationEvent {
  const factory BrandRegistrationEvent.started() = _Started;

  const factory BrandRegistrationEvent.register({
    required BrandRegistrationParams params,
  }) = _Register;
}
