part of 'registration_bloc.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState.initial() = _Initial;

  ///Registration
  const factory RegistrationState.userRegistered({required RegistrationEntity registerEntity}) = _UserRegistered;

  const factory RegistrationState.userRegistering() = _UserRegistering;

  const factory RegistrationState.userRegisterFailure({required String msg}) = _UserRegisterFailure;
}
