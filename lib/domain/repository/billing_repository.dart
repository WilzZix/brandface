import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:dart_either/dart_either.dart';

final class AddBillingCardParams {
  final String cardType;
  final String name;
  final int expiryMonth;
  final int expiryYear;
  final bool isDefault;
  final String gatewayToken;

  const AddBillingCardParams({
    required this.cardType,
    required this.name,
    required this.expiryMonth,
    required this.expiryYear,
    required this.isDefault,
    required this.gatewayToken,
  });

  /// Backend `card_type` accepts only `visa`, `mastercard`, `click`.
  /// Uzbek local and co-badge cards settle through Click, so they map
  /// to `click`; everything else falls back to its international network.
  static String cardTypeFromNumber(String cardNumber) {
    final digits = cardNumber.replaceAll(RegExp(r'\D'), '');
    const localPrefixes = {
      '8600',
      '9860',
      '9869',
      '5614',
      '5440',
      '5286',
      '5106',
    };
    if (digits.length >= 4 && localPrefixes.contains(digits.substring(0, 4))) {
      return 'click';
    }
    if (digits.startsWith('4')) return 'visa';
    if (digits.startsWith('5')) return 'mastercard';
    return 'click';
  }
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
