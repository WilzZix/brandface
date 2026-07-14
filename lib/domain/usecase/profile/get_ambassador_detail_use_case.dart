import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:dart_either/dart_either.dart';

final class GetAmbassadorDetailUseCase {
  final IProfileRepository repository;

  GetAmbassadorDetailUseCase({required this.repository});

  Future<Either<Failure, AmbassadorDetailEntity>> call({
    required int ambassadorId,
  }) {
    return repository.getAmbassadorDetail(ambassadorId: ambassadorId);
  }
}
