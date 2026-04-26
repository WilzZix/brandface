abstract class BrandStatsState {}

class BrandStatsInitial extends BrandStatsState {}

class BrandStatsLoading extends BrandStatsState {}

class BrandStatsLoaded extends BrandStatsState {
  final int activeOffersCount;
  final int totalApplicationsCount;

  BrandStatsLoaded({
    required this.activeOffersCount,
    required this.totalApplicationsCount,
  });
}

class BrandStatsFailure extends BrandStatsState {}
