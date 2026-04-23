import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../domain/entities/upload/uploaded_file_entity.dart';
import '../../../../domain/usecase/upload/upload_file_usecase.dart';

part 'upload_state.dart';
part 'upload_cubit.freezed.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit({required UploadFileUseCase uploadFileUseCase})
    : _uploadFileUseCase = uploadFileUseCase,
      super(const UploadState.initial());

  final UploadFileUseCase _uploadFileUseCase;

  Future<void> uploadFile(File file) async {
    emit(const UploadState.loading());
    final result = await _uploadFileUseCase.call(file: file);
    result.fold(
      ifLeft: (failure) => emit(UploadState.failure(failure: failure)),
      ifRight: (entity) => emit(UploadState.uploaded(entity: entity)),
    );
  }
}
