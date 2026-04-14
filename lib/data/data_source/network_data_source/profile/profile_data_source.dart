import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/data/models/profile/catalog/category_model.dart';
import 'package:brandface/data/models/profile/catalog/region_model.dart';
import 'package:brandface/data/models/profile/catalog/service_type_model.dart';

import '../../../../core/network/dio_client.dart';

abstract class ProfileDataSource {
  Future<CategoryModel> getCategories();

  Future<ServiceTypeModel> getServices();

  Future<RegionModel> getRegions();
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

  @override
  Future<ServiceTypeModel> getServices() async {
    try {
      final result = await _dioClient.get(ApiRoutes.serviceType);
      return ServiceTypeModel.fromJson(result.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RegionModel> getRegions() async{
    try {
      final result = await _dioClient.get(ApiRoutes.regions);
      return RegionModel.fromJson(result.data);
    } catch (e) {
      rethrow;
    }
  }
}
