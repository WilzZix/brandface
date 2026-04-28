import 'package:bloc/bloc.dart';
import 'package:brandface/domain/repository/brand_analytics_repository.dart';

import 'brand_analytics_state.dart';

class BrandAnalyticsCubit extends Cubit<BrandAnalyticsState> {
  final IBrandAnalyticsRepository _repository;

  BrandAnalyticsCubit({required IBrandAnalyticsRepository repository})
      : _repository = repository,
        super(BrandAnalyticsInitial());

  Future<void> load() async {
    emit(BrandAnalyticsLoading());
    final result = await _repository.getBrandAnalytics();
    result.fold(
      ifLeft: (f) => emit(BrandAnalyticsFailure(f.message)),
      ifRight: (data) => emit(BrandAnalyticsLoaded(data)),
    );
  }
}
