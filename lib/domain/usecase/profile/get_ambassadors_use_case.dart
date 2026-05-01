import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/ambassador_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:dart_either/dart_either.dart';

class GetAmbassadorsUseCase {
  final IProfileRepository repository;

  GetAmbassadorsUseCase({required this.repository});

  Future<Either<Failure, List<AmbassadorEntity>>> call({
    String? params,
    int? categoryId,
    int? regionId,
    String? gender,
    bool? isTop,
    bool? isVip,
    String? role,
  }) {
    return repository.getAmbassadors(
      ordering: params,
      categoryId: categoryId,
      regionId: regionId,
      gender: gender,
      isTop: isTop,
      isVip: isVip,
      role: role,
    );
  }
}
