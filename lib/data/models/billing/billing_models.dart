import 'package:brandface/domain/entities/billing/billing_entities.dart';

final class BillingPlanModel extends BillingPlanEntity {
  const BillingPlanModel({
    required super.id,
    required super.name,
    super.audience,
    super.trialAvailable,
    super.trialDays,
    super.priceMonthlyUsd,
    super.priceMonthlyUzs,
    super.maxOffersPerMonth,
    super.maxFindsPerMonth,
    super.aiMatchesCount,
    super.maxShortlist,
    super.hasFullContactAccess,
    super.hasAdvancedAnalytics,
    super.hasPrioritySupport,
    super.contactPriceUsd,
    super.boostPriceUsd,
    super.boostPriceUzs,
    super.features,
  });

  factory BillingPlanModel.fromJson(Map<String, dynamic> json) {
    return BillingPlanModel(
      id: _toInt(json['id']),
      name: json['name']?.toString() ?? 'Plan',
      audience: _nullableString(json['audience']),
      trialAvailable: json['trial_available'] == true,
      trialDays: _toInt(json['trial_days']),
      priceMonthlyUsd: _nullableString(json['price_monthly_usd']),
      priceMonthlyUzs: _nullableString(json['price_monthly_uzs']),
      maxOffersPerMonth: _toInt(json['max_offers_per_month']),
      maxFindsPerMonth: _toInt(json['max_finds_per_month']),
      aiMatchesCount: _toInt(json['ai_matches_count']),
      maxShortlist: _toInt(json['max_shortlist']),
      hasFullContactAccess: json['has_full_contact_access'] == true,
      hasAdvancedAnalytics: json['has_advanced_analytics'] == true,
      hasPrioritySupport: json['has_priority_support'] == true,
      contactPriceUsd: _nullableString(json['contact_price_usd']),
      boostPriceUsd: _nullableString(json['boost_price_usd']),
      boostPriceUzs: _nullableString(json['boost_price_uzs']),
      features: _nullableString(json['features']),
    );
  }
}

final class BillingSubscriptionModel extends BillingSubscriptionEntity {
  const BillingSubscriptionModel({
    required super.id,
    super.plan,
    super.status,
    super.startedAt,
    super.expiresAt,
    super.autoRenew,
    super.offersUsedThisMonth,
    super.findsUsedThisMonth,
    super.resetDate,
    super.transactionId,
    super.paymentUrl,
  });

  factory BillingSubscriptionModel.fromJson(Map<String, dynamic> json) {
    final planJson = _readMap(json['plan']);
    return BillingSubscriptionModel(
      id: _toInt(json['id']),
      plan: planJson.isEmpty ? null : BillingPlanModel.fromJson(planJson),
      status: json['status']?.toString() ?? '',
      startedAt: _toDateTime(json['started_at']),
      expiresAt: _toDateTime(json['expires_at']),
      autoRenew: json['auto_renew'] == true,
      offersUsedThisMonth: _toInt(json['offers_used_this_month']),
      findsUsedThisMonth: _toInt(json['finds_used_this_month']),
      resetDate: _toDateTime(json['reset_date']),
      transactionId: json['transaction_id'] == null
          ? null
          : _toInt(json['transaction_id']),
      paymentUrl: _nullableString(json['payment_url']),
    );
  }
}

class BillingCardModel extends BillingCardEntity {
  const BillingCardModel({
    required super.id,
    required super.cardType,
    required super.name,
    required super.expiryMonth,
    required super.expiryYear,
    super.isDefault,
  });

  factory BillingCardModel.fromJson(Map<String, dynamic> json) {
    return BillingCardModel(
      id: _toInt(json['id']),
      cardType: json['card_type']?.toString() ?? 'visa',
      name: json['name']?.toString() ?? '',
      expiryMonth: _toInt(json['expiry_month']),
      expiryYear: _toInt(json['expiry_year']),
      isDefault: json['is_default'] == true,
    );
  }
}

final class BillingTransactionModel extends BillingTransactionEntity {
  const BillingTransactionModel({
    required super.id,
    super.planName,
    super.amount,
    super.currency,
    super.paymentMethod,
    super.transactionType,
    super.status,
    super.description,
    super.paymentUrl,
    super.paidAt,
    super.createdAt,
  });

  factory BillingTransactionModel.fromJson(Map<String, dynamic> json) {
    return BillingTransactionModel(
      id: _toInt(json['id']),
      planName: _nullableString(json['plan_name']),
      amount: _nullableString(json['amount']),
      currency: _nullableString(json['currency']),
      paymentMethod: _nullableString(json['payment_method']),
      transactionType: _nullableString(json['transaction_type']),
      status: _nullableString(json['status']),
      description: _nullableString(json['description']),
      paymentUrl: _nullableString(json['payment_url']),
      paidAt: _toDateTime(json['paid_at']),
      createdAt: _toDateTime(json['created_at']),
    );
  }
}

final class BillingBoostPackageModel extends BillingBoostPackageEntity {
  const BillingBoostPackageModel({
    required super.id,
    required super.days,
    required super.label,
    super.priceUzs,
    super.priceUsd,
    super.sortOrder,
  });

  factory BillingBoostPackageModel.fromJson(Map<String, dynamic> json) {
    return BillingBoostPackageModel(
      id: _toInt(json['id']),
      days: _toInt(json['days']),
      label: json['label']?.toString() ?? 'Boost package',
      priceUzs: _nullableString(json['price_uzs']),
      priceUsd: _nullableString(json['price_usd']),
      sortOrder: _toInt(json['sort_order']),
    );
  }
}

final class BillingDashboardModel extends BillingDashboardEntity {
  const BillingDashboardModel({
    super.subscription,
    super.plans,
    super.boostPackages,
    super.transactions,
  });
}

final class CardOtpInitModel extends CardOtpInitEntity {
  const CardOtpInitModel({required super.cardId, super.otpSentPhone});

  factory CardOtpInitModel.fromJson(Map<String, dynamic> json) {
    return CardOtpInitModel(
      cardId: json['card_id']?.toString() ?? '',
      otpSentPhone: _nullableString(json['otp_sent_phone']),
    );
  }
}

final class PaylovCheckoutModel extends PaylovCheckoutEntity {
  const PaylovCheckoutModel({
    required super.transactionId,
    required super.paymentUrl,
  });

  factory PaylovCheckoutModel.fromJson(Map<String, dynamic> json) {
    return PaylovCheckoutModel(
      transactionId: _toInt(json['transaction_id']),
      paymentUrl: json['payment_url']?.toString() ?? '',
    );
  }
}

Map<String, dynamic> _readMap(dynamic value) {
  if (value is Map<String, dynamic>) {
    return value;
  }

  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }

  return <String, dynamic>{};
}

int _toInt(dynamic value) {
  if (value is int) {
    return value;
  }

  return int.tryParse(value?.toString() ?? '') ?? 0;
}

String? _nullableString(dynamic value) {
  final text = value?.toString().trim();
  if (text == null || text.isEmpty || text == 'null') {
    return null;
  }

  return text;
}

DateTime? _toDateTime(dynamic value) {
  if (value == null) {
    return null;
  }

  return DateTime.tryParse(value.toString());
}
