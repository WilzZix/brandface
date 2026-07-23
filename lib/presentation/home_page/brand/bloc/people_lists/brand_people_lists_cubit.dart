import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/profile/get_ambassadors_use_case.dart';

import 'brand_people_lists_state.dart';

/// Feeds the VIP / TOP / AI-Matching people blocks on the brand home page.
///
/// Every block is one call to the ambassadors endpoint with a different
/// filter. They run concurrently and land independently, so a slow or failing
/// list never holds up the rest of the page.
class BrandPeopleListsCubit extends Cubit<BrandPeopleListsState> {
  final GetAmbassadorsUseCase _useCase;

  /// How many people each home-page block shows before "Browse all".
  static const int previewCount = 4;

  BrandPeopleListsCubit({required GetAmbassadorsUseCase getAmbassadorsUseCase})
      : _useCase = getAmbassadorsUseCase,
        super(const BrandPeopleListsState());

  Future<void> loadAll() {
    return Future.wait([
      _load(
        (s, slot) => s.copyWith(vip: slot),
        isVip: true,
      ),
      _load(
        (s, slot) => s.copyWith(top: slot),
        isTop: true,
      ),
      _load(
        (s, slot) => s.copyWith(influencers: slot),
        role: 'influencer',
      ),
      _load(
        (s, slot) => s.copyWith(ambassadors: slot),
        role: 'ambassador',
      ),
    ]);
  }

  /// [put] writes the slot back into whichever field this list owns. It always
  /// reads the *current* state, so concurrent lists don't overwrite each other.
  Future<void> _load(
    BrandPeopleListsState Function(BrandPeopleListsState, PeopleSlot) put, {
    bool? isVip,
    bool? isTop,
    String? role,
  }) async {
    emit(put(state, const PeopleSlot.loading()));
    final result = await _useCase.call(
      params: '-average_rating',
      isVip: isVip,
      isTop: isTop,
      role: role,
    );
    if (isClosed) return;
    final slot = result.fold(
      ifLeft: (f) => PeopleSlot(error: f.message),
      ifRight: (data) => PeopleSlot(items: data.take(previewCount).toList()),
    );
    emit(put(state, slot));
  }
}
