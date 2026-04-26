import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

class BoostProfileUseCase
    implements UseCase<BillingTransactionEntity, BoostProfileParams> {
  final IBillingRepository repository;

  BoostProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, BillingTransactionEntity>> call({
    required BoostProfileParams params,
  }) {
    return repository.boostProfile(params);
  }
}
