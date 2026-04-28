import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/city_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../../repository/profile_repository.dart';

class CityUseCase implements UseCase<List<CityEntity>, void> {
  final IProfileRepository repository;

  CityUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CityEntity>>> call({required void params}) {
    return repository.getCities();
  }
}
