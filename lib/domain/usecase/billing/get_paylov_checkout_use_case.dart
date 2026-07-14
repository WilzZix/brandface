import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

/// Re-fetches a Paylov checkout link for an existing pending transaction.
final class GetPaylovCheckoutUseCase
    implements UseCase<PaylovCheckoutEntity, PaylovCheckoutParams> {
  final IBillingRepository repository;

  GetPaylovCheckoutUseCase({required this.repository});

  @override
  Future<Either<Failure, PaylovCheckoutEntity>> call({
    required PaylovCheckoutParams params,
  }) {
    return repository.getPaylovCheckout(params);
  }
}
