import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:brandface/domain/repository/brand_analytics_repository.dart';
import 'package:brandface/domain/repository/offer_repository.dart';

import 'brand_analytics_state.dart';

class BrandAnalyticsCubit extends Cubit<BrandAnalyticsState> {
  final IBrandAnalyticsRepository _repository;
  final IOfferRepository _offerRepository;

  BrandAnalyticsCubit({
    required IBrandAnalyticsRepository repository,
    required IOfferRepository offerRepository,
  })  : _repository = repository,
        _offerRepository = offerRepository,
        super(BrandAnalyticsInitial());

  Future<void> load() async {
    emit(BrandAnalyticsLoading());

    // The offer picker is a nicety — a failure there must not cost us the
    // whole analytics page, so its result is folded into an empty list.
    final offersResult =
        await _offerRepository.getBrandOffers(status: 'active');
    final offers = offersResult.fold<List<OfferSummaryEntity>>(
      ifLeft: (_) => const [],
      ifRight: (data) => data,
    );

    final result = await _repository.getBrandAnalytics(
      period: AnalyticsPeriod.last7Days.apiValue,
    );
    result.fold(
      ifLeft: (f) => emit(BrandAnalyticsFailure(f.message)),
      ifRight: (data) => emit(BrandAnalyticsLoaded(data, offers: offers)),
    );
  }

  /// `offerId` of `null` means "all offers".
  Future<void> selectOffer(int? offerId) {
    final current = state;
    if (current is! BrandAnalyticsLoaded) return Future.value();
    return _refresh(
      current.copyWith(
        selectedOfferId: offerId,
        clearSelectedOffer: offerId == null,
      ),
    );
  }

  Future<void> selectPeriod(AnalyticsPeriod period) {
    final current = state;
    if (current is! BrandAnalyticsLoaded) return Future.value();
    if (current.period == period) return Future.value();
    return _refresh(current.copyWith(period: period));
  }

  /// Re-fetches with [next]'s selection while keeping the previous numbers on
  /// screen, so switching offers never blanks the block.
  Future<void> _refresh(BrandAnalyticsLoaded next) async {
    emit(next.copyWith(isRefreshing: true));
    final result = await _repository.getBrandAnalytics(
      offerId: next.selectedOfferId,
      period: next.period.apiValue,
    );
    if (isClosed) return;
    result.fold(
      ifLeft: (_) => emit(next.copyWith(isRefreshing: false)),
      ifRight: (data) => emit(next.copyWith(data: data, isRefreshing: false)),
    );
  }
}
