import 'dart:convert' show JsonEncoder, LineSplitter;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
import '../../../utils/services/app_auth_local_service.dart';

final class LoggerInterceptor extends Interceptor {
  final IAuthLocalService _authLocalService;
  final Dio dio;

  LoggerInterceptor({
    required IAuthLocalService authLocalService,
    required this.dio,
  }) : _authLocalService = authLocalService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (kDebugMode) {
      final buffer = StringBuffer();
      buffer.writeln();
      buffer.writeln('│══════════════════ [ REQUEST ] ══════════════════');
      buffer.writeln('│ ➡️ METHOD: ${options.method}');
      buffer.writeln('│ 🌍 URL: ${options.uri}');
      buffer.writeln('│ 📦 HEADERS:');
      _writePrefixed(buffer, '│   ', options.headers);
      if (options.data != null) {
        buffer.writeln('│ 🧾 BODY:');
        _writePrefixed(buffer, '│   ', options.data);
      }
      buffer.writeln('│ 🕒 TIMESTAMP: ${DateTime.now().toIso8601String()}');
      buffer.writeln('│═════════════════════════════════════════════════');
      _printer(buffer.toString(), _LogColor.blue);
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      final buffer = StringBuffer();
      buffer.writeln();
      buffer.writeln('│══════════════════ [ ERROR ] ══════════════════');
      buffer.writeln('│ 🌍 URL: ${err.requestOptions.uri}');
      buffer.writeln('│ ❌ MESSAGE: ${err.message}');
      buffer.writeln('│ ⚠️ STATUS: ${err.response?.statusCode ?? '-'}');
      buffer.writeln('│ 📦 RESPONSE:');
      _writePrefixed(buffer, '│   ', err.response?.data);
      buffer.writeln('│ 🕒 TIMESTAMP: ${DateTime.now().toIso8601String()}');
      buffer.writeln('│═══════════════════════════════════════════════');
      _printer(buffer.toString(), _LogColor.red);
    }

    if (err.response?.statusCode == 401) {
      if (err.requestOptions.path.contains('auth/refresh-token')) {
        return super.onError(err, handler);
      }

      final refreshToken = _authLocalService.getRefreshToken();
      if (refreshToken != null) {
        try {
          final response = await _refreshAccessToken(refreshToken);

          final String newAccess = response.data['data']?['access'];

          // Yangi tokenlarni saqlash
          await _authLocalService.saveTokens(
            accessToken: newAccess,
            refreshToken: '',
          );

          // Eskirgan so'rovni yangi token bilan qayta yuborish
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newAccess';

          final clonedResponse = await dio.fetch(opts);
          return handler.resolve(clonedResponse);
        } catch (e) {
          // Agar refresh ham o'xshasa (masalan login eskirgan), logout qilish kerak
          await _authLocalService.clearCache();
          return super.onError(err, handler);
        }
      }
    }

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      final buffer = StringBuffer();
      buffer.writeln();
      buffer.writeln('│══════════════════ [ RESPONSE ] ══════════════════');
      buffer.writeln('│ ✅ STATUS: ${response.statusCode}');
      buffer.writeln('│ 🌍 URL: ${response.requestOptions.uri}');
      buffer.writeln('│ 📦 DATA:');
      _writePrefixed(buffer, '│   ', response.data);
      buffer.writeln('│ 🕒 TIMESTAMP: ${DateTime.now().toIso8601String()}');
      buffer.writeln('│══════════════════════════════════════════════════');
      _printer(buffer.toString(), _LogColor.green);
    }
    super.onResponse(response, handler);
  }

  // Alohida Dio instance orqali refresh qilish (asosiy interseptorga tushmasligi uchun)
  Future<Response> _refreshAccessToken(String refreshToken) async {
    return await Dio().post(
      'https://api.influerax.com/api/accounts/v1/auth/refresh-token/',
      data: {'refresh': refreshToken},
    );
  }

  void _writePrefixed(StringBuffer sb, String prefix, dynamic data) {
    String text = '';
    try {
      text = const JsonEncoder.withIndent('  ').convert(data ?? {});
    } catch (_) {
      text = data?.toString() ?? '';
    }
    final lines = LineSplitter.split(text);
    for (final line in lines) {
      sb.writeln('$prefix$line');
    }
  }

  void _printer(String text, _LogColor colorType) {
    debugPrint('${colorType.color}$text${_LogColor.reset.color}');
  }
}

enum _LogColor {
  green('\x1B[32m'),
  yellow('\x1B[33m'),
  red('\x1B[31m'),
  blue('\x1B[94m'),
  reset('\x1B[0m');

  final String color;

  const _LogColor(this.color);
}
