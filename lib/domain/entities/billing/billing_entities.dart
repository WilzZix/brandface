import 'package:equatable/equatable.dart';

base class BillingPlanEntity extends Equatable {
  final int id;
  final String name;

  /// Which role this plan is for: `'brand'` or `'influencer'`. Used to only
  /// show the plans relevant to the current user's role.
  final String? audience;
  final bool trialAvailable;
  final int trialDays;
  final String? priceMonthlyUsd;
  final String? priceMonthlyUzs;
  final int maxOffersPerMonth;
  final int maxFindsPerMonth;
  final int aiMatchesCount;
  final int maxShortlist;
  final bool hasFullContactAccess;
  final bool hasAdvancedAnalytics;
  final bool hasPrioritySupport;
  final String? contactPriceUsd;
  final String? boostPriceUsd;
  final String? boostPriceUzs;
  final String? features;

  const BillingPlanEntity({
    required this.id,
    required this.name,
    this.audience,
    this.trialAvailable = false,
    this.trialDays = 0,
    this.priceMonthlyUsd,
    this.priceMonthlyUzs,
    this.maxOffersPerMonth = 0,
    this.maxFindsPerMonth = 0,
    this.aiMatchesCount = 0,
    this.maxShortlist = 0,
    this.hasFullContactAccess = false,
    this.hasAdvancedAnalytics = false,
    this.hasPrioritySupport = false,
    this.contactPriceUsd,
    this.boostPriceUsd,
    this.boostPriceUzs,
    this.features,
  });

  /// A plan can be paid through Paylov only when it has a UZS price.
  /// Backend rejects Paylov subscription for UZS-less plans
  /// (`400 plan_has_no_uzs_price`).
  bool get supportsPaylov {
    final uzs = priceMonthlyUzs?.trim();
    return uzs != null && uzs.isNotEmpty && (double.tryParse(uzs) ?? 0) > 0;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    audience,
    trialAvailable,
    trialDays,
    priceMonthlyUsd,
    priceMonthlyUzs,
    maxOffersPerMonth,
    maxFindsPerMonth,
    aiMatchesCount,
    maxShortlist,
    hasFullContactAccess,
    hasAdvancedAnalytics,
    hasPrioritySupport,
    contactPriceUsd,
    boostPriceUsd,
    boostPriceUzs,
    features,
  ];
}

base class BillingSubscriptionEntity extends Equatable {
  final int id;
  final BillingPlanEntity? plan;
  final String status;
  final DateTime? startedAt;
  final DateTime? expiresAt;
  final bool autoRenew;
  final int offersUsedThisMonth;
  final int findsUsedThisMonth;
  final DateTime? resetDate;

  /// Present when the subscription was created through a Paylov checkout link
  /// and still needs the user to complete payment.
  final int? transactionId;
  final String? paymentUrl;

  const BillingSubscriptionEntity({
    required this.id,
    this.plan,
    this.status = '',
    this.startedAt,
    this.expiresAt,
    this.autoRenew = false,
    this.offersUsedThisMonth = 0,
    this.findsUsedThisMonth = 0,
    this.resetDate,
    this.transactionId,
    this.paymentUrl,
  });

  bool get isActive => status.trim().isNotEmpty && status != 'cancelled';

  /// A checkout redirect is required when the backend returned a payment link
  /// (i.e. this is a `pending` subscription paid via checkout, not a saved card).
  bool get needsCheckout =>
      (paymentUrl?.trim().isNotEmpty ?? false) && status != 'active';

  @override
  List<Object?> get props => [
    id,
    plan,
    status,
    startedAt,
    expiresAt,
    autoRenew,
    offersUsedThisMonth,
    findsUsedThisMonth,
    resetDate,
    transactionId,
    paymentUrl,
  ];
}

class BillingCardEntity extends Equatable {
  final int id;
  final String cardType;
  final String name;
  final int expiryMonth;
  final int expiryYear;
  final bool isDefault;

  const BillingCardEntity({
    required this.id,
    required this.cardType,
    required this.name,
    required this.expiryMonth,
    required this.expiryYear,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [
    id,
    cardType,
    name,
    expiryMonth,
    expiryYear,
    isDefault,
  ];
}

base class BillingTransactionEntity extends Equatable {
  final int id;
  final String? planName;
  final String? amount;
  final String? currency;
  final String? paymentMethod;
  final String? transactionType;
  final String? status;
  final String? description;
  final String? paymentUrl;
  final DateTime? paidAt;
  final DateTime? createdAt;

  const BillingTransactionEntity({
    required this.id,
    this.planName,
    this.amount,
    this.currency,
    this.paymentMethod,
    this.transactionType,
    this.status,
    this.description,
    this.paymentUrl,
    this.paidAt,
    this.createdAt,
  });

  bool get isPaid => status == 'paid';

  @override
  List<Object?> get props => [
    id,
    planName,
    amount,
    currency,
    paymentMethod,
    transactionType,
    status,
    description,
    paymentUrl,
    paidAt,
    createdAt,
  ];
}

base class BillingBoostPackageEntity extends Equatable {
  final int id;
  final int days;
  final String label;
  final String? priceUzs;
  final String? priceUsd;
  final int sortOrder;

  const BillingBoostPackageEntity({
    required this.id,
    required this.days,
    required this.label,
    this.priceUzs,
    this.priceUsd,
    this.sortOrder = 0,
  });

  @override
  List<Object?> get props => [id, days, label, priceUzs, priceUsd, sortOrder];
}

base class BillingDashboardEntity extends Equatable {
  final BillingSubscriptionEntity? subscription;
  final List<BillingPlanEntity> plans;
  final List<BillingBoostPackageEntity> boostPackages;
  final List<BillingTransactionEntity> transactions;

  const BillingDashboardEntity({
    this.subscription,
    this.plans = const [],
    this.boostPackages = const [],
    this.transactions = const [],
  });

  @override
  List<Object?> get props => [
    subscription,
    plans,
    boostPackages,
    transactions,
  ];
}

/// Result of the first card-add step (`POST /cards/`): the card is not saved
/// yet, an OTP was sent to the phone bound to the card and must be confirmed.
class CardOtpInitEntity extends Equatable {
  /// Paylov's transient card id (UUID string) — pass it to the confirm step.
  final String cardId;

  /// Masked phone the OTP was delivered to, e.g. `********1234`.
  final String? otpSentPhone;

  const CardOtpInitEntity({required this.cardId, this.otpSentPhone});

  @override
  List<Object?> get props => [cardId, otpSentPhone];
}

/// Result of requesting/refreshing a Paylov checkout link for a pending
/// transaction (`POST /paylov/checkout/`).
class PaylovCheckoutEntity extends Equatable {
  final int transactionId;
  final String paymentUrl;

  const PaylovCheckoutEntity({
    required this.transactionId,
    required this.paymentUrl,
  });

  @override
  List<Object?> get props => [transactionId, paymentUrl];
}
