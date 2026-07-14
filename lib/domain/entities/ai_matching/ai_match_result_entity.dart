import 'package:equatable/equatable.dart';

base class AiMatchResultEntity extends Equatable {
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

  const AiMatchResultEntity({
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

  @override
  List<Object?> get props => [influencerId, displayName, score];
}
