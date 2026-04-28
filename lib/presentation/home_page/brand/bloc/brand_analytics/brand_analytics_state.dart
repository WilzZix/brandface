import 'package:brandface/domain/entities/brand_analytics_entity.dart';

abstract class BrandAnalyticsState {}

class BrandAnalyticsInitial extends BrandAnalyticsState {}

class BrandAnalyticsLoading extends BrandAnalyticsState {}

class BrandAnalyticsLoaded extends BrandAnalyticsState {
  final BrandAnalyticsEntity data;
  BrandAnalyticsLoaded(this.data);
}

class BrandAnalyticsFailure extends BrandAnalyticsState {
  final String message;
  BrandAnalyticsFailure(this.message);
}
