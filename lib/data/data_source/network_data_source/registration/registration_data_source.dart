import 'package:brandface/domain/usecase/registration/params/registration_params.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../../../models/registration/registration_model.dart';

abstract class RegistrationDataSource {
  Future<RegistrationModel> registration({required RegistrationParams params});
}

class RegistrationDataSourceImpl implements RegistrationDataSource {
  final DioClient _dioClient;

  RegistrationDataSourceImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<RegistrationModel> registration({required RegistrationParams params}) async {
    try {
      final response = await _dioClient.post('register/influencer/', data: params.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegistrationModel.fromJson(response.data);
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
