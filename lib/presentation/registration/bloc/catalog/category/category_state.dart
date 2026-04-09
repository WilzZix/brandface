part of 'category_cubit.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;

  const factory CategoryState.loading() = _Loading;

  const factory CategoryState.categoryLoaded({
    required List<CategoryItemEntity> data,
  }) = _CategoryLoaded;

  const factory CategoryState.categoryLoadFailure({required Failure failure}) =
      _CategoryLoadFailure;
}
