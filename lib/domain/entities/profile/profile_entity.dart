import 'package:equatable/equatable.dart';

import '../../usecase/registration/params/fill_influencer_profile_param.dart';

class ProfileEntity extends Equatable {
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
  final List<ContactEntity>? contacts;
  final List<int>? categoryIds;
  final List<int>? serviceIds;
  final List<int>? languageIds;
  final AudienceEntity? audience;
  final PricingEntity? pricing;

  const ProfileEntity({
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
      // ContactEntity -> Contact (Model) o'girish
      contacts: contacts?.map((e) => Contact(
        type: e.type,
        value: e.value,
      )).toList(),
      categoryIds: categoryIds,
      serviceIds: serviceIds,
      languageIds: languageIds,
      // AudienceEntity -> Audience (Model) o'girish
      audience: audience != null ? Audience(
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
      ) : null,
      // PricingEntity -> Pricing (Model) o'girish
      pricing: pricing != null ? Pricing(
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
      ) : null,
    );
  }
  @override
  List<Object?> get props => [
    displayName, avatarId, bio, regionId, cityId, birthDate,
    gender, yearsOfExperience, hasAdExperience, pressMentions,
    agencyRepresentation, partners, contacts, categoryIds,
    serviceIds, languageIds, audience, pricing,
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
  });

  @override
  List<Object?> get props => [
    brandSegment, totalFollowers, malePercent, femalePercent,
    menAgeFrom, menAgeTo, womenAgeFrom, womenAgeTo,
    engagementRate, geography, socialMediaStats,
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
  });

  @override
  List<Object?> get props => [
    availableForLongTerm, worksOnNetModel, openToSimilarOffers,
    hourlyRateMinUzs, hourlyRateMaxUzs, hourlyRateMinUsd,
    hourlyRateMaxUsd, dailyRateMinUzs, dailyRateMaxUzs,
    acceptsBarter, paymentTypes, exclusivityAvailable,
    campaignFee, campaignFeeCurrency, monthlyExclusivityFee,
    eventAppearanceFee,
  ];
}