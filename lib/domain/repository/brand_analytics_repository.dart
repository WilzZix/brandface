import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/brand_analytics_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract interface class IBrandAnalyticsRepository {
  Future<Either<Failure, BrandAnalyticsEntity>> getBrandAnalytics();
}
