import 'package:equatable/equatable.dart';

class BillingPlanEntity extends Equatable {
  final int id;
  final String name;
  final String? priceMonthlyUsd;
  final int maxOffersPerMonth;
  final int maxFindsPerMonth;
  final int aiMatchesCount;
  final int maxShortlist;
  final bool hasFullContactAccess;
  final bool hasAdvancedAnalytics;
  final bool hasPrioritySupport;
  final String? contactPriceUsd;
  final String? boostPriceUsd;
  final String? features;

  const BillingPlanEntity({
    required this.id,
    required this.name,
    this.priceMonthlyUsd,
    this.maxOffersPerMonth = 0,
    this.maxFindsPerMonth = 0,
    this.aiMatchesCount = 0,
    this.maxShortlist = 0,
    this.hasFullContactAccess = false,
    this.hasAdvancedAnalytics = false,
    this.hasPrioritySupport = false,
    this.contactPriceUsd,
    this.boostPriceUsd,
    this.features,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    priceMonthlyUsd,
    maxOffersPerMonth,
    maxFindsPerMonth,
    aiMatchesCount,
    maxShortlist,
    hasFullContactAccess,
    hasAdvancedAnalytics,
    hasPrioritySupport,
    contactPriceUsd,
    boostPriceUsd,
    features,
  ];
}

class BillingSubscriptionEntity extends Equatable {
  final int id;
  final BillingPlanEntity? plan;
  final String status;
  final DateTime? startedAt;
  final DateTime? expiresAt;
  final bool autoRenew;
  final int offersUsedThisMonth;
  final int findsUsedThisMonth;
  final DateTime? resetDate;

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
  });

  bool get isActive => status.trim().isNotEmpty && status != 'cancelled';

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

class BillingTransactionEntity extends Equatable {
  final int id;
  final String? planName;
  final String? amount;
  final String? currency;
  final String? paymentMethod;
  final String? transactionType;
  final String? status;
  final String? description;
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
    this.paidAt,
    this.createdAt,
  });

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
    paidAt,
    createdAt,
  ];
}

class BillingBoostPackageEntity extends Equatable {
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

class BillingDashboardEntity extends Equatable {
  final BillingSubscriptionEntity? subscription;
  final List<BillingPlanEntity> plans;
  final List<BillingBoostPackageEntity> boostPackages;
  final List<BillingCardEntity> cards;
  final List<BillingTransactionEntity> transactions;

  const BillingDashboardEntity({
    this.subscription,
    this.plans = const [],
    this.boostPackages = const [],
    this.cards = const [],
    this.transactions = const [],
  });

  BillingCardEntity? get defaultCard {
    for (final card in cards) {
      if (card.isDefault) {
        return card;
      }
    }

    return cards.isEmpty ? null : cards.first;
  }

  @override
  List<Object?> get props => [
    subscription,
    plans,
    boostPackages,
    cards,
    transactions,
  ];
}
