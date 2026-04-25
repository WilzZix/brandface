import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:brandface/domain/usecase/offer/get_available_offers_use_case.dart';
import 'package:brandface/domain/usecase/offer/get_recommended_offers_use_case.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offers_feed_state.dart';
import 'package:dart_either/dart_either.dart';

class OffersFeedCubit extends Cubit<OffersFeedState> {
  final GetAvailableOffersUseCase _getAvailableOffersUseCase;
  final GetRecommendedOffersUseCase _getRecommendedOffersUseCase;

  OffersFeedCubit({
    required GetAvailableOffersUseCase getAvailableOffersUseCase,
    required GetRecommendedOffersUseCase getRecommendedOffersUseCase,
  }) : _getAvailableOffersUseCase = getAvailableOffersUseCase,
       _getRecommendedOffersUseCase = getRecommendedOffersUseCase,
       super(const OffersFeedState());

  Future<void> loadAvailableOffers({
    bool force = false,
    int? categoryId,
  }) async {
    if (!force && state.status == OffersFeedStatus.loading) {
      return;
    }

    await _load(
      loader: () => _getAvailableOffersUseCase.call(params: categoryId),
    );
  }

  Future<void> loadRecommendedOffers({bool force = false}) async {
    if (!force && state.status == OffersFeedStatus.loading) {
      return;
    }

    await _load(loader: () => _getRecommendedOffersUseCase.call(params: null));
  }

  Future<void> _load({
    required Future<Either<Failure, List<OfferSummaryEntity>>> Function()
    loader,
  }) async {
    emit(state.copyWith(status: OffersFeedStatus.loading, clearFailure: true));

    final result = await loader();

    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(status: OffersFeedStatus.failure, failure: failure),
      ),
      ifRight: (offers) => emit(
        state.copyWith(
          status: OffersFeedStatus.success,
          offers: List<OfferSummaryEntity>.from(offers),
          clearFailure: true,
        ),
      ),
    );
  }
}
