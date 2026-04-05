import 'package:brandface/data/models/profile/catalog/category_model.dart';

import '../../../../core/network/dio_client.dart';

abstract class ProfileDataSource {
  Future<CategoryModel> getCategories();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final DioClient _dioClient;

  ProfileDataSourceImpl(this._dioClient);

  @override
  Future<CategoryModel> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }
}
