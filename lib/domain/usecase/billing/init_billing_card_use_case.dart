import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

/// Card registration step 1: submit card details, receive the OTP challenge.
final class InitBillingCardUseCase
    implements UseCase<CardOtpInitEntity, InitBillingCardParams> {
  final IBillingRepository repository;

  InitBillingCardUseCase({required this.repository});

  @override
  Future<Either<Failure, CardOtpInitEntity>> call({
    required InitBillingCardParams params,
  }) {
    return repository.initCard(params);
  }
}
