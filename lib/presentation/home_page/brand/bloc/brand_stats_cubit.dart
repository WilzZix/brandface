import 'package:bloc/bloc.dart';
import 'package:brandface/domain/repository/offer_repository.dart';

import 'brand_stats_state.dart';

class BrandStatsCubit extends Cubit<BrandStatsState> {
  final IOfferRepository _offerRepository;

  BrandStatsCubit({required IOfferRepository offerRepository})
      : _offerRepository = offerRepository,
        super(BrandStatsInitial());

  Future<void> loadStats() async {
    emit(BrandStatsLoading());
    final result = await _offerRepository.getBrandOffers(status: 'active');
    result.fold(
      ifLeft: (_) => emit(BrandStatsFailure()),
      ifRight: (offers) {
        final totalApplications = offers.fold<int>(
          0,
          (sum, o) => sum + o.applicationsCount,
        );
        emit(BrandStatsLoaded(
          activeOffersCount: offers.length,
          totalApplicationsCount: totalApplications,
        ));
      },
    );
  }
}
