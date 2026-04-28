import 'package:brandface/domain/entities/profile/award_entity.dart';
import 'package:brandface/domain/entities/profile/profile_entity.dart';
import 'package:brandface/domain/entities/profile/review_entity.dart';
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
  final List<ContactEntity> contacts;
  final List<String> partners;
  final AudienceEntity? audience;
  final PricingEntity? pricing;
  final List<AvailableDateItem> availableDates;
  final List<AwardEntity> awards;
  final List<ReviewEntity> reviews;

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
    required this.contacts,
    required this.partners,
    this.audience,
    this.pricing,
    required this.availableDates,
    required this.awards,
    required this.reviews,
  });

  @override
  List<Object?> get props => [
        id, displayName, avatarUrl, bio, regionName, cityName,
        gender, categories, services, languages, yearsOfExperience,
        isVerified, isTop, isVip, averageRating, totalReviews,
        contacts, partners, audience, pricing, availableDates, awards, reviews,
      ];
}

class AvailableDateItem extends Equatable {
  final int id;
  final String dateFrom;
  final String dateTo;
  final String? note;

  const AvailableDateItem({
    required this.id,
    required this.dateFrom,
    required this.dateTo,
    this.note,
  });

  @override
  List<Object?> get props => [id, dateFrom, dateTo, note];
}
