import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/catalog/category/sphere_use_case.dart';

import 'sphere_state.dart';

class SphereCubit extends Cubit<SphereState> {
  SphereCubit({required SphereUseCase sphereUseCase})
      : _sphereUseCase = sphereUseCase,
        super(SphereInitial());

  final SphereUseCase _sphereUseCase;

  Future<void> getSpheres() async {
    emit(SphereLoading());
    final result = await _sphereUseCase.call(params: null);
    result.fold(
      ifLeft: (f) => emit(SphereFailure(f)),
      ifRight: (d) => emit(SphereLoaded(d)),
    );
  }
}
