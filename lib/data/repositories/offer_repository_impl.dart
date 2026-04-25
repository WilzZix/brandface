import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/offer/offer_data_source.dart';
import 'package:brandface/domain/entities/offer/offer_detail_entity.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:brandface/domain/repository/offer_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class OfferRepositoryImpl implements IOfferRepository {
  final OfferDataSource _dataSource;

  OfferRepositoryImpl({required OfferDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<OfferSummaryEntity>>> getAvailableOffers({
    int? categoryId,
  }) async {
    try {
      final offers = await _dataSource.getAvailableOffers(
        categoryId: categoryId,
      );
      return Right(offers);
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<OfferSummaryEntity>>>
  getRecommendedOffers() async {
    try {
      final offers = await _dataSource.getRecommendedOffers();
      return Right(offers);
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, OfferDetailEntity>> getAvailableOfferDetail({
    required int id,
  }) async {
    try {
      final offer = await _dataSource.getAvailableOfferDetail(id: id);
      return Right(offer);
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> applyToOffer({
    required int id,
    String? coverLetter,
  }) async {
    try {
      await _dataSource.applyToOffer(id: id, coverLetter: coverLetter);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  ServerFailure _mapDioFailure(DioException e) {
    final responseData = e.response?.data;
    String message = e.message ?? 'Serverda xatolik yuz berdi';

    if (responseData is Map && responseData['message'] != null) {
      message = responseData['message'].toString();
    } else if (responseData is Map && responseData['detail'] != null) {
      message = responseData['detail'].toString();
    }

    return ServerFailure(
      message,
      statusCode: e.response?.statusCode,
      errorData: responseData,
    );
  }
}
