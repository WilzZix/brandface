import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/award_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

class CreateAwardUseCase implements UseCase<AwardEntity, String> {
  final IProfileRepository repository;

  CreateAwardUseCase({required this.repository});

  @override
  Future<Either<Failure, AwardEntity>> call({required String params}) {
    return repository.createAward(title: params);
  }
}
