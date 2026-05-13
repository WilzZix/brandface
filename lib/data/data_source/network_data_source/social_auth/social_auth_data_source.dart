import 'package:dio/dio.dart';

import '../../../../core/constants/api_routes.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../domain/entities/social_provider.dart';
import '../../../models/social_auth/social_auth_model.dart';

abstract class SocialAuthDataSource {
  Future<SocialAuthModel> socialLogin({
    required SocialProvider provider,
    required String accessToken,
    String? idToken,
  });

  Future<SocialAuthModel> linkedInCodeExchange({
    required String code,
    required String redirectUri,
  });
}

class SocialAuthDataSourceImpl implements SocialAuthDataSource {
  final DioClient _dioClient;

  SocialAuthDataSourceImpl(this._dioClient);

  @override
  Future<SocialAuthModel> socialLogin({
    required SocialProvider provider,
    required String accessToken,
    String? idToken,
  }) async {
    final body = <String, dynamic>{
      'provider': provider.apiValue,
      'access_token': accessToken,
    };
    if (idToken != null && idToken.isNotEmpty) {
      body['id_token'] = idToken;
    }

    final response = await _dioClient.post(ApiRoutes.socialAuth, data: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SocialAuthModel.fromJson(response.data as Map<String, dynamic>);
    }
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }

  @override
  Future<SocialAuthModel> linkedInCodeExchange({
    required String code,
    required String redirectUri,
  }) async {
    final response = await _dioClient.post(
      ApiRoutes.linkedinCode,
      data: {'code': code, 'redirect_uri': redirectUri},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SocialAuthModel.fromJson(response.data as Map<String, dynamic>);
    }
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }
}
