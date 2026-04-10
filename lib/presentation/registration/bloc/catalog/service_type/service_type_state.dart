part of 'service_type_cubit.dart';

@freezed
class ServiceTypeState with _$ServiceTypeState {
  const factory ServiceTypeState.initial() = _Initial;

  const factory ServiceTypeState.loading() = _Loading;

  const factory ServiceTypeState.serviceTypeLoaded({
    required List<ServiceTypeEntity> data,
  }) = _ServiceTypeLoaded;

  const factory ServiceTypeState.serviceTypeLoadedLoadFailure({
    required Failure failure,
  }) = _ServiceTypeLoadFailure;
}
