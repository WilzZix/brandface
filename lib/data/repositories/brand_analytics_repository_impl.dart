import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/analytics/brand_analytics_data_source.dart';
import 'package:brandface/domain/entities/brand_analytics_entity.dart';
import 'package:brandface/domain/repository/brand_analytics_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class BrandAnalyticsRepositoryImpl implements IBrandAnalyticsRepository {
  final BrandAnalyticsDataSource _dataSource;

  BrandAnalyticsRepositoryImpl({required BrandAnalyticsDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, BrandAnalyticsEntity>> getBrandAnalytics() async {
    try {
      final model = await _dataSource.getBrandAnalytics();
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure(
        e.response?.data?['detail'] ?? e.message ?? 'Server error',
        statusCode: e.response?.statusCode,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
