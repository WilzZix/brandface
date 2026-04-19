import 'package:brandface/domain/entities/profile/profile_entity.dart';
import 'package:equatable/equatable.dart';
import '../../usecase/registration/params/fill_influencer_profile_param.dart';

class InfluencerProfileInformationEntity extends Equatable {
  final int id;
  final String? displayName;
  final String? avatarUrl;
  final int? avatarId; // Param uchun kerak bo'lishi mumkin
  final String? bio;
  final int? regionId;
  final int? cityId;
  final DateTime? birthDate;
  final String? gender;
  final List<int>? categoryIds;
  final List<int>? serviceIds;
  final List<int>? languageIds;
  final int? yearsOfExperience;
  final bool? hasAdExperience;
  final bool? pressMentions;
  final bool? agencyRepresentation;
  final List<String>? partners;
  final List<ContactEntity>? contacts;
  final bool isVerified;
  final bool isTop;
  final double? averageRating;
  final int totalReviews;
  final String moderationStatus;
  final AudienceEntity? audience;
  final PricingEntity? pricing;
  final List<dynamic>? availableDates;
  final List<dynamic>? awards;
  final List<dynamic>? reviews;
  final DateTime createdAt;

  const InfluencerProfileInformationEntity({
    required this.id,
    this.displayName,
    this.avatarUrl,
    this.avatarId,
    this.bio,
    this.regionId,
    this.cityId,
    this.birthDate,
    this.gender,
    this.categoryIds,
    this.serviceIds,
    this.languageIds,
    this.yearsOfExperience,
    this.hasAdExperience,
    this.pressMentions,
    this.agencyRepresentation,
    this.partners,
    this.contacts,
    this.isVerified = false,
    this.isTop = false,
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

  FillInfluencerProfileParam toParam() {
    return FillInfluencerProfileParam(
      displayName: displayName,
      avatarId: avatarId,
      bio: bio,
      regionId: regionId,
      cityId: cityId,
      birthDate: birthDate,
      gender: gender,
      yearsOfExperience: yearsOfExperience,
      hasAdExperience: hasAdExperience,
      pressMentions: pressMentions,
      agencyRepresentation: agencyRepresentation,
      partners: partners,
      contacts: contacts
          ?.map((e) => Contact(type: e.type, value: e.value))
          .toList(),
      categoryIds: categoryIds,
      serviceIds: serviceIds,
      languageIds: languageIds,
      audience: audience != null
          ? Audience(
              brandSegment: audience!.brandSegment,
              totalFollowers: audience!.totalFollowers,
              malePercent: audience!.malePercent,
              femalePercent: audience!.femalePercent,
              menAgeFrom: audience!.menAgeFrom,
              menAgeTo: audience!.menAgeTo,
              womenAgeFrom: audience!.womenAgeFrom,
              womenAgeTo: audience!.womenAgeTo,
              engagementRate: audience!.engagementRate,
              geography: audience!.geography,
              socialMediaStats: audience!.socialMediaStats,
            )
          : null,
      pricing: pricing != null
          ? Pricing(
              availableForLongTerm: pricing!.availableForLongTerm,
              worksOnNetModel: pricing!.worksOnNetModel,
              openToSimilarOffers: pricing!.openToSimilarOffers,
              hourlyRateMinUzs: pricing!.hourlyRateMinUzs,
              hourlyRateMaxUzs: pricing!.hourlyRateMaxUzs,
              hourlyRateMinUsd: pricing!.hourlyRateMinUsd,
              hourlyRateMaxUsd: pricing!.hourlyRateMaxUsd,
              dailyRateMinUzs: pricing!.dailyRateMinUzs,
              dailyRateMaxUzs: pricing!.dailyRateMaxUzs,
              acceptsBarter: pricing!.acceptsBarter,
              paymentTypes: pricing!.paymentTypes,
              exclusivityAvailable: pricing!.exclusivityAvailable,
              campaignFee: pricing!.campaignFee,
              campaignFeeCurrency: pricing!.campaignFeeCurrency,
              monthlyExclusivityFee: pricing!.monthlyExclusivityFee,
              eventAppearanceFee: pricing!.eventAppearanceFee,
            )
          : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    displayName,
    avatarUrl,
    avatarId,
    bio,
    regionId,
    cityId,
    birthDate,
    gender,
    categoryIds,
    serviceIds,
    languageIds,
    yearsOfExperience,
    hasAdExperience,
    pressMentions,
    agencyRepresentation,
    partners,
    contacts,
    isVerified,
    isTop,
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

// Qolgan yordamchi Entity klasslari (AudienceEntity, ContactEntity, PricingEntity)
// siz yuborgan namunadagidek qoladi.
