import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/models/home/home_dashboard_model.dart';
import 'package:brandface/data/models/profile/catalog/influencer_profile_information_model.dart';

abstract interface class HomeDataSource {
  Future<InfluencerProfileInformationModel> getMyProfile();

  Future<int> getUnreadNotificationsCount();

  Future<List<String>> getMyApplicationStatuses();

  Future<int> getConversationsCount();

  Future<List<RecommendedHomeOfferModel>> getRecommendedOffers();
}

final class HomeDataSourceImpl implements HomeDataSource {
  final DioClient _dioClient;

  HomeDataSourceImpl(this._dioClient);

  @override
  Future<InfluencerProfileInformationModel> getMyProfile() async {
    final response = await _dioClient.get(ApiRoutes.myProfile);
    return InfluencerProfileInformationModel.fromJson(
      _extractMap(response.data),
    );
  }

  @override
  Future<int> getUnreadNotificationsCount() async {
    final response = await _dioClient.get(ApiRoutes.unreadNotificationsCount);
    final data = _extractMap(response.data);
    return _toInt(data['unread_count']);
  }

  @override
  Future<List<String>> getMyApplicationStatuses() async {
    final response = await _dioClient.get(ApiRoutes.myApplications);
    final list = _extractList(response.data);

    return list
        .map((item) => _readMap(item)['status']?.toString())
        .whereType<String>()
        .toList();
  }

  @override
  Future<int> getConversationsCount() async {
    final response = await _dioClient.get(ApiRoutes.conversations);
    return _extractList(response.data).length;
  }

  @override
  Future<List<RecommendedHomeOfferModel>> getRecommendedOffers() async {
    final response = await _dioClient.get(ApiRoutes.recommendedOffers);
    final list = _extractList(response.data);

    return list
        .map((item) => RecommendedHomeOfferModel.fromJson(_readMap(item)))
        .where((item) => item.id != 0 || item.title.isNotEmpty)
        .toList();
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

  int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
