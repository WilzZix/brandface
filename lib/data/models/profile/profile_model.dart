import '../../../domain/entities/profile/profile_entity.dart';
import '../../../domain/usecase/registration/params/fill_influencer_profile_param.dart'
    show SocialMediaAccount;

class ProfileModel {
  final String? displayName;
  final int? avatarId;
  final String? avatarUrl;
  final String? bio;
  final int? regionId;
  final int? cityId;
  final DateTime? birthDate;
  final String? gender;
  final int? yearsOfExperience;
  final bool? hasAdExperience;
  final bool? pressMentions;
  final bool? agencyRepresentation;
  final List<String>? partners;
  final List<Contact>? contacts;
  final List<int>? categoryIds;
  final List<int>? serviceIds;
  final List<int>? languageIds;
  final Audience? audience;
  final Pricing? pricing;

  ProfileModel({
    this.displayName,
    this.avatarId,
    this.avatarUrl,
    this.bio,
    this.regionId,
    this.cityId,
    this.birthDate,
    this.gender,
    this.yearsOfExperience,
    this.hasAdExperience,
    this.pressMentions,
    this.agencyRepresentation,
    this.partners,
    this.contacts,
    this.categoryIds,
    this.serviceIds,
    this.languageIds,
    this.audience,
    this.pricing,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      displayName: json['display_name'] as String?,
      avatarId: (json['avatar_id'] ?? json['logo_id']) as int?,
      avatarUrl:
          (json['avatar_url'] ?? json['logo_url'] ?? json['photo_url'])
              as String?,
      bio: json['bio'] as String?,
      regionId: json['region_id'] as int?,
      cityId: json['city_id'] as int?,
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'])
          : null,
      gender: json['gender'] == "male"
          ? "Мужской"
          : (json['gender'] == "female" ? "Женский" : json['gender']),
      yearsOfExperience: json['years_of_experience'] as int?,
      hasAdExperience: json['has_ad_experience'] as bool?,
      pressMentions: json['press_mentions'] as bool?,
      agencyRepresentation: json['agency_representation'] as bool?,
      partners: (json['partners'] as List?)?.map((e) => e as String).toList(),
      contacts: (json['contacts'] as List?)
          ?.map((e) => Contact.fromJson(e))
          .toList(),
      categoryIds: (json['category_ids'] as List?)
          ?.map((e) => e as int)
          .toList(),
      serviceIds: (json['service_ids'] as List?)?.map((e) => e as int).toList(),
      languageIds: (json['language_ids'] as List?)
          ?.map((e) => e as int)
          .toList(),
      audience: json['audience'] != null
          ? Audience.fromJson(json['audience'])
          : null,
      pricing: json['pricing'] != null
          ? Pricing.fromJson(json['pricing'])
          : null,
    );
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      displayName: displayName,
      avatarId: avatarId,
      avatarUrl: avatarUrl,
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
      contacts: contacts?.map((e) => e.toEntity()).toList(),
      categoryIds: categoryIds,
      serviceIds: serviceIds,
      languageIds: languageIds,
      audience: audience?.toEntity(),
      pricing: pricing?.toEntity(),
    );
  }

  ProfileModel copyWith({
    String? displayName,
    int? avatarId,
    String? bio,
    int? regionId,
    int? cityId,
    DateTime? birthDate,
    String? gender,
    int? yearsOfExperience,
    bool? hasAdExperience,
    bool? pressMentions,
    bool? agencyRepresentation,
    List<String>? partners,
    List<Contact>? contacts,
    List<int>? categoryIds,
    List<int>? serviceIds,
    List<int>? languageIds,
    Audience? audience,
    Pricing? pricing,
  }) => ProfileModel(
    displayName: displayName ?? this.displayName,
    avatarId: avatarId ?? this.avatarId,
    bio: bio ?? this.bio,
    regionId: regionId ?? this.regionId,
    cityId: cityId ?? this.cityId,
    birthDate: birthDate ?? this.birthDate,
    gender: gender ?? this.gender,
    yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
    hasAdExperience: hasAdExperience ?? this.hasAdExperience,
    pressMentions: pressMentions ?? this.pressMentions,
    agencyRepresentation: agencyRepresentation ?? this.agencyRepresentation,
    partners: partners ?? this.partners,
    contacts: contacts ?? this.contacts,
    categoryIds: categoryIds ?? this.categoryIds,
    serviceIds: serviceIds ?? this.serviceIds,
    languageIds: languageIds ?? this.languageIds,
    audience: audience ?? this.audience,
    pricing: pricing ?? this.pricing,
  );
}

