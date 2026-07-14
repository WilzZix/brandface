import 'package:brandface/domain/entities/profile/ambassador_entity.dart';

final class AmbassadorModel extends AmbassadorEntity {
  const AmbassadorModel({
    required super.id,
    super.displayName,
    super.avatarUrl,
    required super.isVerified,
    required super.isTop,
    super.averageRating,
    super.followersCount,
    super.yearsOfExperience,
    required super.categories,
    super.createdAt,
  });

  factory AmbassadorModel.fromJson(Map<String, dynamic> json) {
    // Extract categories: list of objects with {name: ...} or plain strings
    final rawCategories = json['categories'] as List?;
    final categories = rawCategories
            ?.map((e) {
              if (e is Map) return e['name']?.toString() ?? '';
              return e?.toString() ?? '';
            })
            .where((s) => s.isNotEmpty)
            .toList() ??
        <String>[];

    // followers_count: try audience.followers_count first, then top-level
    int? followersCount;
    final audience = json['audience'];
    if (audience is Map) {
      final fromAudience = audience['followers_count'];
      if (fromAudience != null) {
        followersCount = fromAudience is int
            ? fromAudience
            : int.tryParse(fromAudience.toString());
      }
    }
    if (followersCount == null) {
      final raw = json['followers_count'];
      if (raw != null) {
        followersCount =
            raw is int ? raw : int.tryParse(raw.toString());
      }
    }

    // average_rating
    double? averageRating;
    final rawRating = json['average_rating'];
    if (rawRating != null) {
      averageRating = rawRating is double
          ? rawRating
          : double.tryParse(rawRating.toString());
    }

    return AmbassadorModel(
      id: json['id'] as int,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      isTop: json['is_top'] as bool? ?? false,
      averageRating: averageRating,
      followersCount: followersCount,
      yearsOfExperience: json['years_of_experience'] as int?,
      categories: categories,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}
