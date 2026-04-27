import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';
import 'package:brandface/domain/repository/offer_repository.dart';
import 'package:dart_either/dart_either.dart';

class RunAiMatchingUseCase {
  final IOfferRepository _repository;

  RunAiMatchingUseCase({required IOfferRepository repository})
      : _repository = repository;

  Future<Either<Failure, List<AiMatchResultEntity>>> call(int offerId) {
    return _repository.runAiMatching(offerId: offerId);
  }
}
