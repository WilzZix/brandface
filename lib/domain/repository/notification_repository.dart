import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/notification/notification_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract class INotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    bool? isRead,
  });

  Future<Either<Failure, NotificationEntity>> markAsRead({required int id});

  Future<Either<Failure, int>> markAllAsRead();
}
