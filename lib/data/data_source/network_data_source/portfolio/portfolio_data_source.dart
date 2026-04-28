import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/models/profile/portfolio_model.dart';
import 'package:dio/dio.dart';

abstract class PortfolioDataSource {
  Future<List<PortfolioModel>> getMyPortfolios();
  Future<PortfolioModel> getPortfolioDetail({required int id});
  Future<PortfolioModel> updatePortfolio({
    required int id,
    required Map<String, dynamic> data,
  });
  Future<void> deletePortfolio({required int id});
  Future<UploadedFileModel> uploadFile({required String path});
  Future<PortfolioImageModel> addPortfolioImage({
    required int portfolioId,
    required int imageId,
  });
  Future<void> removePortfolioImage({
    required int portfolioId,
    required int imageId,
  });
}

class PortfolioDataSourceImpl implements PortfolioDataSource {
  final DioClient _dioClient;

  PortfolioDataSourceImpl(this._dioClient);

  @override
  Future<List<PortfolioModel>> getMyPortfolios() async {
    final result = await _dioClient.get(ApiRoutes.portfolio);
    final payload = result.data;
    final list = payload is List
        ? payload
        : payload is Map<String, dynamic> && payload['data'] is List
        ? payload['data'] as List
        : payload is Map && payload['data'] is List
        ? payload['data'] as List
        : const [];

    return list
        .map(
          (item) =>
              PortfolioModel.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList(growable: false);
  }

  @override
  Future<PortfolioModel> getPortfolioDetail({required int id}) async {
    final result = await _dioClient.get(ApiRoutes.portfolioDetail(id));
    final payload = result.data;
    final data =
        payload is Map<String, dynamic> &&
            payload['data'] is Map<String, dynamic>
        ? payload['data'] as Map<String, dynamic>
        : payload is Map && payload['data'] is Map
        ? Map<String, dynamic>.from(payload['data'] as Map)
        : Map<String, dynamic>.from(payload as Map);
    return PortfolioModel.fromJson(data);
  }

  @override
  Future<PortfolioModel> updatePortfolio({
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final result = await _dioClient.patch(
      ApiRoutes.portfolioDetail(id),
      data: data,
    );
    final payload = result.data;
    final responseData =
        payload is Map<String, dynamic> &&
            payload['data'] is Map<String, dynamic>
        ? payload['data'] as Map<String, dynamic>
        : payload is Map && payload['data'] is Map
        ? Map<String, dynamic>.from(payload['data'] as Map)
        : Map<String, dynamic>.from(payload as Map);
    return PortfolioModel.fromJson(responseData);
  }

  @override
  Future<void> deletePortfolio({required int id}) async {
    await _dioClient.delete(ApiRoutes.portfolioDetail(id));
  }

  @override
  Future<UploadedFileModel> uploadFile({required String path}) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path),
    });
    final result = await _dioClient.post(ApiRoutes.uploadFile, data: formData);
    return UploadedFileModel.fromJson(
      Map<String, dynamic>.from(result.data as Map),
    );
  }

  @override
  Future<PortfolioImageModel> addPortfolioImage({
    required int portfolioId,
    required int imageId,
  }) async {
    final result = await _dioClient.post(
      ApiRoutes.addPortfolioImage(portfolioId),
      data: {'image_id': imageId},
    );
    final payload = result.data;
    final data =
        payload is Map<String, dynamic> &&
            payload['data'] is Map<String, dynamic>
        ? payload['data'] as Map<String, dynamic>
        : payload is Map && payload['data'] is Map
        ? Map<String, dynamic>.from(payload['data'] as Map)
        : Map<String, dynamic>.from(payload as Map);
    return PortfolioImageModel.fromJson(data);
  }

  @override
  Future<void> removePortfolioImage({
    required int portfolioId,
    required int imageId,
  }) async {
    await _dioClient.delete(
      ApiRoutes.removePortfolioImage(portfolioId, imageId),
    );
  }
}
