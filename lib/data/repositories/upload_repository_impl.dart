import 'dart:io';

import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:dart_either/dart_either.dart';

import '../../domain/entities/upload/uploaded_file_entity.dart';
import '../../domain/repository/upload_repository.dart';
import '../data_source/network_data_source/upload/upload_data_source.dart';

final class UploadRepositoryImpl implements IUploadRepository {
  final UploadDataSource _dataSource;

  UploadRepositoryImpl({required UploadDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, UploadedFileEntity>> uploadFile({
    required File file,
  }) {
    return guard(() async {
      final response = await _dataSource.uploadFile(file: file);
      final data = response['data'] as Map<String, dynamic>;
      return UploadedFileEntity(
        id: data['id'] as int,
        fileUrl: data['file'] as String,
      );
    });
  }
}
