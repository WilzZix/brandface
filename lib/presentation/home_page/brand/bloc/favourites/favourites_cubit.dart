import 'package:bloc/bloc.dart';
import 'package:brandface/domain/repository/favourites_repository.dart';

import 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  final IFavouritesRepository _repository;

  FavouritesCubit({required IFavouritesRepository repository})
      : _repository = repository,
        super(FavouritesInitial());

  Future<void> load() async {
    emit(FavouritesLoading());
    final result = await _repository.getFavourites();
    result.fold(
      ifLeft: (f) => emit(FavouritesFailure(f.message)),
      ifRight: (items) => emit(FavouritesLoaded(items)),
    );
  }

  Future<void> remove(int influencerId) async {
    final current = state;
    if (current is! FavouritesLoaded) return;

    // Optimistic remove
    final updated = current.items
        .where((e) => e.id != influencerId)
        .toList();
    emit(FavouritesLoaded(updated));

    final result = await _repository.removeFavourite(influencerId: influencerId);
    result.fold(
      ifLeft: (_) => emit(FavouritesLoaded(current.items)), // rollback
      ifRight: (_) {}, // already removed
    );
  }
}
