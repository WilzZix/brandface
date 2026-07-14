import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';
import 'package:brandface/domain/repository/offer_repository.dart';
import 'package:dart_either/dart_either.dart';

final class GetAiMatchingResultsUseCase {
  final IOfferRepository _repository;

  GetAiMatchingResultsUseCase({required IOfferRepository repository})
      : _repository = repository;

  Future<Either<Failure, List<AiMatchResultEntity>>> call(int offerId) {
    return _repository.getAiMatchingResults(offerId: offerId);
  }
}
