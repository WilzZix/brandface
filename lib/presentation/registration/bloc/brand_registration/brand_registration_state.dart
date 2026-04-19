part of 'brand_registration_bloc.dart';

@freezed
class BrandRegistrationState with _$BrandRegistrationState {
  const factory BrandRegistrationState.initial() = _Initial;

  const factory BrandRegistrationState.loading() = _Loading;

  const factory BrandRegistrationState.registered({
    required RegistrationEntity entity,
  }) = _Registered;

  const factory BrandRegistrationState.failure({required Failure failure}) =
      _Failure;
}
