import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/data/models/profile/catalog/category_model.dart';

import '../../../../core/network/dio_client.dart';

abstract class ProfileDataSource {
  Future<CategoryModel> getCategories();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final DioClient _dioClient;

  ProfileDataSourceImpl(this._dioClient);

  @override
  Future<CategoryModel> getCategories() async {
    try {
      final result = await _dioClient.get(ApiRoutes.categories);
      return CategoryModel.fromJson(result.data);
    } catch (e) {
      rethrow;
    }
  }
}
