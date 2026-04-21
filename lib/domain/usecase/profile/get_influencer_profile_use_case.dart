import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/influencer_profile_information_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../repository/profile_repository.dart';

class GetInfluencerProfileUseCase
    implements UseCase<InfluencerProfileInformationEntity, void> {
  final IProfileRepository repository;

  GetInfluencerProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, InfluencerProfileInformationEntity>> call({
    required void params,
  }) async {
    return await repository.getInfluencerProfile();
  }
}
