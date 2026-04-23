import '../../../../domain/entities/profile/catalog/social_media_account_stats_entity.dart';

class SocialMediaAccountStatsModel extends SocialMediaAccountStatsEntity {
  const SocialMediaAccountStatsModel({
    required super.platform,
    required super.username,
    required super.displayName,
    required super.avatarUrl,
    required super.followers,
    required super.views,
    required super.postcount,
    required super.engagementRate,
    required super.likes,
  });

  factory SocialMediaAccountStatsModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaAccountStatsModel(
      platform: json['platform'],
      username: json['username'],
      displayName: json['display_name'],
      avatarUrl: json['avatar_url'],
      followers: json['followers'],
      views: json['views'],
      postcount: json['post_count'],
      engagementRate: json['engagement_rate'] == null
          ? 0.0
          : (json['engagement_rate'] as num).toDouble(),
      likes: json['likes'],
    );
  }

  SocialMediaAccountStatsEntity toEntity() {
    return SocialMediaAccountStatsEntity(
      platform: platform,
      username: username,
      displayName: displayName,
      avatarUrl: avatarUrl,
      followers: followers,
      views: views,
      postcount: postcount,
      engagementRate: engagementRate,
      likes: likes,
    );
  }
}
