import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/offer/offer_detail_entity.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract class IOfferRepository {
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
}
