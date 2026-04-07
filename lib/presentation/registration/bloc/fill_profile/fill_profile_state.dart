part of 'fill_profile_bloc.dart';

@freezed
class FillProfileState with _$FillProfileState {
  const factory FillProfileState.initial() = _Initial;

  const factory FillProfileState.loading() = _FillProfileLoading;

  const factory FillProfileState.filled() = _FillProfileFilled;

  const factory FillProfileState.fillingFailure({required Failure failure}) =
      _FillProfileFailure;
}
