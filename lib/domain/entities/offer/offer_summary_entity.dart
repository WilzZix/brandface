import 'package:equatable/equatable.dart';

class OfferSummaryEntity extends Equatable {
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

  const OfferSummaryEntity({
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
  });

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
  ];
}
