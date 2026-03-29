part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;

  ///OTP
  const factory LoginState.otpReceiving() = _OtpReceiving;

  const factory LoginState.otpReceived({required OtpEntity otpEntity}) = _OtpReceived;

  const factory LoginState.otpReceivingFailure({required String msg}) = _OtpReceivingFailure;
}
