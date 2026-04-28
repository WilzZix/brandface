import 'package:equatable/equatable.dart';

class FavouriteEntity extends Equatable {
  final int favouriteId;
  final int id;
  final String? displayName;
  final String? avatarUrl;
  final bool isVerified;
  final bool isTop;
  final bool isVip;
  final double? averageRating;
  final int totalReviews;
  final String totalFollowers;
  final String engagementRate;
  final int? yearsOfExperience;
  final List<String> categories;

  const FavouriteEntity({
    required this.favouriteId,
    required this.id,
    this.displayName,
    this.avatarUrl,
    required this.isVerified,
    required this.isTop,
    required this.isVip,
    this.averageRating,
    required this.totalReviews,
    required this.totalFollowers,
    required this.engagementRate,
    this.yearsOfExperience,
    required this.categories,
  });

  @override
  List<Object?> get props => [favouriteId, id];
}
