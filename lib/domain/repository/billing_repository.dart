import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:dart_either/dart_either.dart';

/// Step 1: submit card details, trigger the OTP.
final class InitBillingCardParams {
  final String cardNumber;
  final int expiryMonth;
  final int expiryYear;

  /// Card holder name — the backend stores it on the pending card here and
  /// validates it again on confirm, so it must be sent at this step.
  final String cardName;
  final String? phoneNumber;

  const InitBillingCardParams({
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cardName,
    this.phoneNumber,
  });
}

/// Step 2: confirm the OTP and persist the card token.
final class ConfirmBillingCardParams {
  final String cardId;
  final String otp;

  /// Card holder name — required by the backend on confirm.
  final String cardName;
  final bool isDefault;

  const ConfirmBillingCardParams({
    required this.cardId,
    required this.otp,
    required this.cardName,
    this.isDefault = false,
  });
}

class BoostProfileParams {
  final int packageId;
  final String paymentMethod;

  /// Where Paylov returns the user after a checkout payment. Ignored when
  /// [cardId] is set (saved card charges immediately).
  final String? returnUrl;

  /// A saved card to charge immediately, skipping the checkout link.
  final int? cardId;

  const BoostProfileParams({
    required this.packageId,
    required this.paymentMethod,
    this.returnUrl,
    this.cardId,
  });
}

class SubscribeBillingPlanParams {
  final int planId;
  final String paymentMethod;
  final String? returnUrl;
  final int? cardId;

  const SubscribeBillingPlanParams({
    required this.planId,
    required this.paymentMethod,
    this.returnUrl,
    this.cardId,
  });
}

class PaylovCheckoutParams {
  final int transactionId;
  final String? returnUrl;

  const PaylovCheckoutParams({required this.transactionId, this.returnUrl});
}

abstract class IBillingRepository {
  Future<Either<Failure, BillingDashboardEntity>> getBillingDashboard();

  Future<Either<Failure, List<BillingCardEntity>>> getCards();

  /// Step 1 of card registration — returns the transient card id + masked phone.
  Future<Either<Failure, CardOtpInitEntity>> initCard(
    InitBillingCardParams params,
  );

  /// Step 2 of card registration — confirms the OTP and returns the saved card.
  Future<Either<Failure, BillingCardEntity>> confirmCard(
    ConfirmBillingCardParams params,
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

  Future<Either<Failure, PaylovCheckoutEntity>> getPaylovCheckout(
    PaylovCheckoutParams params,
  );
}
