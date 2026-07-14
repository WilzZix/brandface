import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

/// Card registration step 2: confirm the OTP and persist the card.
final class ConfirmBillingCardUseCase
    implements UseCase<BillingCardEntity, ConfirmBillingCardParams> {
  final IBillingRepository repository;

  ConfirmBillingCardUseCase({required this.repository});

  @override
  Future<Either<Failure, BillingCardEntity>> call({
    required ConfirmBillingCardParams params,
  }) {
    return repository.confirmCard(params);
  }
}
