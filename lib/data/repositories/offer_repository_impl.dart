import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/offer/offer_data_source.dart';
import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';
import 'package:brandface/domain/entities/offer/create_offer_params.dart';
import 'package:brandface/domain/entities/offer/offer_detail_entity.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:brandface/domain/repository/offer_repository.dart';
import 'package:dart_either/dart_either.dart';

final class OfferRepositoryImpl implements IOfferRepository {
  final OfferDataSource _dataSource;

  OfferRepositoryImpl({required OfferDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<OfferSummaryEntity>>> getBrandOffers({
    String? status,
  }) {
    return guard(() => _dataSource.getBrandOffers(status: status));
  }

  @override
  Future<Either<Failure, List<OfferSummaryEntity>>> getAvailableOffers({
    int? categoryId,
  }) {
    return guard(() => _dataSource.getAvailableOffers(categoryId: categoryId));
  }

  @override
  Future<Either<Failure, List<OfferSummaryEntity>>> getRecommendedOffers() {
    return guard(() => _dataSource.getRecommendedOffers());
  }

  @override
  Future<Either<Failure, OfferDetailEntity>> getAvailableOfferDetail({
    required int id,
  }) {
    return guard(() => _dataSource.getAvailableOfferDetail(id: id));
  }

  @override
  Future<Either<Failure, void>> applyToOffer({
    required int id,
    String? coverLetter,
  }) {
    return guard(
      () => _dataSource.applyToOffer(id: id, coverLetter: coverLetter),
    );
  }

  @override
  Future<Either<Failure, void>> createOffer(CreateOfferParams params) {
    return guard(() => _dataSource.createOffer(params));
  }

  @override
  Future<Either<Failure, List<AiMatchResultEntity>>> runAiMatching({
    required int offerId,
  }) {
    return guard(() async {
      final models = await _dataSource.runAiMatching(offerId: offerId);
      return models.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, List<AiMatchResultEntity>>> getAiMatchingResults({
    required int offerId,
  }) {
    return guard(() async {
      final models = await _dataSource.getAiMatchingResults(offerId: offerId);
      return models.map((m) => m.toEntity()).toList();
    });
  }
}
