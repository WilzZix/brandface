import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/models/analytics/brand_analytics_model.dart';

abstract class BrandAnalyticsDataSource {
  Future<BrandAnalyticsModel> getBrandAnalytics({int? offerId, String? period});
}

final class BrandAnalyticsDataSourceImpl implements BrandAnalyticsDataSource {
  final DioClient _dioClient;

  BrandAnalyticsDataSourceImpl(this._dioClient);

  @override
  Future<BrandAnalyticsModel> getBrandAnalytics({
    int? offerId,
    String? period,
  }) async {
    // The backend currently ignores both parameters and answers with the
    // brand-wide payload; sending them is forward-compatible with per-offer
    // filtering once it lands.
    final queryParams = <String, dynamic>{
      'offer_id': ?offerId,
      'period': ?period,
    };
    final result = await _dioClient.get(
      ApiRoutes.brandAnalytics,
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
    return BrandAnalyticsModel.fromApiJson(result.data);
  }
}
