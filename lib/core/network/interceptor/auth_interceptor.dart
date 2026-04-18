import 'package:dio/dio.dart';

import '../../../utils/services/app_auth_local_service.dart';

class AuthInterceptor extends Interceptor {
  final IAuthLocalService _authLocalService;

  AuthInterceptor(this._authLocalService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _authLocalService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
