import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/category_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:dart_either/src/dart_either.dart';

class ProfileRepositoryImpl implements IProfileRepository {
  @override
  Future<Either<Failure, CategoryEntity>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }
}
