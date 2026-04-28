import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';

class AmbassadorDetailModel extends AmbassadorDetailEntity {
  const AmbassadorDetailModel({
    required super.id,
    super.displayName,
    super.avatarUrl,
    super.bio,
    super.regionName,
    super.cityName,
    super.gender,
    required super.categories,
    required super.services,
    required super.languages,
    super.yearsOfExperience,
    required super.isVerified,
    required super.isTop,
    required super.isVip,
    required super.averageRating,
    required super.totalReviews,
  });

  factory AmbassadorDetailModel.fromJson(Map<String, dynamic> json) {
    List<String> _names(dynamic raw) {
      if (raw is! List) return const [];
      return raw
          .map((e) => e is Map ? e['name']?.toString() ?? '' : e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList(growable: false);
    }

    double? rating;
    final rawRating = json['average_rating'];
    if (rawRating != null) {
      rating = rawRating is double
          ? rawRating
          : double.tryParse(rawRating.toString());
    }

    return AmbassadorDetailModel(
      id: json['id'] as int,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
      regionName: (json['region'] is Map) ? json['region']['name'] as String? : null,
      cityName: (json['city'] is Map) ? json['city']['name'] as String? : null,
      gender: json['gender'] as String?,
      categories: _names(json['categories']),
      services: _names(json['services']),
      languages: _names(json['languages']),
      yearsOfExperience: json['years_of_experience'] as int?,
      isVerified: json['is_verified'] as bool? ?? false,
      isTop: json['is_top'] as bool? ?? false,
      isVip: json['is_vip'] as bool? ?? false,
      averageRating: rating,
      totalReviews: json['total_reviews'] as int? ?? 0,
    );
  }
}
