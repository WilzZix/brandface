import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/notification/notification_entity.dart';
import 'package:brandface/domain/repository/notification_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

class MarkNotificationReadUseCase implements UseCase<NotificationEntity, int> {
  final INotificationRepository repository;

  MarkNotificationReadUseCase({required this.repository});

  @override
  Future<Either<Failure, NotificationEntity>> call({required int params}) {
    return repository.markAsRead(id: params);
  }
}
