import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

final class DeleteBillingCardUseCase implements UseCase<void, int> {
  final IBillingRepository repository;

  DeleteBillingCardUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call({required int params}) {
    return repository.deleteCard(params);
  }
}
