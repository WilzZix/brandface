import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/favourites/favourites_data_source.dart';
import 'package:brandface/domain/entities/profile/favourite_entity.dart';
import 'package:brandface/domain/repository/favourites_repository.dart';
import 'package:dart_either/dart_either.dart';

final class FavouritesRepositoryImpl implements IFavouritesRepository {
  final FavouritesDataSource _dataSource;

  FavouritesRepositoryImpl({required FavouritesDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<FavouriteEntity>>> getFavourites() {
    return guard(() => _dataSource.getFavourites());
  }

  @override
  Future<Either<Failure, void>> addFavourite({
    required int influencerId,
  }) {
    return guard(() => _dataSource.addFavourite(influencerId: influencerId));
  }

  @override
  Future<Either<Failure, void>> removeFavourite({
    required int influencerId,
  }) {
    return guard(() => _dataSource.removeFavourite(influencerId: influencerId));
  }
}
