import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/offer/apply_to_offer_use_case.dart';
import 'package:brandface/domain/usecase/offer/get_offer_detail_use_case.dart';
import 'package:brandface/presentation/home_page/offers/bloc/offer_detail_state.dart';

class OfferDetailCubit extends Cubit<OfferDetailState> {
  final GetOfferDetailUseCase _getOfferDetailUseCase;
  final ApplyToOfferUseCase _applyToOfferUseCase;

  OfferDetailCubit({
    required GetOfferDetailUseCase getOfferDetailUseCase,
    required ApplyToOfferUseCase applyToOfferUseCase,
  }) : _getOfferDetailUseCase = getOfferDetailUseCase,
       _applyToOfferUseCase = applyToOfferUseCase,
       super(const OfferDetailState());

  Future<void> loadOffer(int offerId) async {
    emit(state.copyWith(status: OfferDetailStatus.loading, clearFailure: true));

    final result = await _getOfferDetailUseCase.call(params: offerId);

    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(status: OfferDetailStatus.failure, failure: failure),
      ),
      ifRight: (offer) => emit(
        state.copyWith(
          status: OfferDetailStatus.success,
          offer: offer,
          isApplied: offer.isApplied,
          clearFailure: true,
        ),
      ),
    );
  }

  Future<void> apply({String? coverLetter}) async {
    final offer = state.offer;
    if (offer == null || state.isApplying || state.isApplied) {
      return;
    }

    emit(state.copyWith(isApplying: true, clearFailure: true));

    final result = await _applyToOfferUseCase.call(
      params: ApplyToOfferParams(id: offer.id, coverLetter: coverLetter),
    );

    result.fold(
      ifLeft: (failure) =>
          emit(state.copyWith(isApplying: false, failure: failure)),
      ifRight: (_) => emit(
        state.copyWith(
          isApplying: false,
          isApplied: true,
          offer: offer.copyWith(isApplied: true),
          clearFailure: true,
        ),
      ),
    );
  }
}
