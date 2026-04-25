import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/models/offer/offer_detail_model.dart';
import 'package:brandface/data/models/offer/offer_summary_model.dart';

abstract class OfferDataSource {
  Future<List<OfferSummaryModel>> getAvailableOffers({int? categoryId});

  Future<List<OfferSummaryModel>> getRecommendedOffers();

  Future<OfferDetailModel> getAvailableOfferDetail({required int id});

  Future<void> applyToOffer({required int id, String? coverLetter});
}

class OfferDataSourceImpl implements OfferDataSource {
  final DioClient _dioClient;

  OfferDataSourceImpl(this._dioClient);

  @override
  Future<List<OfferSummaryModel>> getAvailableOffers({int? categoryId}) async {
    final response = await _dioClient.get(
      ApiRoutes.availableOffers,
      queryParameters: categoryId == null ? null : {'category_id': categoryId},
    );
    return _extractList(response.data)
        .map((item) => OfferSummaryModel.fromJson(_readMap(item)))
        .where((item) => item.id != 0)
        .toList();
  }

  @override
  Future<List<OfferSummaryModel>> getRecommendedOffers() async {
    final response = await _dioClient.get(ApiRoutes.recommendedOffers);
    return _extractList(response.data)
        .map((item) => OfferSummaryModel.fromJson(_readMap(item)))
        .where((item) => item.id != 0)
        .toList();
  }

  @override
  Future<OfferDetailModel> getAvailableOfferDetail({required int id}) async {
    final response = await _dioClient.get(ApiRoutes.availableOfferDetail(id));
    final payload = response.data;
    final root = payload is Map<String, dynamic>
        ? payload
        : payload is Map
        ? Map<String, dynamic>.from(payload)
        : <String, dynamic>{};
    final data = root['data'] is Map<String, dynamic>
        ? root['data'] as Map<String, dynamic>
        : root['data'] is Map
        ? Map<String, dynamic>.from(root['data'])
        : root;

    return OfferDetailModel.fromJson(data);
  }

  @override
  Future<void> applyToOffer({required int id, String? coverLetter}) async {
    await _dioClient.post(
      ApiRoutes.applyToOffer(id),
      data: coverLetter == null || coverLetter.trim().isEmpty
          ? {}
          : {'cover_letter': coverLetter.trim()},
    );
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
