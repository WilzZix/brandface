import 'package:brandface/domain/entities/profile/catalog/category_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/service_type_entity.dart';
import 'package:dart_either/dart_either.dart';

import '../../core/error/failures.dart';

abstract class IProfileRepository {
  Future<Either<Failure, List<CategoryItemEntity>>> getCategories();

  Future<Either<Failure, List<ServiceTypeEntity>>> getServices();
}
