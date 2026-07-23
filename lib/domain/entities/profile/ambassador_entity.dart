import 'package:equatable/equatable.dart';

base class AmbassadorEntity extends Equatable {
  final int id;
  final String? displayName;
  final String? avatarUrl;
  final bool isVerified;
  final bool isTop;
  final bool isVip;
  final double? averageRating;
  final int? followersCount;
  final int? yearsOfExperience;
  final List<String> categories;
  final DateTime? createdAt;

  const AmbassadorEntity({
    required this.id,
    this.displayName,
    this.avatarUrl,
    required this.isVerified,
    required this.isTop,
    this.isVip = false,
    this.averageRating,
    this.followersCount,
    this.yearsOfExperience,
    required this.categories,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        displayName,
        avatarUrl,
        isVerified,
        isTop,
        isVip,
        averageRating,
        followersCount,
        yearsOfExperience,
        categories,
        createdAt,
      ];
}
