import 'package:equatable/equatable.dart';

base class SocialMediaAccountStatsEntity extends Equatable {
  final String platform;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final int? followers;
  final int? views;
  final int? postcount;
  final double? engagementRate;
  final int? likes;

  const SocialMediaAccountStatsEntity({
    required this.platform,
    required this.username,
    required this.displayName,
    required this.avatarUrl,
    required this.followers,
    required this.views,
    required this.postcount,
    required this.engagementRate,
    required this.likes,
  });

  @override
  List<Object?> get props => [
    platform,
    username,
    displayName,
    avatarUrl,
    followers,
    views,
    postcount,
    engagementRate,
    likes,
  ];
}
