import '../../../../domain/entities/profile/influencer_profile_information_entity.dart';
import '../../../../domain/entities/profile/profile_entity.dart';

class InfluencerProfileInformationModel extends InfluencerProfileInformationEntity {
  // 1. 'const' konstruktor qo'shildi (Entity const bo'lgani uchun)
  // 2. 'required' so'zlari Entity-ga moslab olib tashlandi yoki qoldirildi
  const InfluencerProfileInformationModel({
    required super.id, // Entity-da required
    super.displayName,
    super.avatarUrl,
    super.avatarId,
    super.bio,
    super.regionId,
    super.cityId,
    super.birthDate,
    super.gender,
    super.categoryIds,
    super.serviceIds,
    super.languageIds,
    super.yearsOfExperience,
    super.hasAdExperience,
    super.pressMentions,
    super.agencyRepresentation,
    super.partners,
    super.contacts,
    super.isVerified = false,
    super.isTop = false,
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

  factory InfluencerProfileInformationModel.fromJson(Map<String, dynamic> json) {
    return InfluencerProfileInformationModel(
      id: json['id'] ?? 0,
      displayName: json['display_name'],
      avatarUrl: json['avatar_url'],
      // Agar backend-da avatar_id bo'lmasa, avatarUrl-dan yoki boshqa joydan olish mumkin
      avatarId: json['avatar_id'],
      bio: json['bio'],
      regionId: json['region_id'],
      cityId: json['city_id'],
      birthDate: json['birth_date'] != null
          ? DateTime.tryParse(json['birth_date'])
          : null,
      gender: json['gender'],
      categoryIds: json['category_ids'] != null
          ? List<int>.from(json['category_ids'])
          : null,
      serviceIds: json['service_ids'] != null
          ? List<int>.from(json['service_ids'])
          : null,
      languageIds: json['language_ids'] != null
          ? List<int>.from(json['language_ids'])
          : null,
      yearsOfExperience: json['years_of_experience'],
      hasAdExperience: json['has_ad_experience'],
      pressMentions: json['press_mentions'],
      agencyRepresentation: json['agency_representation'],
      partners: json['partners'] != null
          ? List<String>.from(json['partners'])
          : null,
      // Contacts conversion
      contacts: json['contacts'] != null
          ? (json['contacts'] as List)
          .map((e) => ContactEntity(
        type: e['type'],
        value: e['value'],
      ))
          .toList()
          : null,
      isVerified: json['is_verified'] ?? false,
      isTop: json['is_top'] ?? false,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      moderationStatus: json['moderation_status'] ?? 'pending',
      // Audience and Pricing nested mapping
      audience: json['audience_info'] != null
          ? AudienceEntity.fromJson(json['audience_info']) // Agar AudienceEntity-da fromJson bo'lsa
          : null,
      pricing: json['pricing_info'] != null
          ? PricingEntity.fromJson(json['pricing_info'])
          : null,
      availableDates: json['available_dates'],
      awards: json['awards'],
      reviews: json['reviews'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  // Model-ni Entity-ga o'tkazish
  InfluencerProfileInformationEntity toEntity() => this;
}