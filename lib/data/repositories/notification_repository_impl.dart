import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/notification/notification_data_source.dart';
import 'package:brandface/domain/entities/notification/notification_entity.dart';
import 'package:brandface/domain/repository/notification_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class NotificationRepositoryImpl implements INotificationRepository {
  final NotificationDataSource _dataSource;

  NotificationRepositoryImpl({required NotificationDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    bool? isRead,
  }) async {
    try {
      final notifications = await _dataSource.getNotifications(isRead: isRead);
      return Right(notifications);
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, NotificationEntity>> markAsRead({
    required int id,
  }) async {
    try {
      final notification = await _dataSource.markAsRead(id: id);
      return Right(notification);
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> markAllAsRead() async {
    try {
      final markedCount = await _dataSource.markAllAsRead();
      return Right(markedCount);
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  ServerFailure _mapDioFailure(DioException e) {
    final responseData = e.response?.data;
    String message = e.message ?? 'Serverda xatolik yuz berdi';

    if (responseData is Map && responseData['message'] != null) {
      message = responseData['message'].toString();
    } else if (responseData is Map && responseData['detail'] != null) {
      message = responseData['detail'].toString();
    }

    return ServerFailure(
      message,
      statusCode: e.response?.statusCode,
      errorData: responseData,
    );
  }
}
