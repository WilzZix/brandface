import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/catalog/category/city_use_case.dart';

import 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit({required CityUseCase cityUseCase})
      : _cityUseCase = cityUseCase,
        super(CityInitial());

  final CityUseCase _cityUseCase;

  Future<void> getCities() async {
    emit(CityLoading());
    final result = await _cityUseCase.call(params: null);
    result.fold(
      ifLeft: (f) => emit(CityFailure(f)),
      ifRight: (d) => emit(CityLoaded(d)),
    );
  }
}
