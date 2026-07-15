import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/analytics/brand_analytics_data_source.dart';
import 'package:brandface/domain/entities/brand_analytics_entity.dart';
import 'package:brandface/domain/repository/brand_analytics_repository.dart';
import 'package:dart_either/dart_either.dart';

final class BrandAnalyticsRepositoryImpl implements IBrandAnalyticsRepository {
  final BrandAnalyticsDataSource _dataSource;

  BrandAnalyticsRepositoryImpl({required BrandAnalyticsDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, BrandAnalyticsEntity>> getBrandAnalytics() {
    return guard(() => _dataSource.getBrandAnalytics());
  }
}
