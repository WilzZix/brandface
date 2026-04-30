import 'package:equatable/equatable.dart';

import '../../usecase/registration/params/fill_influencer_profile_param.dart';

class ProfileEntity extends Equatable {
  final String? displayName;
  final int? avatarId;
  final String? avatarUrl;
  final String? bio;
  final int? regionId;
  final int? cityId;
  final DateTime? birthDate;
  final String? gender;
  final String? professionalCategory;
  final int? yearsOfExperience;
  final bool? hasAdExperience;
  final bool? pressMentions;
  final bool? agencyRepresentation;
  final bool? referralExperience;
  final bool? previousBrandCollaborations;
  final bool? caseStudyAvailable;
  final bool? conversionMetricsAvailable;
  final List<String>? partners;
  final List<ContactEntity>? contacts;
  final List<int>? categoryIds;
  final List<int>? serviceIds;
  final List<int>? languageIds;
  final List<int>? activeBrandIds;
  final AudienceEntity? audience;
  final PricingEntity? pricing;
  final String? moderationStatus;

  const ProfileEntity({
    this.displayName,
    this.avatarId,
    this.avatarUrl,
    this.bio,
    this.regionId,
    this.cityId,
    this.birthDate,
    this.gender,
    this.professionalCategory,
    this.yearsOfExperience,
    this.hasAdExperience,
    this.pressMentions,
    this.agencyRepresentation,
    this.referralExperience,
    this.previousBrandCollaborations,
    this.caseStudyAvailable,
    this.conversionMetricsAvailable,
    this.partners,
    this.contacts,
    this.categoryIds,
    this.serviceIds,
    this.languageIds,
    this.activeBrandIds,
    this.audience,
    this.pricing,
    this.moderationStatus,
  });

  FillInfluencerProfileParam toParam() {
    return FillInfluencerProfileParam(
      displayName: displayName,
      avatarId: avatarId,
      avatarUrl: avatarUrl,
      bio: bio,
      regionId: regionId,
      cityId: cityId,
      birthDate: birthDate,
      gender: gender,
      professionalCategory: professionalCategory,
      yearsOfExperience: yearsOfExperience,
      hasAdExperience: hasAdExperience,
      pressMentions: pressMentions,
      agencyRepresentation: agencyRepresentation,
      referralExperience: referralExperience,
      previousBrandCollaborations: previousBrandCollaborations,
      caseStudyAvailable: caseStudyAvailable,
      conversionMetricsAvailable: conversionMetricsAvailable,
      partners: partners,
      contacts: contacts
          ?.map((e) => Contact(type: e.type, value: e.value))
          .toList(),
      categoryIds: categoryIds,
      serviceIds: serviceIds,
      languageIds: languageIds,
      activeBrandIds: activeBrandIds,
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
              socialMediaAccounts: audience!.socialMediaAccounts,
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
              kpiBasedModel: pricing!.kpiBasedModel,
              availableForOfflineEvents: pricing!.availableForOfflineEvents,
              monthlyContentCapacity: pricing!.monthlyContentCapacity,
            )
          : null,
    );
  }

  @override
  List<Object?> get props => [
    displayName,
    avatarId,
    avatarUrl,
    bio,
    regionId,
    cityId,
    birthDate,
    gender,
    professionalCategory,
    yearsOfExperience,
    hasAdExperience,
    pressMentions,
    agencyRepresentation,
    referralExperience,
    previousBrandCollaborations,
    caseStudyAvailable,
    conversionMetricsAvailable,
    partners,
    contacts,
    categoryIds,
    serviceIds,
    languageIds,
    activeBrandIds,
    audience,
    pricing,
    moderationStatus,
  ];
}

class AudienceEntity extends Equatable {
  final String? brandSegment;
  final int? totalFollowers;
  final String? malePercent;
  final String? femalePercent;
  final int? menAgeFrom;
  final int? menAgeTo;
  final int? womenAgeFrom;
  final int? womenAgeTo;
  final String? engagementRate;
  final List<String>? geography;
  final List<String>? socialMediaStats;
  final List<SocialMediaAccount>? socialMediaAccounts;

  const AudienceEntity({
    this.brandSegment,
    this.totalFollowers,
    this.malePercent,
    this.femalePercent,
    this.menAgeFrom,
    this.menAgeTo,
    this.womenAgeFrom,
    this.womenAgeTo,
    this.engagementRate,
    this.geography,
    this.socialMediaStats,
    this.socialMediaAccounts,
  });

