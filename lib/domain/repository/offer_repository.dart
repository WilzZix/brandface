import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';
import 'package:brandface/domain/entities/offer/create_offer_params.dart';
import 'package:brandface/domain/entities/offer/offer_detail_entity.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract interface class IOfferRepository {
  Future<Either<Failure, List<OfferSummaryEntity>>> getBrandOffers({
    String? status,
  });

  Future<Either<Failure, List<OfferSummaryEntity>>> getAvailableOffers({
    int? categoryId,
  });

  Future<Either<Failure, List<OfferSummaryEntity>>> getRecommendedOffers();

  Future<Either<Failure, OfferDetailEntity>> getAvailableOfferDetail({
    required int id,
  });

  Future<Either<Failure, void>> applyToOffer({
    required int id,
    String? coverLetter,
  });

  Future<Either<Failure, void>> createOffer(CreateOfferParams params);

  Future<Either<Failure, List<AiMatchResultEntity>>> runAiMatching({
    required int offerId,
  });

  Future<Either<Failure, List<AiMatchResultEntity>>> getAiMatchingResults({
    required int offerId,
  });
}
