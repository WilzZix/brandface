import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/catalog/social_media_account_stats_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:brandface/domain/usecase/profile/params/social_medi_params.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../repository/profile_repository.dart';

class GetSocialMediaAccountStatsUseCase
    implements UseCase<SocialMediaAccountStatsEntity, SocialMediaParams> {
  final IProfileRepository repository;

  GetSocialMediaAccountStatsUseCase({required this.repository});

  @override
  Future<Either<Failure, SocialMediaAccountStatsEntity>> call({
    required SocialMediaParams params,
  }) {
    return repository.getSocialMediaAccountStats(
      platform: params.platform,
      username: params.username,
    );
  }
}
