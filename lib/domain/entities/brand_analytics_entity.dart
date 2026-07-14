import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';

base class BrandAnalyticsEntity {
  // ── Activity summary ────────────────────────────────────────────────────
  final int totalSearchesDone;
  final int totalOffersCreated;
  final int activeOffers;
  final int invitationsSent;
  final int totalAmbassadorApplications;
  final int totalInfluencerApplications;

  // ── Search insights ─────────────────────────────────────────────────────
  final int totalSearchesPerformed;
  final List<String> topSearchFilters;

  // ── Most viewed ambassadors (top 6 globally) ────────────────────────────
  final List<AiMatchResultEntity> mostViewedAmbassadors;

  // ── Offer performance chart ──────────────────────────────────────────────
  final List<OfferDayStat> performanceChart;
  final List<LabelCountStat> topNiches;
  final List<LabelCountStat> topRegions;
  final int viewedOffer;
  final int openedDetails;
  final int applicants;
  final int approved;

  // ── AI matching insights ─────────────────────────────────────────────────
  final int aiMatchScore;
  final String nicheFit;
  final String audienceFit;
  final String platformFit;

  // ── Top 4 recommended ambassadors ────────────────────────────────────────
  final List<AiMatchResultEntity> topRecommendedAmbassadors;

  // ── Audience insights ─────────────────────────────────────────────────────
  final double femalePercent;
  final double malePercent;
  final String topAgeGroup;
  final List<LabelCountStat> topCountries;

  const BrandAnalyticsEntity({
    this.totalSearchesDone = 0,
    this.totalOffersCreated = 0,
    this.activeOffers = 0,
    this.invitationsSent = 0,
    this.totalAmbassadorApplications = 0,
    this.totalInfluencerApplications = 0,
    this.totalSearchesPerformed = 0,
    this.topSearchFilters = const [],
    this.mostViewedAmbassadors = const [],
    this.performanceChart = const [],
    this.topNiches = const [],
    this.topRegions = const [],
    this.viewedOffer = 0,
    this.openedDetails = 0,
    this.applicants = 0,
    this.approved = 0,
    this.aiMatchScore = 0,
    this.nicheFit = '',
    this.audienceFit = '',
    this.platformFit = '',
    this.topRecommendedAmbassadors = const [],
    this.femalePercent = 0,
    this.malePercent = 0,
    this.topAgeGroup = '',
    this.topCountries = const [],
  });
}

base class OfferDayStat {
  final String day;   // "Mon", "Tue", ...
  final int views;
  final int applications;

  const OfferDayStat({
    required this.day,
    required this.views,
    required this.applications,
  });
}

class LabelCountStat {
  final String label;
  final int count;

  const LabelCountStat({required this.label, required this.count});
}
