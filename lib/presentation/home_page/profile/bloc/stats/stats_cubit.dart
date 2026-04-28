import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/profile/get_influencer_analytics_use_case.dart';
import 'package:brandface/presentation/home_page/profile/bloc/stats/stats_state.dart';

class StatsCubit extends Cubit<StatsState> {
  final GetInfluencerAnalyticsUseCase _getInfluencerAnalyticsUseCase;

  StatsCubit({
    required GetInfluencerAnalyticsUseCase getInfluencerAnalyticsUseCase,
  }) : _getInfluencerAnalyticsUseCase = getInfluencerAnalyticsUseCase,
       super(const StatsState());

  Future<void> loadAnalytics({bool force = false}) async {
    if (!force && state.status == StatsStatus.loading) {
      return;
    }

    emit(state.copyWith(status: StatsStatus.loading, clearFailure: true));

    final result = await _getInfluencerAnalyticsUseCase.call(params: null);

    result.fold(
      ifLeft: (failure) =>
          emit(state.copyWith(status: StatsStatus.failure, failure: failure)),
      ifRight: (analytics) => emit(
        state.copyWith(
          status: StatsStatus.success,
          analytics: analytics,
          clearFailure: true,
        ),
      ),
    );
  }
}
