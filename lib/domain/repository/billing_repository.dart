import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:dart_either/dart_either.dart';

class AddBillingCardParams {
  final String cardType;
  final String lastFour;
  final int expiryMonth;
  final int expiryYear;
  final bool isDefault;
  final String gatewayToken;

  const AddBillingCardParams({
    required this.cardType,
    required this.lastFour,
    required this.expiryMonth,
    required this.expiryYear,
    required this.isDefault,
    required this.gatewayToken,
  });
}

class BoostProfileParams {
  final int packageId;
  final String paymentMethod;

  const BoostProfileParams({
    required this.packageId,
    required this.paymentMethod,
  });
}

class SubscribeBillingPlanParams {
  final int planId;
  final String paymentMethod;
  final int? cardId;

  const SubscribeBillingPlanParams({
    required this.planId,
    required this.paymentMethod,
    this.cardId,
  });
}

abstract class IBillingRepository {
  Future<Either<Failure, BillingDashboardEntity>> getBillingDashboard();

  Future<Either<Failure, BillingCardEntity>> addCard(
    AddBillingCardParams params,
  );

  Future<Either<Failure, BillingCardEntity>> setDefaultCard(int cardId);

  Future<Either<Failure, void>> deleteCard(int cardId);

  Future<Either<Failure, BillingSubscriptionEntity>> cancelSubscription();

  Future<Either<Failure, BillingTransactionEntity>> boostProfile(
    BoostProfileParams params,
  );

  Future<Either<Failure, BillingSubscriptionEntity>> subscribeToPlan(
    SubscribeBillingPlanParams params,
  );
}
