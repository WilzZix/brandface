class FillInfluencerProfileParam {
  final String? displayName;
  final int? avatarId;
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

  FillInfluencerProfileParam({
    this.displayName,
    this.avatarId,
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

  FillInfluencerProfileParam copyWith({
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
  }) => FillInfluencerProfileParam(
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

  Map<String, dynamic> toJson() {
    return {
      "display_name": displayName,
      "avatar_id": avatarId,
      "bio": bio,
      "region_id": regionId,
      "city_id": cityId,
      "birth_date": birthDate?.toIso8601String().split('T').first,
      "gender": gender == "Мужской" ? "male" : "female",
      "years_of_experience": yearsOfExperience,
      "has_ad_experience": hasAdExperience,
      "press_mentions": pressMentions,
      "agency_representation": agencyRepresentation,
      "partners": partners,
      "contacts": contacts?.map((e) => e.toJson()).toList(),
      "category_ids": categoryIds,
      "service_ids": serviceIds,
      "language_ids": languageIds,
      "audience": audience?.toJson(),
      "pricing": pricing?.toJson(),
    }..removeWhere((key, value) => value == null);
  }
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

  Audience copyWith({
    String? brandSegment,
    int? totalFollowers,
    String? malePercent,
    String? femalePercent,
    int? menAgeFrom,
    int? menAgeTo,
    int? womenAgeFrom,
    int? womenAgeTo,
    String? engagementRate,
    List<String>? geography,
    List<String>? socialMediaStats,
    List<SocialMediaAccount>? socialMediaAccounts,
  }) => Audience(
    brandSegment: brandSegment ?? this.brandSegment,
    totalFollowers: totalFollowers ?? this.totalFollowers,
    malePercent: malePercent ?? this.malePercent,
    femalePercent: femalePercent ?? this.femalePercent,
    menAgeFrom: menAgeFrom ?? this.menAgeFrom,
    menAgeTo: menAgeTo ?? this.menAgeTo,
    womenAgeFrom: womenAgeFrom ?? this.womenAgeFrom,
    womenAgeTo: womenAgeTo ?? this.womenAgeTo,
    engagementRate: engagementRate ?? this.engagementRate,
    geography: geography ?? this.geography,
    socialMediaStats: socialMediaStats ?? this.socialMediaStats,
    socialMediaAccounts: socialMediaAccounts ?? this.socialMediaAccounts,
  );

  Map<String, dynamic> toJson() {
    return {
      "brand_segment": brandSegment,
      "total_followers": totalFollowers,
      "male_percent": malePercent,
      "female_percent": femalePercent,
      "men_age_from": menAgeFrom,
      "men_age_to": menAgeTo,
      "women_age_from": womenAgeFrom,
      "women_age_to": womenAgeTo,
      "engagement_rate": engagementRate,
      "geography": geography,
      "social_media_stats": socialMediaStats,
      "social_channels": socialMediaAccounts?.map((e) => e.toJson()).toList(),
    };
  }
}

class Contact {
  final String? type;
  final String? value;

  Contact({this.type, this.value});

  Contact copyWith({String? type, String? value}) =>
      Contact(type: type ?? this.type, value: value ?? this.value);

  Map<String, dynamic> toJson() {
    return {"type": type, "value": value};
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

  Pricing copyWith({
    bool? availableForLongTerm,
    bool? worksOnNetModel,
    bool? openToSimilarOffers,
    String? hourlyRateMinUzs,
    String? hourlyRateMaxUzs,
    String? hourlyRateMinUsd,
    String? hourlyRateMaxUsd,
    String? dailyRateMinUzs,
    String? dailyRateMaxUzs,
    bool? acceptsBarter,
    List<String>? paymentTypes,
    bool? exclusivityAvailable,
    String? campaignFee,
    String? campaignFeeCurrency,
    String? monthlyExclusivityFee,
    String? eventAppearanceFee,
  }) => Pricing(
    availableForLongTerm: availableForLongTerm ?? this.availableForLongTerm,
    worksOnNetModel: worksOnNetModel ?? this.worksOnNetModel,
    openToSimilarOffers: openToSimilarOffers ?? this.openToSimilarOffers,
    hourlyRateMinUzs: hourlyRateMinUzs ?? this.hourlyRateMinUzs,
    hourlyRateMaxUzs: hourlyRateMaxUzs ?? this.hourlyRateMaxUzs,
    hourlyRateMinUsd: hourlyRateMinUsd ?? this.hourlyRateMinUsd,
    hourlyRateMaxUsd: hourlyRateMaxUsd ?? this.hourlyRateMaxUsd,
    dailyRateMinUzs: dailyRateMinUzs ?? this.dailyRateMinUzs,
    dailyRateMaxUzs: dailyRateMaxUzs ?? this.dailyRateMaxUzs,
    acceptsBarter: acceptsBarter ?? this.acceptsBarter,
    paymentTypes: paymentTypes ?? this.paymentTypes,
    exclusivityAvailable: exclusivityAvailable ?? this.exclusivityAvailable,
    campaignFee: campaignFee ?? this.campaignFee,
    campaignFeeCurrency: campaignFeeCurrency ?? this.campaignFeeCurrency,
    monthlyExclusivityFee: monthlyExclusivityFee ?? this.monthlyExclusivityFee,
    eventAppearanceFee: eventAppearanceFee ?? this.eventAppearanceFee,
  );

  Map<String, dynamic> toJson() {
    return {
      "available_for_long_term": availableForLongTerm,
      "works_on_net_model": worksOnNetModel,
      "open_to_similar_offers": openToSimilarOffers,
      "hourly_rate_min_uzs": hourlyRateMinUzs,
      "hourly_rate_max_uzs": hourlyRateMaxUzs,
      "hourly_rate_min_usd": hourlyRateMaxUsd,
      "hourly_rate_max_usd": hourlyRateMaxUsd,
      "daily_rate_min_uzs": dailyRateMinUzs,
      "daily_rate_max_uzs": dailyRateMaxUzs,
      "accepts_barter": acceptsBarter,
      "payment_types": paymentTypes,
      "exclusivity_available": exclusivityAvailable,
      "campaign_fee": campaignFee,
      "campaign_fee_currency": campaignFeeCurrency,
      "monthly_exclusivity_fee": monthlyExclusivityFee,
      "event_appearance_fee": eventAppearanceFee,
    }..removeWhere((key, value) => value == null);
  }
}

class SocialMediaAccount {
  final String platform;
  final String username;

  SocialMediaAccount({required this.platform, required this.username});

  Map<String, dynamic> toJson() {
    return {"platform": platform, "username": username};
  }
}
