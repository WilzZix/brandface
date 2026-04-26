import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/review_entity.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

import '../../repository/profile_repository.dart';

class GetInfluencerReviewsUseCase implements UseCase<List<ReviewEntity>, int> {
  final IProfileRepository repository;

  GetInfluencerReviewsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ReviewEntity>>> call({
    required int params,
  }) async {
    return await repository.getInfluencerReviews(influencerId: params);
  }
}
