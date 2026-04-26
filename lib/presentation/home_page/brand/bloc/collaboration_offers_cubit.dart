import 'package:bloc/bloc.dart';
import 'package:brandface/domain/repository/offer_repository.dart';

import 'collaboration_offers_state.dart';

class CollaborationOffersCubit extends Cubit<CollaborationOffersState> {
  final IOfferRepository _offerRepository;

  CollaborationOffersCubit({required IOfferRepository offerRepository})
      : _offerRepository = offerRepository,
        super(CollaborationOffersInitial());

  Future<void> loadActive() => _load('active');

  Future<void> loadArchived() => _load('completed');

  Future<void> search(String query) async {
    if (state is! CollaborationOffersLoaded) return;
    final current = (state as CollaborationOffersLoaded).offers;
    final filtered = query.trim().isEmpty
        ? current
        : current
            .where((o) => o.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
    emit(CollaborationOffersLoaded(filtered));
  }

  Future<void> _load(String status) async {
    emit(CollaborationOffersLoading());
    final result = await _offerRepository.getBrandOffers(status: status);
    result.fold(
      ifLeft: (f) => emit(CollaborationOffersFailure(f.message)),
      ifRight: (offers) => emit(CollaborationOffersLoaded(offers)),
    );
  }
}
