import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/profile/ambassador_entity.dart';
import 'package:brandface/domain/usecase/profile/get_ambassadors_use_case.dart';

import 'ambassadors_state.dart';

class AmbassadorsCubit extends Cubit<AmbassadorsState> {
  final GetAmbassadorsUseCase _useCase;
  List<AmbassadorEntity> _allAmbassadors = [];

  AmbassadorsCubit({required GetAmbassadorsUseCase getAmbassadorsUseCase})
      : _useCase = getAmbassadorsUseCase,
        super(AmbassadorsInitial());

  Future<void> load({String? ordering}) async {
    emit(AmbassadorsLoading());
    final result = await _useCase.call(params: ordering);
    result.fold(
      ifLeft: (f) => emit(AmbassadorsFailure(f.message)),
      ifRight: (data) {
        _allAmbassadors = data;
        emit(AmbassadorsLoaded(data));
      },
    );
  }

  void search(String query) {
    if (state is! AmbassadorsLoaded) return;
    if (query.trim().isEmpty) {
      emit(AmbassadorsLoaded(_allAmbassadors));
      return;
    }
    final q = query.toLowerCase();
    final filtered = _allAmbassadors
        .where(
          (a) =>
              (a.displayName?.toLowerCase().contains(q) ?? false) ||
              a.categories.any((c) => c.toLowerCase().contains(q)),
        )
        .toList();
    emit(AmbassadorsLoaded(filtered));
  }
}