class Audience {
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

  Audience({
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

  factory Audience.fromJson(Map<String, dynamic> json) {
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
    return Audience(
      brandSegment: json['brand_segment'] as String?,
      totalFollowers: json['total_followers'] as int?,
      malePercent: json['male_percent']?.toString(),
      femalePercent: json['female_percent']?.toString(),
      menAgeFrom: json['men_age_from'] as int?,
      menAgeTo: json['men_age_to'] as int?,
      womenAgeFrom: json['women_age_from'] as int?,
      womenAgeTo: json['women_age_to'] as int?,
      engagementRate: json['engagement_rate']?.toString(),
      geography: (json['geography'] as List?)?.map((e) => e as String).toList(),
      socialMediaStats: statUsernames,
      socialMediaAccounts: accountsFromChannels ?? accountsFromStats,
    );
  }

  AudienceEntity toEntity() {
    return AudienceEntity(
      brandSegment: brandSegment,
      totalFollowers: totalFollowers,
      malePercent: malePercent,
      femalePercent: femalePercent,
      menAgeFrom: menAgeFrom,
      menAgeTo: menAgeTo,
      womenAgeFrom: womenAgeFrom,
      womenAgeTo: womenAgeTo,
      engagementRate: engagementRate,
      geography: geography,
      socialMediaStats: socialMediaStats,
      socialMediaAccounts: socialMediaAccounts,
    );
  }
}

class Contact {
  final String? type;
  final String? value;

  Contact({this.type, this.value});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      type: json['type'] as String?,
      value: json['value'] as String?,
    );
  }

  ContactEntity toEntity() {
    return ContactEntity(type: type, value: value);
  }
}

class Pricing {
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

  Pricing({
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
  });

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      availableForLongTerm: json['available_for_long_term'] as bool?,
      worksOnNetModel: json['works_on_net_model'] as bool?,
      openToSimilarOffers: json['open_to_similar_offers'] as bool?,
      hourlyRateMinUzs: json['hourly_rate_min_uzs']?.toString(),
      hourlyRateMaxUzs: json['hourly_rate_max_uzs']?.toString(),
      hourlyRateMinUsd: json['hourly_rate_min_usd']?.toString(),
      hourlyRateMaxUsd: json['hourly_rate_max_usd']?.toString(),
      dailyRateMinUzs: json['daily_rate_min_uzs']?.toString(),
      dailyRateMaxUzs: json['daily_rate_max_uzs']?.toString(),
      acceptsBarter: json['accepts_barter'] as bool?,
      paymentTypes: (json['payment_types'] as List?)
          ?.map((e) => e as String)
          .toList(),
      exclusivityAvailable: json['exclusivity_available'] as bool?,
      campaignFee: json['campaign_fee']?.toString(),
      campaignFeeCurrency: json['campaign_fee_currency'] as String?,
      monthlyExclusivityFee: json['monthly_exclusivity_fee']?.toString(),
      eventAppearanceFee: json['event_appearance_fee']?.toString(),
    );
  }

  PricingEntity toEntity() {
    return PricingEntity(
      availableForLongTerm: availableForLongTerm,
      worksOnNetModel: worksOnNetModel,
      openToSimilarOffers: openToSimilarOffers,
      hourlyRateMinUzs: hourlyRateMinUzs,
      hourlyRateMaxUzs: hourlyRateMaxUzs,
      hourlyRateMinUsd: hourlyRateMinUsd,
      hourlyRateMaxUsd: hourlyRateMaxUsd,
      dailyRateMinUzs: dailyRateMinUzs,
      dailyRateMaxUzs: dailyRateMaxUzs,
      acceptsBarter: acceptsBarter,
      paymentTypes: paymentTypes,
      exclusivityAvailable: exclusivityAvailable,
      campaignFee: campaignFee,
      campaignFeeCurrency: campaignFeeCurrency,
      monthlyExclusivityFee: monthlyExclusivityFee,
      eventAppearanceFee: eventAppearanceFee,
    );
  }
}
