import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/profile/get_ambassador_detail_use_case.dart';
import 'ambassador_detail_state.dart';

class AmbassadorDetailCubit extends Cubit<AmbassadorDetailState> {
  final GetAmbassadorDetailUseCase _useCase;

  AmbassadorDetailCubit({required GetAmbassadorDetailUseCase useCase})
      : _useCase = useCase,
        super(AmbassadorDetailInitial());

  Future<void> load(int ambassadorId) async {
    emit(AmbassadorDetailLoading());
    final result = await _useCase.call(ambassadorId: ambassadorId);
    result.fold(
      ifLeft: (f) => emit(AmbassadorDetailFailure(f.message)),
      ifRight: (detail) => emit(AmbassadorDetailLoaded(detail)),
    );
  }
}
