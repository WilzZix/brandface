part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.started() = _Started;

  const factory LoginEvent.sendOtp({required String phone}) = _SendOtp;

  const factory LoginEvent.verifyOtp({required VerifyOtpParams params}) = _VerifyOtp;

  const factory LoginEvent.socialLogin({
    required SocialProvider provider,
    required BuildContext context,
  }) = _SocialLogin;

  const factory LoginEvent.reset() = _Reset;
}
