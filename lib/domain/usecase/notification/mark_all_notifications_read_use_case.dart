import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/repository/notification_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

class MarkAllNotificationsReadUseCase implements UseCase<int, void> {
  final INotificationRepository repository;

  MarkAllNotificationsReadUseCase({required this.repository});

  @override
  Future<Either<Failure, int>> call({required void params}) {
    return repository.markAllAsRead();
  }
}
