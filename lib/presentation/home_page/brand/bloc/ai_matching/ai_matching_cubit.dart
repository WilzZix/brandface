import 'package:bloc/bloc.dart';
import 'package:brandface/domain/repository/offer_repository.dart';
import 'package:brandface/domain/usecase/ai_matching/get_ai_matching_results_use_case.dart';
import 'package:brandface/domain/usecase/ai_matching/run_ai_matching_use_case.dart';

import 'ai_matching_state.dart';

class AiMatchingCubit extends Cubit<AiMatchingState> {
  final IOfferRepository _offerRepository;
  final GetAiMatchingResultsUseCase _getResultsUseCase;
  final RunAiMatchingUseCase _runMatchingUseCase;

  AiMatchingCubit({
    required IOfferRepository offerRepository,
    required GetAiMatchingResultsUseCase getResultsUseCase,
    required RunAiMatchingUseCase runMatchingUseCase,
  })  : _offerRepository = offerRepository,
        _getResultsUseCase = getResultsUseCase,
        _runMatchingUseCase = runMatchingUseCase,
        super(AiMatchingInitial());

  Future<void> init() async {
    emit(AiMatchingLoading());
    final result = await _offerRepository.getBrandOffers(status: 'active');
    result.fold(
      ifLeft: (f) => emit(AiMatchingFailure(f.message)),
      ifRight: (offers) async {
        if (offers.isEmpty) {
          emit(AiMatchingNoOffers());
          return;
        }
        final firstOffer = offers.first;
        await _loadResults(firstOffer.id, firstOffer.title);
      },
    );
  }

  Future<void> runMatching(int offerId, String offerTitle) async {
    emit(AiMatchingRunning(offerId));
    final result = await _runMatchingUseCase.call(offerId);
    result.fold(
      ifLeft: (f) => emit(AiMatchingFailure(f.message)),
      ifRight: (results) {
        if (results.isEmpty) {
          emit(AiMatchingEmpty(offerId: offerId, offerTitle: offerTitle));
        } else {
          emit(AiMatchingLoaded(
            results: results,
            offerId: offerId,
            offerTitle: offerTitle,
          ));
        }
      },
    );
  }

  Future<void> _loadResults(int offerId, String offerTitle) async {
    final result = await _getResultsUseCase.call(offerId);
    result.fold(
      ifLeft: (_) => emit(AiMatchingEmpty(offerId: offerId, offerTitle: offerTitle)),
      ifRight: (results) {
        if (results.isEmpty) {
          emit(AiMatchingEmpty(offerId: offerId, offerTitle: offerTitle));
        } else {
          emit(AiMatchingLoaded(
            results: results,
            offerId: offerId,
            offerTitle: offerTitle,
          ));
        }
      },
    );
  }
}
