class InfluencerAnalyticsEntity {
  final int totalProfileViews;
  final int last30DaysProfileViews;
  final double averageRating;
  final int totalReviews;
  final int totalApplicationsSubmitted;
  final Map<String, int> applicationsByStatus;

  const InfluencerAnalyticsEntity({
    this.totalProfileViews = 0,
    this.last30DaysProfileViews = 0,
    this.averageRating = 0,
    this.totalReviews = 0,
    this.totalApplicationsSubmitted = 0,
    this.applicationsByStatus = const {},
  });
}
