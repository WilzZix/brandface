import 'package:brandface/domain/entities/profile/catalog/category_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/region_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/service_type_entity.dart';
import 'package:dart_either/dart_either.dart';

import '../../core/error/failures.dart';
import '../entities/profile/profile_entity.dart';

abstract class IProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile({
    required String profileId,
  });

  Future<Either<Failure, List<CategoryItemEntity>>> getCategories();

  Future<Either<Failure, List<ServiceTypeEntity>>> getServices();

  Future<Either<Failure, List<RegionEntity>>> getRegions();
}
