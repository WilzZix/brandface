part of 'upload_cubit.dart';

@freezed
class UploadState with _$UploadState {
  const factory UploadState.initial() = _Initial;
  const factory UploadState.loading() = _Loading;
  const factory UploadState.uploaded({required UploadedFileEntity entity}) = _Uploaded;
  const factory UploadState.failure({required Failure failure}) = _Failure;
}
