import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

final class GetBillingCardsUseCase
    implements UseCase<List<BillingCardEntity>, Object?> {
  final IBillingRepository repository;

  GetBillingCardsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<BillingCardEntity>>> call({
    required Object? params,
  }) {
    return repository.getCards();
  }
}
