import 'package:brandface/data/models/profile/catalog/category_model.dart';
import 'package:brandface/data/models/profile/catalog/city_model.dart';
import 'package:brandface/data/models/profile/catalog/language_model.dart';
import 'package:brandface/data/models/profile/catalog/region_model.dart';
import 'package:brandface/data/models/profile/catalog/service_type_model.dart';
import 'package:brandface/data/models/profile/catalog/sphere_model.dart';

import '../../../../domain/entities/profile/influencer_profile_information_entity.dart';
import '../../../../domain/entities/profile/profile_entity.dart';

class InfluencerProfileInformationModel
    extends InfluencerProfileInformationEntity {
  const InfluencerProfileInformationModel({
    required super.id,
    super.displayName,
    super.avatarUrl,
    super.avatarId,
    super.bio,
    super.region,
    super.city,
    super.sphere,
    super.website,
    super.birthDate,
    super.gender,
    super.categories,
    super.services,
    super.languageIds,
    super.yearsOfExperience,
    super.hasAdExperience,
    super.pressMentions,
    super.agencyRepresentation,
    super.partners,
    super.contacts,
    super.isVerified = false,
    super.isTop = false,
    super.topExpiresAt,
    super.averageRating,
    super.totalReviews = 0,
    super.moderationStatus = 'pending',
    super.audience,
    super.pricing,
    super.availableDates,
    super.awards,
    super.reviews,
    required super.createdAt, // Entity-da required
  });

  factory InfluencerProfileInformationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InfluencerProfileInformationModel(
      id: json['id'] ?? 0,
      displayName: json['display_name'] ?? json['brand_name'],
      avatarUrl: json['avatar_url'] ?? json['logo_url'],
      avatarId: json['avatar_id'] ?? json['logo_id'],
      bio: json['bio'] ?? json['description'],

      region: json['region'] != null
          ? RegionModel.fromJson(json['region'])
          : null,
      city: json['city'] != null ? CityModel.fromJson(json['city']) : null,
      sphere: json['sphere'] != null
          ? SphereModel.fromJson(json['sphere'])
          : null,
      website: json['website'] as String?,

      birthDate: json['birth_date'] != null
          ? DateTime.tryParse(json['birth_date'])
          : null,
      gender: json['gender'],

      // To'g'ri List mapping
      categories: json['categories'] != null
          ? (json['categories'] as List)
                .map((i) => CategoryData.fromJson(i))
                .toList()
          : null,

      services: json['services'] != null
          ? (json['services'] as List)
                .map((i) => ServiceTypeData.fromJson(i))
                .toList()
          : null,

      // JSONda 'languages' deb kelyapti va u ob'ektlar ro'yxati
      languageIds: json['languages'] != null
          ? (json['languages'] as List)
                .map((i) => LanguageData.fromJson(i))
                .toList()
          : null,

      yearsOfExperience: json['years_of_experience'],
      hasAdExperience: json['has_ad_experience'],
      pressMentions: json['press_mentions'],
      agencyRepresentation: json['agency_representation'],

      partners: json['partners'] != null
          ? List<String>.from(json['partners'])
          : null,

      contacts: json['contacts'] != null
          ? (json['contacts'] as List)
                .map(
                  (e) => ContactEntity(
                    type: e['type']?.toString(),
                    value: e['value']?.toString(),
                  ),
                )
                .toList()
          : null,

      isVerified: json['is_verified'] ?? false,
      isTop: json['is_top'] ?? false,
      topExpiresAt: json['top_expires_at'] != null
          ? DateTime.tryParse(json['top_expires_at'].toString())
          : null,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      moderationStatus: json['moderation_status'] ?? 'pending',

      // Audience mapping
      audience: json['audience_info'] != null
          ? AudienceEntity.fromJson(json['audience_info'])
          : null,

      pricing: json['pricing_info'] != null
          ? PricingEntity.fromJson(json['pricing_info'])
          : null,

      availableDates: json['available_dates'] != null
          ? List<String>.from(json['available_dates'])
          : [],
      awards: json['awards'] != null ? List.from(json['awards']) : [],
      reviews: json['reviews'] != null ? List.from(json['reviews']) : [],

      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  // Model-ni Entity-ga o'tkazish
  InfluencerProfileInformationEntity toEntity() => this;
}
