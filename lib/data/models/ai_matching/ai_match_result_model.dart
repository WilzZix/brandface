import '../../../domain/entities/ai_matching/ai_match_result_entity.dart';

final class AiMatchResultModel {
  final int influencerId;
  final String displayName;
  final String avatarUrl;
  final String averageRating;
  final int totalReviews;
  final String totalFollowers;
  final String engagementRate;
  final String region;
  final String city;
  final String categories;
  final bool isVerified;
  final bool isTop;
  final double score;

  AiMatchResultModel({
    required this.influencerId,
    required this.displayName,
    required this.avatarUrl,
    required this.averageRating,
    required this.totalReviews,
    required this.totalFollowers,
    required this.engagementRate,
    required this.region,
    required this.city,
    required this.categories,
    required this.isVerified,
    required this.isTop,
    required this.score,
  });

  factory AiMatchResultModel.fromJson(Map<String, dynamic> json) {
    return AiMatchResultModel(
      influencerId: json['influencer_id'] as int? ?? 0,
      displayName: json['display_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      averageRating: json['average_rating'] as String? ?? '0',
      totalReviews: json['total_reviews'] as int? ?? 0,
      totalFollowers: json['total_followers'] as String? ?? '0',
      engagementRate: json['engagement_rate'] as String? ?? '0',
      region: json['region'] as String? ?? '',
      city: json['city'] as String? ?? '',
      categories: json['categories'] as String? ?? '',
      isVerified: json['is_verified'] as bool? ?? false,
      isTop: json['is_top'] as bool? ?? false,
      score: double.tryParse(json['score']?.toString() ?? '0') ?? 0,
    );
  }

  AiMatchResultEntity toEntity() => AiMatchResultEntity(
    influencerId: influencerId,
    displayName: displayName,
    avatarUrl: avatarUrl,
    averageRating: averageRating,
    totalReviews: totalReviews,
    totalFollowers: totalFollowers,
    engagementRate: engagementRate,
    region: region,
    city: city,
    categories: categories,
    isVerified: isVerified,
    isTop: isTop,
    score: score,
  );
}
