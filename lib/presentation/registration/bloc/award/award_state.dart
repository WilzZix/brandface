part of 'award_cubit.dart';

@freezed
class AwardState with _$AwardState {
  const factory AwardState.initial({@Default([]) List<AwardEntity> awards}) =
      _Initial;

  const factory AwardState.loading({@Default([]) List<AwardEntity> awards}) =
      _Loading;

  const factory AwardState.success({required List<AwardEntity> awards}) =
      _Success;

  const factory AwardState.failure({
    required List<AwardEntity> awards,
    required Failure failure,
  }) = _Failure;

  @override
  // TODO: implement awards
  List<AwardEntity> get awards => [];
}
