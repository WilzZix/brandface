import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/models/billing/billing_models.dart';

/// Step 1 of card registration (`POST /cards/`): card details are sent to
/// Paylov and an OTP is delivered to the card's phone. The card is not saved.
final class InitCardRequest {
  final String cardNumber;
  final int expiryMonth;
  final int expiryYear;
  final String cardName;
  final String? phoneNumber;

  const InitCardRequest({
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cardName,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_number': cardNumber,
      'expiry_month': expiryMonth,
      'expiry_year': expiryYear,
      // Backend stores the holder name on the pending card (field key
      // `cardName`) and re-validates it on confirm.
      'cardName': cardName,
      if (phoneNumber != null && phoneNumber!.trim().isNotEmpty)
        'phone_number': phoneNumber!.trim(),
    };
  }
}

/// Step 2 of card registration (`POST /cards/confirm/`): confirm the OTP and
/// persist the card token.
final class ConfirmCardRequest {
  final String cardId;
  final String otp;
  final String cardName;
  final bool isDefault;

  const ConfirmCardRequest({
    required this.cardId,
    required this.otp,
    required this.cardName,
    this.isDefault = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_id': cardId,
      'otp': otp,
      // Backend requires the card holder name (field key `cardName`).
      'cardName': cardName,
      'is_default': isDefault,
    };
  }
}

abstract interface class BillingDataSource {
  Future<BillingSubscriptionModel?> getMySubscription();

  Future<List<BillingPlanModel>> getPlans();

  Future<List<BillingBoostPackageModel>> getBoostPackages();

  Future<List<BillingCardModel>> getCards();

  Future<CardOtpInitModel> initCard(InitCardRequest request);

  Future<BillingCardModel> confirmCard(ConfirmCardRequest request);

  Future<BillingCardModel> setDefaultCard(int cardId);

  Future<void> deleteCard(int cardId);

  Future<List<BillingTransactionModel>> getTransactions();

  Future<BillingSubscriptionModel> cancelSubscription();

  Future<BillingTransactionModel> boostProfile({
    required int packageId,
    required String paymentMethod,
    String? returnUrl,
    int? cardId,
  });

  Future<BillingSubscriptionModel> subscribeToPlan({
    required int planId,
    required String paymentMethod,
    String? returnUrl,
    int? cardId,
  });

  Future<PaylovCheckoutModel> getPaylovCheckout({
    required int transactionId,
    String? returnUrl,
  });
}

final class BillingDataSourceImpl implements BillingDataSource {
  final DioClient _dioClient;

  BillingDataSourceImpl(this._dioClient);

  @override
  Future<BillingSubscriptionModel?> getMySubscription() async {
    final response = await _dioClient.get(ApiRoutes.mySubscription);
    final map = _extractMapOrNull(response.data);
    if (map == null || map.isEmpty) {
      return null;
    }

    return BillingSubscriptionModel.fromJson(map);
  }

  @override
  Future<List<BillingPlanModel>> getPlans() async {
    final response = await _dioClient.get(ApiRoutes.billingPlans);
    return _extractList(
      response.data,
    ).map((item) => BillingPlanModel.fromJson(_readMap(item))).toList();
  }

  @override
  Future<List<BillingBoostPackageModel>> getBoostPackages() async {
    final response = await _dioClient.get(ApiRoutes.boostPackages);
    return _extractList(
      response.data,
    ).map((item) => BillingBoostPackageModel.fromJson(_readMap(item))).toList();
  }

  @override
  Future<List<BillingCardModel>> getCards() async {
    final response = await _dioClient.get(ApiRoutes.billingCards);
    return _extractList(
      response.data,
    ).map((item) => BillingCardModel.fromJson(_readMap(item))).toList();
  }

  @override
  Future<CardOtpInitModel> initCard(InitCardRequest request) async {
    final response = await _dioClient.post(
      ApiRoutes.billingCards,
      data: request.toJson(),
    );
    return CardOtpInitModel.fromJson(_extractMap(response.data));
  }

