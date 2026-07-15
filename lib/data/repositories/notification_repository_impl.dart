import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/notification/notification_data_source.dart';
import 'package:brandface/domain/entities/notification/notification_entity.dart';
import 'package:brandface/domain/repository/notification_repository.dart';
import 'package:dart_either/dart_either.dart';

final class NotificationRepositoryImpl implements INotificationRepository {
  final NotificationDataSource _dataSource;

  NotificationRepositoryImpl({required NotificationDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    bool? isRead,
  }) {
    return guard(() => _dataSource.getNotifications(isRead: isRead));
  }

  @override
  Future<Either<Failure, NotificationEntity>> markAsRead({
    required int id,
  }) {
    return guard(() => _dataSource.markAsRead(id: id));
  }

  @override
  Future<Either<Failure, int>> markAllAsRead() {
    return guard(() => _dataSource.markAllAsRead());
  }
}
