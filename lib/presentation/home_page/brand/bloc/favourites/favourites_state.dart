import 'package:brandface/domain/entities/profile/favourite_entity.dart';

abstract class FavouritesState {}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<FavouriteEntity> items;
  FavouritesLoaded(this.items);
}

class FavouritesFailure extends FavouritesState {
  final String message;
  FavouritesFailure(this.message);
}
