import 'package:equatable/equatable.dart';

class AmbassadorDetailEntity extends Equatable {
  final int id;
  final String? displayName;
  final String? avatarUrl;
  final String? bio;
  final String? regionName;
  final String? cityName;
  final String? gender;
  final List<String> categories;
  final List<String> services;
  final List<String> languages;
  final int? yearsOfExperience;
  final bool isVerified;
  final bool isTop;
  final bool isVip;
  final double? averageRating;
  final int totalReviews;

  const AmbassadorDetailEntity({
    required this.id,
    this.displayName,
    this.avatarUrl,
    this.bio,
    this.regionName,
    this.cityName,
    this.gender,
    required this.categories,
    required this.services,
    required this.languages,
    this.yearsOfExperience,
    required this.isVerified,
    required this.isTop,
    required this.isVip,
    required this.averageRating,
    required this.totalReviews,
  });

  @override
  List<Object?> get props => [
        id, displayName, avatarUrl, bio, regionName, cityName,
        gender, categories, services, languages, yearsOfExperience,
        isVerified, isTop, isVip, averageRating, totalReviews,
      ];
}
