import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/favourite_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract class IFavouritesRepository {
  Future<Either<Failure, List<FavouriteEntity>>> getFavourites();
  Future<Either<Failure, void>> addFavourite({required int influencerId});
  Future<Either<Failure, void>> removeFavourite({required int influencerId});
}
