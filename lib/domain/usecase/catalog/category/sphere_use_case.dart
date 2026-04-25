import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/sphere_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../../repository/profile_repository.dart';

class SphereUseCase implements UseCase<List<SphereEntity>, void> {
  final IProfileRepository repository;

  SphereUseCase({required this.repository});

  @override
  Future<Either<Failure, List<SphereEntity>>> call({required void params}) {
    return repository.getSpheres();
  }
}
