final class VerifyOtpParams {
  final String phone;
  final String code;

  VerifyOtpParams({required this.phone, required this.code});

  Map<String, dynamic> toJson() {
    return {'phone_number': phone, 'code': code};
  }
}
