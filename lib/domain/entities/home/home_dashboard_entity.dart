import 'package:brandface/domain/entities/profile/influencer_profile_information_entity.dart';
import 'package:equatable/equatable.dart';

class HomeDashboardEntity extends Equatable {
  final InfluencerProfileInformationEntity profile;
  final int unreadNotificationsCount;
  final int activeOffersCount;
  final int messagesCount;
  final List<RecommendedHomeOfferEntity> recommendations;

  const HomeDashboardEntity({
    required this.profile,
    required this.unreadNotificationsCount,
    required this.activeOffersCount,
    required this.messagesCount,
    required this.recommendations,
  });

  @override
  List<Object?> get props => [
    profile,
    unreadNotificationsCount,
    activeOffersCount,
    messagesCount,
    recommendations,
  ];
}

class RecommendedHomeOfferEntity extends Equatable {
  final int id;
  final String title;
  final String? description;
  final String? brandName;
  final DateTime? deadline;
  final List<String> categories;
  final double score;
  final String? reward;
  final String? rewardAmount;
  final String? rewardCurrency;

  const RecommendedHomeOfferEntity({
    required this.id,
    required this.title,
    this.description,
    this.brandName,
    this.deadline,
    this.categories = const [],
    this.score = 0,
    this.reward,
    this.rewardAmount,
    this.rewardCurrency,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    brandName,
    deadline,
    categories,
    score,
    reward,
    rewardAmount,
    rewardCurrency,
  ];
}
