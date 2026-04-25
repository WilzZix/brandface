import 'package:brandface/core/network/interceptor/auth_interceptor.dart';
import 'package:brandface/core/network/interceptor/logger_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../utils/services/app_auth_local_service.dart';
import '../constants/api_routes.dart';

class DioClient {
  final Dio _dio;
  final IAuthLocalService _sharedPrefService;

  DioClient(this._dio, {required IAuthLocalService sharedPrefService})
    : _sharedPrefService = sharedPrefService {
    _dio
      ..options.baseUrl = ApiRoutes.baseUrl
      ..options.connectTimeout = const Duration(seconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 5)
      ..options.responseType = ResponseType.json
      ..interceptors.add(AuthInterceptor(_dio, _sharedPrefService))
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true))
      ..interceptors.addAll([
        InterceptorsWrapper(),
        if (kDebugMode) LoggerInterceptor(),
      ]);
  }

  // GET request
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT request (Ma'lumotni to'liq yangilash uchun)
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PATCH request (Ma'lumotni qisman yangilash uchun)
  Future<Response> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request (Ma'lumotni o'chirish uchun)
  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
