import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/profile_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/src/dart_either.dart';

final class GetProfileUseCase implements UseCase<ProfileEntity, String> {
  final IProfileRepository repository;

  GetProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, ProfileEntity>> call({required String params}) async {
    return await repository.getProfile(profileId: params);
  }
}
