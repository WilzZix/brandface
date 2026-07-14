import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/models/billing/billing_models.dart';

final class AddBillingCardRequest {
  final String cardType;
  final String name;
  final int expiryMonth;
  final int expiryYear;
  final bool isDefault;
  final String gatewayToken;

  const AddBillingCardRequest({
    required this.cardType,
    required this.name,
    required this.expiryMonth,
    required this.expiryYear,
    required this.isDefault,
    required this.gatewayToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_type': cardType,
      'name': name,
      'expiry_month': expiryMonth,
      'expiry_year': expiryYear,
      'is_default': isDefault,
      'gateway_token': gatewayToken,
    };
  }
}

abstract interface class BillingDataSource {
  Future<BillingSubscriptionModel?> getMySubscription();

  Future<List<BillingPlanModel>> getPlans();

  Future<List<BillingBoostPackageModel>> getBoostPackages();

  Future<List<BillingCardModel>> getCards();

  Future<BillingCardModel> addCard(AddBillingCardRequest request);

  Future<BillingCardModel> setDefaultCard(int cardId);

  Future<void> deleteCard(int cardId);

  Future<List<BillingTransactionModel>> getTransactions();

  Future<BillingSubscriptionModel> cancelSubscription();

  Future<BillingTransactionModel> boostProfile({
    required int packageId,
    required String paymentMethod,
  });

  Future<BillingSubscriptionModel> subscribeToPlan({
    required int planId,
    required String paymentMethod,
    int? cardId,
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
  Future<BillingCardModel> addCard(AddBillingCardRequest request) async {
    final response = await _dioClient.post(
      ApiRoutes.billingCards,
      data: request.toJson(),
    );
    return BillingCardModel.fromJson(_extractMap(response.data));
  }

  @override
  Future<BillingCardModel> setDefaultCard(int cardId) async {
    final response = await _dioClient.patch(ApiRoutes.billingCard(cardId));
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
  }) async {
    final response = await _dioClient.post(
      ApiRoutes.boostProfile,
      data: {'package_id': packageId, 'payment_method': paymentMethod},
    );
    return BillingTransactionModel.fromJson(_extractMap(response.data));
  }

  @override
  Future<BillingSubscriptionModel> subscribeToPlan({
    required int planId,
    required String paymentMethod,
    int? cardId,
  }) async {
    final response = await _dioClient.post(
      ApiRoutes.subscribeToPlan,
      data: {
        'plan_id': planId,
        'payment_method': paymentMethod,
        ...?cardId == null ? null : {'card_id': cardId},
      },
    );
    return BillingSubscriptionModel.fromJson(_extractMap(response.data));
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
