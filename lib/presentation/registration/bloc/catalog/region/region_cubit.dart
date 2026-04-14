import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/region_entity.dart';
import 'package:brandface/domain/usecase/catalog/category/region_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'region_state.dart';

part 'region_cubit.freezed.dart';

class RegionCubit extends Cubit<RegionState> {
  RegionCubit({required RegionUseCase regionUseCase})
    : _regionUseCase = regionUseCase,
      super(const RegionState.initial());
  final RegionUseCase _regionUseCase;

  Future<void> getCategories() async {
    emit(RegionState.loading());
    final result = await _regionUseCase.call(params: null);
    result.fold(
      ifLeft: (failure) =>
          emit(RegionState.regionLoadFailure(failure: failure)),
      ifRight: (data) => emit(RegionState.regionsLoaded(data: data)),
    );
  }
}
