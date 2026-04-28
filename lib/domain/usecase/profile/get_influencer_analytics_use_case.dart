import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/influencer_analytics_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

import '../../repository/profile_repository.dart';

class GetInfluencerAnalyticsUseCase
    implements UseCase<InfluencerAnalyticsEntity, void> {
  final IProfileRepository repository;

  GetInfluencerAnalyticsUseCase({required this.repository});

  @override
  Future<Either<Failure, InfluencerAnalyticsEntity>> call({
    required void params,
  }) async {
    return repository.getInfluencerAnalytics();
  }
}
