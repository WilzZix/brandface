part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.started() = _Started;

  const factory LoginEvent.sendOtp({required String phone}) = _SendOtp;

  const factory LoginEvent.verifyOtp({required VerifyOtpParams params}) = _VerifyOtp;
}
