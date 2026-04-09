import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/category_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:dart_either/src/dart_either.dart';
import 'package:dio/dio.dart';

import '../data_source/network_data_source/profile/profile_data_source.dart';

class ProfileRepositoryImpl implements IProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepositoryImpl({required ProfileDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<CategoryItemEntity>>> getCategories() async {
    try {
      final categoryData = await _dataSource.getCategories();
      final List<CategoryItemEntity> entities = categoryData.data!
          .map((model) => model.toEntity())
          .toList();
      return Right(entities);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          statusCode: e.response?.statusCode,
          e.message ?? 'Serverda kutilmagan xatolik',
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }
}
