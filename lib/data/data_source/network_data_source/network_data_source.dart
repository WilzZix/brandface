import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<OtpModel> login({required String phone});
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final DioClient _dioClient;

  LoginRemoteDataSourceImpl(this._dioClient);

  @override
  Future<OtpModel> login({required String phone}) async {
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
}
