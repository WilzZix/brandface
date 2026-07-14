import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/category_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../../repository/profile_repository.dart';

final class CategoryUseCase implements UseCase<List<CategoryItemEntity>, void> {
  final IProfileRepository repository;

  CategoryUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CategoryItemEntity>>> call({
    required void params,
  }) async {
    return await repository.getCategories();
  }
}
