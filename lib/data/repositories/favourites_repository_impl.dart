import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/favourites/favourites_data_source.dart';
import 'package:brandface/domain/entities/profile/favourite_entity.dart';
import 'package:brandface/domain/repository/favourites_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class FavouritesRepositoryImpl implements IFavouritesRepository {
  final FavouritesDataSource _dataSource;

  FavouritesRepositoryImpl({required FavouritesDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<FavouriteEntity>>> getFavourites() async {
    try {
      final items = await _dataSource.getFavourites();
      return Right(items);
    } on DioException catch (e) {
      return Left(ServerFailure(
        e.response?.data?['detail'] ?? e.message ?? 'Server error',
        statusCode: e.response?.statusCode,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavourite({required int influencerId}) async {
    try {
      await _dataSource.removeFavourite(influencerId: influencerId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(
        e.response?.data?['detail'] ?? e.message ?? 'Server error',
        statusCode: e.response?.statusCode,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
