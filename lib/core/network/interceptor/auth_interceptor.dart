import 'dart:async';

import 'package:brandface/core/constants/api_routes.dart';
import 'package:dio/dio.dart';

import '../../../utils/services/app_auth_local_service.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final IAuthLocalService _authLocalService;
  Future<String?>? _refreshFuture;

  AuthInterceptor(this._dio, this._authLocalService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _authLocalService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    final isUnauthorized = err.response?.statusCode == 401;
    final isRefreshCall = requestOptions.path.contains(ApiRoutes.refreshToken);
    final hasRetried = requestOptions.extra['hasRetried'] == true;

    if (!isUnauthorized || isRefreshCall || hasRetried) {
      return super.onError(err, handler);
    }

    final newAccessToken = await _refreshAccessToken();

    if (newAccessToken == null || newAccessToken.isEmpty) {
      await _authLocalService.clearCache();
      return super.onError(err, handler);
    }

    requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
    requestOptions.extra['hasRetried'] = true;

    try {
      final response = await _dio.fetch<dynamic>(requestOptions);
      return handler.resolve(response);
    } on DioException catch (retryError) {
      return super.onError(retryError, handler);
    }
  }

  Future<String?> _refreshAccessToken() async {
    if (_refreshFuture != null) {
      return _refreshFuture;
    }

    final completer = Completer<String?>();
    _refreshFuture = completer.future;

    final refreshToken = _authLocalService.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      completer.complete(null);
      _refreshFuture = null;
      return completer.future;
    }

    try {
      final response = await Dio(
        BaseOptions(
          baseUrl: ApiRoutes.baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          responseType: ResponseType.json,
        ),
      ).post(ApiRoutes.refreshToken, data: {'refresh': refreshToken});

      final payload = response.data;
      final root = payload is Map<String, dynamic>
          ? payload
          : payload is Map
          ? Map<String, dynamic>.from(payload)
          : <String, dynamic>{};
      final data = root['data'] is Map<String, dynamic>
          ? root['data'] as Map<String, dynamic>
          : root['data'] is Map
          ? Map<String, dynamic>.from(root['data'])
          : root;

      final accessToken =
          data['access']?.toString() ?? data['access_token']?.toString();
      final nextRefreshToken =
          data['refresh']?.toString() ??
          data['refresh_token']?.toString() ??
          refreshToken;

      if (accessToken == null || accessToken.isEmpty) {
        completer.complete(null);
      } else {
        await _authLocalService.saveTokens(
          accessToken: accessToken,
          refreshToken: nextRefreshToken,
        );
        completer.complete(accessToken);
      }
    } catch (_) {
      completer.complete(null);
    } finally {
      _refreshFuture = null;
    }

    return completer.future;
  }
}
