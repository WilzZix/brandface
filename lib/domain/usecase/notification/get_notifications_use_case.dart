import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/notification/notification_entity.dart';
import 'package:brandface/domain/repository/notification_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

final class GetNotificationsUseCase
    implements UseCase<List<NotificationEntity>, bool?> {
  final INotificationRepository repository;

  GetNotificationsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<NotificationEntity>>> call({
    required bool? params,
  }) {
    return repository.getNotifications(isRead: params);
  }
}
