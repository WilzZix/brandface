part of 'fill_brand_profile_bloc.dart';

@freezed
class FillBrandProfileState with _$FillBrandProfileState {
  const factory FillBrandProfileState.initial() = _Initial;

  const factory FillBrandProfileState.loading() = _Loading;

  const factory FillBrandProfileState.filled() = _Filled;

  const factory FillBrandProfileState.failure({required Failure failure}) =
      _Failure;
}
