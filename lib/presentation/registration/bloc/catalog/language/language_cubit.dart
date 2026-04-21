import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/language_entity.dart';
import 'package:brandface/domain/usecase/catalog/category/get_languages_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_state.dart';

part 'language_cubit.freezed.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({required GetLanguagesUseCase getLanguagesUseCase})
    : _getLanguagesUseCase = getLanguagesUseCase,
      super(const LanguageState.initial());
  final GetLanguagesUseCase _getLanguagesUseCase;

  Future<void> getLanguages() async {
    emit(LanguageState.loading());
    final result = await _getLanguagesUseCase.call(params: null);

    result.fold(
      ifLeft: (failure) => emit(LanguageState.loadFailure(failure: failure)),
      ifRight: (data) {
        emit(LanguageState.loaded(languages: data));
      },
    );
  }
}
