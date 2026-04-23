import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/constants/api_routes.dart';
import '../../../../core/network/dio_client.dart';

abstract class UploadDataSource {
  Future<Map<String, dynamic>> uploadFile({required File file});
}

class UploadDataSourceImpl implements UploadDataSource {
  final DioClient _dioClient;

  UploadDataSourceImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<Map<String, dynamic>> uploadFile({required File file}) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
    });
    final response = await _dioClient.post(
      ApiRoutes.uploadFile,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    return response.data as Map<String, dynamic>;
  }
}
