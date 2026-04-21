part of 'language_cubit.dart';

@freezed
class LanguageState with _$LanguageState {
  const factory LanguageState.initial() = _Initial;

  const factory LanguageState.loading() = _Loading;

  const factory LanguageState.loaded({
    required List<LanguageEntity> languages,
  }) = _LanguagesLoaded;

  const factory LanguageState.loadFailure({required Failure failure}) =
      _Failure;
}
