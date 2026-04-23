import 'dart:io';

import 'package:dart_either/dart_either.dart';

import '../../core/error/failures.dart';
import '../entities/upload/uploaded_file_entity.dart';

abstract class IUploadRepository {
  Future<Either<Failure, UploadedFileEntity>> uploadFile({required File file});
}
