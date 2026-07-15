import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

import 'failures.dart';

/// Single place that turns a raw exception thrown by the data-source layer
/// into a domain [Failure].
///
/// The data-source layer must stay unaware of [Either]/[Failure]; it only
/// returns data or throws the raw error. Repositories delegate the mapping
/// here instead of hand-rolling their own `try/catch` blocks — see [guard].
Failure mapExceptionToFailure(Object error, [StackTrace? stackTrace]) {
  if (error is DioException) {
    return _mapDioException(error);
  }
  if (error is FormatException || error is TypeError) {
    return ParsingFailure('Ma\'lumotni o\'qishda xatolik: $error');
  }
  return ServerFailure('Tizim xatoligi: $error');
}

Failure _mapDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const NetworkFailure('Internet aloqasi sekin yoki uzilib qoldi.');
    case DioExceptionType.connectionError:
      return const NetworkFailure('Internetga ulanib bo\'lmadi.');
    case DioExceptionType.cancel:
      return const NetworkFailure('So\'rov bekor qilindi.');
    case DioExceptionType.badCertificate:
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      final data = e.response?.data;
      return ServerFailure(
        _extractServerMessage(data) ??
            e.message ??
            'Serverda xatolik yuz berdi',
        statusCode: e.response?.statusCode,
        errorData: data,
      );
  }
}

/// Pulls the human-readable error out of the backend's response envelope.
///
/// Handles the shapes the API actually returns:
///  * `{"message": "..."}`
///  * `{"detail": "..."}`
///  * `{"detail": {"message": "..."}}`
///  * validation errors: `{"errors": {"field": ["msg", ...]}}` — possibly
///    nested under `detail` — where we surface the first field message instead
///    of dumping the whole map.
String? _extractServerMessage(dynamic data) {
  if (data is! Map) return null;

  final message = data['message'];
  if (message is String && message.trim().isNotEmpty) return message;

  final detail = data['detail'];

  final fieldError = _firstFieldError(
    data['errors'] ?? (detail is Map ? detail['errors'] : null),
  );
  if (fieldError != null) return fieldError;

  if (detail is String && detail.trim().isNotEmpty) return detail;
  if (detail is Map) {
    final detailMessage = detail['message'];
    if (detailMessage is String && detailMessage.trim().isNotEmpty) {
      return detailMessage;
    }
  }
  return null;
}

/// Returns the first message from a `{field: [msg, ...]}` validation-errors map.
String? _firstFieldError(dynamic errors) {
  if (errors is Map) {
    for (final value in errors.values) {
      if (value is List && value.isNotEmpty) return value.first.toString();
      if (value is String && value.trim().isNotEmpty) return value;
    }
  }
  return null;
}

/// Runs a data-source call and wraps the outcome in an [Either], mapping any
/// thrown exception to a [Failure]. Repositories should express every method
/// as `guard(() => _dataSource.foo())` (optionally transforming the result
/// inside the callback) instead of writing their own `try/catch`.
Future<Either<Failure, T>> guard<T>(Future<T> Function() body) async {
  try {
    return Right(await body());
  } catch (error, stackTrace) {
    return Left(mapExceptionToFailure(error, stackTrace));
  }
}