  @override
  Future<BillingCardModel> confirmCard(ConfirmCardRequest request) async {
    final response = await _dioClient.post(
      ApiRoutes.billingCardsConfirm,
      data: request.toJson(),
    );
    return BillingCardModel.fromJson(_extractMap(response.data));
  }

  @override
  Future<BillingCardModel> setDefaultCard(int cardId) async {
    // Backend marks the card as default from this flag; a bodyless PATCH is a
    // no-op, so the payload must carry it explicitly.
    final response = await _dioClient.patch(
      ApiRoutes.billingCard(cardId),
      data: {'is_default': true},
    );
    return BillingCardModel.fromJson(_extractMap(response.data));
  }

  @override
  Future<void> deleteCard(int cardId) async {
    await _dioClient.delete(ApiRoutes.billingCard(cardId));
  }

  @override
  Future<List<BillingTransactionModel>> getTransactions() async {
    final response = await _dioClient.get(ApiRoutes.billingTransactions);
    return _extractList(
      response.data,
    ).map((item) => BillingTransactionModel.fromJson(_readMap(item))).toList();
  }

  @override
  Future<BillingSubscriptionModel> cancelSubscription() async {
    final response = await _dioClient.post(ApiRoutes.cancelSubscription);
    return BillingSubscriptionModel.fromJson(_extractMap(response.data));
  }

  @override
  Future<BillingTransactionModel> boostProfile({
    required int packageId,
    required String paymentMethod,
    String? returnUrl,
    int? cardId,
  }) async {
    final response = await _dioClient.post(
      ApiRoutes.boostProfile,
      data: {
        'package_id': packageId,
        'payment_method': paymentMethod,
        if (cardId != null) 'card_id': cardId,
        if (cardId == null && returnUrl != null && returnUrl.isNotEmpty)
          'return_url': returnUrl,
      },
    );
    return BillingTransactionModel.fromJson(_extractMap(response.data));
  }

  @override
  Future<BillingSubscriptionModel> subscribeToPlan({
    required int planId,
    required String paymentMethod,
    String? returnUrl,
    int? cardId,
  }) async {
    final response = await _dioClient.post(
      ApiRoutes.subscribeToPlan,
      data: {
        'plan_id': planId,
        'payment_method': paymentMethod,
        if (cardId != null) 'card_id': cardId,
        if (cardId == null && returnUrl != null && returnUrl.isNotEmpty)
          'return_url': returnUrl,
      },
    );
    return BillingSubscriptionModel.fromJson(_extractMap(response.data));
  }

  @override
  Future<PaylovCheckoutModel> getPaylovCheckout({
    required int transactionId,
    String? returnUrl,
  }) async {
    final response = await _dioClient.post(
      ApiRoutes.paylovCheckout,
      data: {
        'transaction_id': transactionId,
        if (returnUrl != null && returnUrl.isNotEmpty) 'return_url': returnUrl,
      },
    );
    return PaylovCheckoutModel.fromJson(_extractMap(response.data));
  }

  Map<String, dynamic> _extractMap(dynamic payload) {
    final root = _readMap(payload);
    final data = root['data'];

    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return root;
  }

  Map<String, dynamic>? _extractMapOrNull(dynamic payload) {
    final root = _readMap(payload);
    if (root.isEmpty) {
      return null;
    }

    final data = root['data'];
    if (data == null) {
      return root;
    }

    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return null;
  }

  List<dynamic> _extractList(dynamic payload) {
    if (payload is List) {
      return payload;
    }

    final root = _readMap(payload);
    final data = root['data'];

    if (data is List) {
      return data;
    }

    if (data is Map) {
      if (data['results'] is List) {
        return data['results'] as List<dynamic>;
      }

      if (data['items'] is List) {
        return data['items'] as List<dynamic>;
      }
    }

    if (root['results'] is List) {
      return root['results'] as List<dynamic>;
    }

    if (root['items'] is List) {
      return root['items'] as List<dynamic>;
    }

    return const [];
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
}
