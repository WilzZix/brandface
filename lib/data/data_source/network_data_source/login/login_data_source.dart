import 'package:brandface/domain/usecase/login/params/verify_otp_params.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../../../models/login/otp_model.dart';
import '../../../models/login/verifying_otp_model.dart';

abstract class LoginRemoteDataSource {
  Future<OtpModel> sendOtp({required String phone});

  Future<VerifyOtpModel> verifyOtp({required VerifyOtpParams params});
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
  Future<VerifyOtpModel> verifyOtp({required VerifyOtpParams params}) async {
    try {
      final response = await _dioClient.post('auth/verify-otp/', data: params.toJson());

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
