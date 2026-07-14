import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/models/profile/favourite_model.dart';

abstract interface class FavouritesDataSource {
  Future<List<FavouriteModel>> getFavourites();

  Future<void> addFavourite({required int influencerId});

  Future<void> removeFavourite({required int influencerId});
}

final class FavouritesDataSourceImpl implements FavouritesDataSource {
  final DioClient _dioClient;

  FavouritesDataSourceImpl(this._dioClient);

  @override
  Future<List<FavouriteModel>> getFavourites() async {
    final result = await _dioClient.get(ApiRoutes.favourites);
    final payload = result.data;
    final list = payload is List
        ? payload
        : payload is Map && payload['results'] is List
        ? payload['results'] as List
        : payload is Map && payload['data'] is List
        ? payload['data'] as List
        : <dynamic>[];
    return list
        .whereType<Map<String, dynamic>>()
        .map(FavouriteModel.fromJson)
        .toList();
  }

  @override
  Future<void> addFavourite({required int influencerId}) async {
    // NOTE: assumed payload `{"influencer": <id>}` — adjust if backend differs.
    await _dioClient.post(
      ApiRoutes.favourites,
      data: {'influencer': influencerId},
    );
  }

  @override
  Future<void> removeFavourite({required int influencerId}) async {
    await _dioClient.delete(ApiRoutes.favouriteItem(influencerId));
  }
}
