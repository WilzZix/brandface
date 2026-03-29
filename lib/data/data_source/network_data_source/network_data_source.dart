import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../../models/otp_model.dart';
import '../../models/verifying_otp_model.dart';

abstract class LoginRemoteDataSource {
  Future<OtpModel> sendOtp({required String phone});

  Future<VerifyOtpModel> verifyOtp({required String phone, required String code});
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final DioClient _dioClient;

  LoginRemoteDataSourceImpl(this._dioClient);

  @override
  Future<OtpModel> sendOtp({required String phone}) async {
    try {
      final response = await _dioClient.post('auth/send-otp/', data: {'phone_number': phone});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return OtpModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyOtpModel> verifyOtp({required String phone, required String code}) async {
    try {
      final response = await _dioClient.post('auth/verify-otp/', data: {'phone_number': phone, "code": code});

      if (response.statusCode == 200 || response.statusCode == 201) {
        return VerifyOtpModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
