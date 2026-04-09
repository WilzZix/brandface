import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/category_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/usecase/catalog/category/category_use_case.dart';

part 'category_state.dart';

part 'category_cubit.freezed.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required CategoryUseCase categoryUseCase})
    : _categoryUseCase = categoryUseCase,
      super(const CategoryState.initial());
  final CategoryUseCase _categoryUseCase;

  Future<void> getCategory() async {
    emit((CategoryState.loading()));
    final result = await _categoryUseCase.call(params: null);
    result.fold(
      ifLeft: (failure) =>
          emit(CategoryState.categoryLoadFailure(failure: failure)),
      ifRight: (data) => emit(CategoryState.categoryLoaded(data: data)),
    );
  }
}
