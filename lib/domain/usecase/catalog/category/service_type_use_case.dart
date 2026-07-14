import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/service_type_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../../repository/profile_repository.dart';

final class ServiceTypeUseCase implements UseCase<List<ServiceTypeEntity>, void> {
  final IProfileRepository repository;

  ServiceTypeUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ServiceTypeEntity>>> call({
    required void params,
  }) async {
    return await repository.getServices();
  }
}
