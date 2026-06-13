import 'package:brandface/data/models/profile/catalog/category_model.dart';
import 'package:brandface/data/models/profile/catalog/language_model.dart';
import 'package:brandface/data/models/profile/catalog/service_type_model.dart';
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/entities/profile/profile_entity.dart';
import 'package:equatable/equatable.dart';

import 'catalog/city_entity.dart';
import 'catalog/region_entity.dart';
import 'catalog/sphere_entity.dart';

class InfluencerProfileInformationEntity extends Equatable {
  final int id;
  final String? displayName;
  final String? avatarUrl;
  final int? avatarId;
  final String? bio;
  final RegionEntity? region;
  final CityEntity? city;
  final SphereEntity? sphere;
  final String? website;
  final DateTime? birthDate;
  final String? gender;
  final List<CategoryData>? categories;
  final List<ServiceTypeData>? services;
  final List<LanguageData>? languageIds;
  final int? yearsOfExperience;
  final bool? hasAdExperience;
  final bool? pressMentions;
  final bool? agencyRepresentation;
  final List<String>? partners;
  final List<ContactEntity>? contacts;
  final bool isVerified;
  final bool isTop;
  final DateTime? topExpiresAt;
  final double? averageRating;
  final int totalReviews;
  final String moderationStatus;
  final AudienceEntity? audience;
  final PricingEntity? pricing;
  final List<AvailableDateItem>? availableDates;
  final List<String>? awards;
  final List<dynamic>? reviews;
  final DateTime createdAt;

  const InfluencerProfileInformationEntity({
    required this.id,
    this.displayName,
    this.avatarUrl,
    this.avatarId,
    this.bio,
    this.region,
    this.city,
    this.sphere,
    this.website,
    this.birthDate,
    this.gender,
    this.categories,
    this.services,
    this.languageIds,
    this.yearsOfExperience,
    this.hasAdExperience,
    this.pressMentions,
    this.agencyRepresentation,
    this.partners,
    this.contacts,
    this.isVerified = false,
    this.isTop = false,
    this.topExpiresAt,
    this.averageRating,
    this.totalReviews = 0,
    this.moderationStatus = 'pending',
    this.audience,
    this.pricing,
    this.availableDates,
    this.awards,
    this.reviews,
    required this.createdAt,
  });

  ProfileEntity toProfileEntity() {
    return ProfileEntity(
      displayName: displayName,
      avatarId: avatarId,
      avatarUrl: avatarUrl,
      bio: bio,
      regionId: region?.id,
      regionName: region?.name,
      cityId: city?.id,
      cityName: city?.name,
      sphereId: sphere?.id,
      sphereName: sphere?.name,
      website: website,
      birthDate: birthDate,
      gender: gender,
      yearsOfExperience: yearsOfExperience,
      hasAdExperience: hasAdExperience,
      pressMentions: pressMentions,
      agencyRepresentation: agencyRepresentation,
      partners: partners,
      contacts: contacts,
      categoryIds: categories?.map((c) => c.id).whereType<int>().toList(),
      categoryNames: categories
          ?.map((c) => c.name)
          .whereType<String>()
          .toList(),
      serviceIds: services?.map((s) => s.id).whereType<int>().toList(),
      languageIds: languageIds?.map((l) => l.id).whereType<int>().toList(),
      audience: audience,
      pricing: pricing,
      moderationStatus: moderationStatus,
    );
  }

  @override
  List<Object?> get props => [
    id,
    displayName,
    avatarUrl,
    avatarId,
    bio,
    region,
    city,
    sphere,
    website,
    birthDate,
    gender,
    categories,
    services,
    languageIds,
    yearsOfExperience,
    hasAdExperience,
    pressMentions,
    agencyRepresentation,
    partners,
    contacts,
    isVerified,
    isTop,
    topExpiresAt,
    averageRating,
    totalReviews,
    moderationStatus,
    audience,
    pricing,
    availableDates,
    awards,
    reviews,
    createdAt,
  ];
}