  factory AudienceEntity.fromJson(Map<String, dynamic> json) {
    final rawStats = json['social_media_stats'] as List?;
    final List<String>? statUsernames = rawStats
        ?.map((e) {
          if (e is String) return e;
          if (e is Map) return e['username']?.toString() ?? '';
          return '';
        })
        .where((s) => s.isNotEmpty)
        .toList();
    final List<SocialMediaAccount>? accountsFromChannels =
        (json['social_channels'] as List?)
            ?.map(
              (e) => SocialMediaAccount(
                platform: e['platform'] as String? ?? '',
                username: e['username'] as String? ?? '',
              ),
            )
            .toList();
    final List<SocialMediaAccount>? accountsFromStats = rawStats
        ?.whereType<Map>()
        .map(
          (e) => SocialMediaAccount(
            platform: e['platform']?.toString() ?? '',
            username: e['username']?.toString() ?? '',
          ),
        )
        .toList();
    return AudienceEntity(
      brandSegment: json['brand_segment'],
      totalFollowers: json['total_followers'],
      malePercent: json['male_percent']?.toString(),
      femalePercent: json['female_percent']?.toString(),
      menAgeFrom: json['men_age_from'],
      menAgeTo: json['men_age_to'],
      womenAgeFrom: json['women_age_from'],
      womenAgeTo: json['women_age_to'],
      engagementRate: json['engagement_rate']?.toString(),
      geography: json['geography'] != null
          ? List<String>.from(json['geography'])
          : null,
      socialMediaStats: statUsernames,
      socialMediaAccounts: accountsFromChannels ?? accountsFromStats,
    );
  }

  @override
  List<Object?> get props => [
    brandSegment,
    totalFollowers,
    malePercent,
    femalePercent,
    menAgeFrom,
    menAgeTo,
    womenAgeFrom,
    womenAgeTo,
    engagementRate,
    geography,
    socialMediaStats,
    socialMediaAccounts,
  ];
}

class ContactEntity extends Equatable {
  final String? type;
  final String? value;

  const ContactEntity({this.type, this.value});

  @override
  List<Object?> get props => [type, value];
}

class PricingEntity extends Equatable {
  final bool? availableForLongTerm;
  final bool? worksOnNetModel;
  final bool? openToSimilarOffers;
  final String? hourlyRateMinUzs;
  final String? hourlyRateMaxUzs;
  final String? hourlyRateMinUsd;
  final String? hourlyRateMaxUsd;
  final String? dailyRateMinUzs;
  final String? dailyRateMaxUzs;
  final bool? acceptsBarter;
  final List<String>? paymentTypes;
  final bool? exclusivityAvailable;
  final String? campaignFee;
  final String? campaignFeeCurrency;
  final String? monthlyExclusivityFee;
  final String? eventAppearanceFee;
  final bool? kpiBasedModel;
  final bool? availableForOfflineEvents;
  final int? monthlyContentCapacity;

  const PricingEntity({
    this.availableForLongTerm,
    this.worksOnNetModel,
    this.openToSimilarOffers,
    this.hourlyRateMinUzs,
    this.hourlyRateMaxUzs,
    this.hourlyRateMinUsd,
    this.hourlyRateMaxUsd,
    this.dailyRateMinUzs,
    this.dailyRateMaxUzs,
    this.acceptsBarter,
    this.paymentTypes,
    this.exclusivityAvailable,
    this.campaignFee,
    this.campaignFeeCurrency,
    this.monthlyExclusivityFee,
    this.eventAppearanceFee,
    this.kpiBasedModel,
    this.availableForOfflineEvents,
    this.monthlyContentCapacity,
  });

  factory PricingEntity.fromJson(Map<String, dynamic> json) {
    return PricingEntity(
      availableForLongTerm: json['available_for_long_term'],
      worksOnNetModel: json['works_on_net_model'],
      openToSimilarOffers: json['open_to_similar_offers'],
      hourlyRateMinUzs: json['hourly_rate_min_uzs']?.toString(),
      hourlyRateMaxUzs: json['hourly_rate_max_uzs']?.toString(),
      hourlyRateMinUsd: json['hourly_rate_min_usd']?.toString(),
      hourlyRateMaxUsd: json['hourly_rate_max_usd']?.toString(),
      dailyRateMinUzs: json['daily_rate_min_uzs']?.toString(),
      dailyRateMaxUzs: json['daily_rate_max_uzs']?.toString(),
      acceptsBarter: json['accepts_barter'],
      paymentTypes: json['payment_types'] != null
          ? List<String>.from(json['payment_types'])
          : null,
      exclusivityAvailable: json['exclusivity_available'],
      campaignFee: json['campaign_fee']?.toString(),
      campaignFeeCurrency: json['campaign_fee_currency'],
      monthlyExclusivityFee: json['monthly_exclusivity_fee']?.toString(),
      eventAppearanceFee: json['event_appearance_fee']?.toString(),
      kpiBasedModel: json['kpi_based_model'],
      availableForOfflineEvents: json['available_for_offline_events'],
      monthlyContentCapacity: json['monthly_content_capacity'],
    );
  }

  @override
  List<Object?> get props => [
    availableForLongTerm,
    worksOnNetModel,
    openToSimilarOffers,
    hourlyRateMinUzs,
    hourlyRateMaxUzs,
    hourlyRateMinUsd,
    hourlyRateMaxUsd,
    dailyRateMinUzs,
    dailyRateMaxUzs,
    acceptsBarter,
    paymentTypes,
    exclusivityAvailable,
    campaignFee,
    campaignFeeCurrency,
    monthlyExclusivityFee,
    eventAppearanceFee,
    kpiBasedModel,
    availableForOfflineEvents,
    monthlyContentCapacity,
  ];
}
