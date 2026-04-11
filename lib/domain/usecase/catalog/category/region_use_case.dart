import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/region_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../../repository/profile_repository.dart';

class RegionUseCase implements UseCase<List<RegionEntity>, void> {
  final IProfileRepository repository;

  RegionUseCase({required this.repository});

  @override
  Future<Either<Failure, List<RegionEntity>>> call({required void params}) {
    return repository.getRegions();
  }
}
