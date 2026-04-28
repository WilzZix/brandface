import 'dart:io';

import 'package:brandface/core/error/failures.dart';
import 'package:dart_either/dart_either.dart';

import '../../entities/upload/uploaded_file_entity.dart';
import '../../repository/upload_repository.dart';

class UploadFileUseCase {
  final IUploadRepository repository;

  UploadFileUseCase(this.repository);

  Future<Either<Failure, UploadedFileEntity>> call({required File file}) {
    return repository.uploadFile(file: file);
  }
}
