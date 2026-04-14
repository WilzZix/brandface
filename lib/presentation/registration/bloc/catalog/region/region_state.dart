part of 'region_cubit.dart';

@freezed
class RegionState with _$RegionState {
  const factory RegionState.initial() = _Initial;

  const factory RegionState.loading() = _Loading;

  const factory RegionState.regionsLoaded({required List<RegionEntity> data}) =
      _RegionsLoaded;

  const factory RegionState.regionLoadFailure({required Failure failure}) =
      _RegionLoadFailure;
}
