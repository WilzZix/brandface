import 'package:brandface/domain/entities/profile/favourite_entity.dart';

class FavouriteModel extends FavouriteEntity {
  const FavouriteModel({
    required super.favouriteId,
    required super.id,
    super.displayName,
    super.avatarUrl,
    required super.isVerified,
    required super.isTop,
    required super.isVip,
    super.averageRating,
    required super.totalReviews,
    required super.totalFollowers,
    required super.engagementRate,
    super.yearsOfExperience,
    required super.categories,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    final influencer = json['influencer'] as Map<String, dynamic>? ?? {};

    double? rating;
    final raw = influencer['average_rating'];
    if (raw != null) {
      rating = raw is double ? raw : double.tryParse(raw.toString());
    }

    final cats = (influencer['categories'] as List?)
            ?.map((e) => e is Map ? e['name']?.toString() ?? '' : e?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
        const <String>[];

    return FavouriteModel(
      favouriteId: json['id'] as int? ?? 0,
      id: influencer['id'] as int? ?? 0,
      displayName: influencer['display_name'] as String?,
      avatarUrl: influencer['avatar_url'] as String?,
      isVerified: influencer['is_verified'] as bool? ?? false,
      isTop: influencer['is_top'] as bool? ?? false,
      isVip: influencer['is_vip'] as bool? ?? false,
      averageRating: rating,
      totalReviews: influencer['total_reviews'] as int? ?? 0,
      totalFollowers: influencer['total_followers']?.toString() ?? '0',
      engagementRate: influencer['engagement_rate']?.toString() ?? '0',
      yearsOfExperience: influencer['years_of_experience'] as int?,
      categories: cats,
    );
  }
}
