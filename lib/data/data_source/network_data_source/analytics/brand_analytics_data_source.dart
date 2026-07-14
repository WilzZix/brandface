import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/models/analytics/brand_analytics_model.dart';

abstract class BrandAnalyticsDataSource {
  Future<BrandAnalyticsModel> getBrandAnalytics();
}

final class BrandAnalyticsDataSourceImpl implements BrandAnalyticsDataSource {
  final DioClient _dioClient;

  BrandAnalyticsDataSourceImpl(this._dioClient);

  @override
  Future<BrandAnalyticsModel> getBrandAnalytics() async {
    final result = await _dioClient.get(ApiRoutes.brandAnalytics);
    return BrandAnalyticsModel.fromApiJson(result.data);
  }
}
