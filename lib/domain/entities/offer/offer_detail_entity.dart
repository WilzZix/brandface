import 'package:equatable/equatable.dart';

base class OfferDetailEntity extends Equatable {
  final int id;
  final String title;
  final String brandName;
  final List<String> categories;
  final String status;
  final String visibility;
  final String? requiredGender;
  final int? requiredAgeMin;
  final int? requiredAgeMax;
  final String? requiredRegion;
  final String? requiredCity;
  final int? requiredFollowersMin;
  final int? requiredFollowersMax;
  final String? reward;
  final String? rewardAmount;
  final String? rewardCurrency;
  final String? duration;
  final DateTime? deadline;
  final int viewsCount;
  final int applicationsCount;
  final DateTime? createdAt;
  final String? description;
  final List<String> requiredLanguages;
  final List<String> requiredContentTypes;
  final String? requiredEngagementRate;
  final DateTime? updatedAt;
  final bool isApplied;

  const OfferDetailEntity({
    required this.id,
    required this.title,
    required this.brandName,
    this.categories = const [],
    this.status = '',
    this.visibility = '',
    this.requiredGender,
    this.requiredAgeMin,
    this.requiredAgeMax,
    this.requiredRegion,
    this.requiredCity,
    this.requiredFollowersMin,
    this.requiredFollowersMax,
    this.reward,
    this.rewardAmount,
    this.rewardCurrency,
    this.duration,
    this.deadline,
    this.viewsCount = 0,
    this.applicationsCount = 0,
    this.createdAt,
    this.description,
    this.requiredLanguages = const [],
    this.requiredContentTypes = const [],
    this.requiredEngagementRate,
    this.updatedAt,
    this.isApplied = false,
  });

  OfferDetailEntity copyWith({
    int? id,
    String? title,
    String? brandName,
    List<String>? categories,
    String? status,
    String? visibility,
    String? requiredGender,
    int? requiredAgeMin,
    int? requiredAgeMax,
    String? requiredRegion,
    String? requiredCity,
    int? requiredFollowersMin,
    int? requiredFollowersMax,
    String? reward,
    String? rewardAmount,
    String? rewardCurrency,
    String? duration,
    DateTime? deadline,
    int? viewsCount,
    int? applicationsCount,
    DateTime? createdAt,
    String? description,
    List<String>? requiredLanguages,
    List<String>? requiredContentTypes,
    String? requiredEngagementRate,
    DateTime? updatedAt,
    bool? isApplied,
  }) {
    return OfferDetailEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      brandName: brandName ?? this.brandName,
      categories: categories ?? this.categories,
      status: status ?? this.status,
      visibility: visibility ?? this.visibility,
      requiredGender: requiredGender ?? this.requiredGender,
      requiredAgeMin: requiredAgeMin ?? this.requiredAgeMin,
      requiredAgeMax: requiredAgeMax ?? this.requiredAgeMax,
      requiredRegion: requiredRegion ?? this.requiredRegion,
      requiredCity: requiredCity ?? this.requiredCity,
      requiredFollowersMin: requiredFollowersMin ?? this.requiredFollowersMin,
      requiredFollowersMax: requiredFollowersMax ?? this.requiredFollowersMax,
      reward: reward ?? this.reward,
      rewardAmount: rewardAmount ?? this.rewardAmount,
      rewardCurrency: rewardCurrency ?? this.rewardCurrency,
      duration: duration ?? this.duration,
      deadline: deadline ?? this.deadline,
      viewsCount: viewsCount ?? this.viewsCount,
      applicationsCount: applicationsCount ?? this.applicationsCount,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      requiredLanguages: requiredLanguages ?? this.requiredLanguages,
      requiredContentTypes: requiredContentTypes ?? this.requiredContentTypes,
      requiredEngagementRate:
          requiredEngagementRate ?? this.requiredEngagementRate,
      updatedAt: updatedAt ?? this.updatedAt,
      isApplied: isApplied ?? this.isApplied,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    brandName,
    categories,
    status,
    visibility,
    requiredGender,
    requiredAgeMin,
    requiredAgeMax,
    requiredRegion,
    requiredCity,
    requiredFollowersMin,
    requiredFollowersMax,
    reward,
    rewardAmount,
    rewardCurrency,
    duration,
    deadline,
    viewsCount,
    applicationsCount,
    createdAt,
    description,
    requiredLanguages,
    requiredContentTypes,
    requiredEngagementRate,
    updatedAt,
    isApplied,
  ];
}
