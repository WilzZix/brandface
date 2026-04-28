import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/portfolio/portfolio_data_source.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/repository/portfolio_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class PortfolioRepositoryImpl implements IPortfolioRepository {
  final PortfolioDataSource _dataSource;

  PortfolioRepositoryImpl({required PortfolioDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<PortfolioItemEntity>>> getMyPortfolios() async {
    try {
      final items = await _dataSource.getMyPortfolios();
      return Right(items);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.response?.data?['detail'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, PortfolioItemEntity>> getPortfolioDetail({
    required int id,
  }) async {
    try {
      final item = await _dataSource.getPortfolioDetail(id: id);
      return Right(item);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.response?.data?['detail'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, PortfolioItemEntity>> updatePortfolio({
    required int id,
    required Map<String, dynamic> data,
  }) async {
    try {
      final item = await _dataSource.updatePortfolio(id: id, data: data);
      return Right(item);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.response?.data?['detail'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePortfolio({required int id}) async {
    try {
      await _dataSource.deletePortfolio(id: id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.response?.data?['detail'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UploadedFileEntity>> uploadFile({
    required String path,
  }) async {
    try {
      final file = await _dataSource.uploadFile(path: path);
      return Right(file);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.response?.data?['detail'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, PortfolioImageEntity>> addPortfolioImage({
    required int portfolioId,
    required int imageId,
  }) async {
    try {
      final image = await _dataSource.addPortfolioImage(
        portfolioId: portfolioId,
        imageId: imageId,
      );
      return Right(image);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.response?.data?['detail'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> removePortfolioImage({
    required int portfolioId,
    required int imageId,
  }) async {
    try {
      await _dataSource.removePortfolioImage(
        portfolioId: portfolioId,
        imageId: imageId,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['message'] ??
              e.response?.data?['detail'] ??
              e.message ??
              'Serverda xatolik yuz berdi',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }
}
