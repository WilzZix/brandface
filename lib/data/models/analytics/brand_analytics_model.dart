import 'package:brandface/data/models/ai_matching/ai_match_result_model.dart';
import 'package:brandface/domain/entities/ai_matching/ai_match_result_entity.dart';
import 'package:brandface/domain/entities/brand_analytics_entity.dart';

class BrandAnalyticsModel extends BrandAnalyticsEntity {
  const BrandAnalyticsModel({
    required super.totalSearchesDone,
    required super.totalOffersCreated,
    required super.activeOffers,
    required super.invitationsSent,
    required super.totalAmbassadorApplications,
    required super.totalInfluencerApplications,
    required super.totalSearchesPerformed,
    required super.topSearchFilters,
    required super.mostViewedAmbassadors,
    required super.performanceChart,
    required super.topNiches,
    required super.topRegions,
    required super.viewedOffer,
    required super.openedDetails,
    required super.applicants,
    required super.approved,
    required super.aiMatchScore,
    required super.nicheFit,
    required super.audienceFit,
    required super.platformFit,
    required super.topRecommendedAmbassadors,
    required super.femalePercent,
    required super.malePercent,
    required super.topAgeGroup,
    required super.topCountries,
  });

  factory BrandAnalyticsModel.fromApiJson(dynamic payload) {
    final root = _asMap(payload);
    // API wraps everything in { "message": "...", "data": { ... } }
    final data = root['data'] is Map
        ? Map<String, dynamic>.from(root['data'] as Map)
        : root;

    // ── Activity summary ────────────────────────────────────────────────
    // Fields may be under a nested key OR flat at root level
    final activity = _sub(data, ['activity_summary', 'activity']);
    final activitySrc = activity.isNotEmpty ? activity : data;

    final searchInsights = _sub(data, ['search_insights', 'search']);
    final searchSrc = searchInsights.isNotEmpty ? searchInsights : data;

    // ── Offer performance chart ─────────────────────────────────────────
    final perfSection = _sub(data, ['offer_performance', 'performance']);
    // API uses "chart_data" key
    final chartRaw = perfSection['chart'] ??
        perfSection['daily'] ??
        data['chart_data'] ??
        data['performance_chart'] ??
        [];
    final List<OfferDayStat> chart = _parseList(chartRaw, (e) {
      final m = _asMap(e);
      return OfferDayStat(
        day: m['day']?.toString() ?? m['date']?.toString() ?? '',
        views: _int(m, ['views', 'view_count']),
        applications: _int(m, ['applications', 'application_count', 'apps']),
      );
    });

    final topNiches = _parseLabelCount(
      perfSection['top_niches'] ?? data['top_niches'],
    );
    final topRegions = _parseLabelCount(
      perfSection['top_regions'] ?? data['top_regions'],
    );

    // ── Offer stats grid ────────────────────────────────────────────────
    final offerStats = _sub(data, ['offer_stats', 'offer_performance']);
    final statsSrc = offerStats.isNotEmpty ? offerStats : perfSection.isNotEmpty ? perfSection : data;

    // ── AI matching insights ─────────────────────────────────────────────
    // "ai_matching_insights" can be null
    final aiRaw = data['ai_matching_insights'];
    final aiSection = aiRaw is Map ? _asMap(aiRaw) : <String, dynamic>{};
    final aiSrc = aiSection.isNotEmpty ? aiSection : data;
    final score = _int(aiSrc, ['ai_match_score', 'avg_score', 'average_score', 'score']);
    final nicheFit = _str(aiSrc, ['niche_fit']);
    final audienceFit = _str(aiSrc, ['audience_fit']);
    final platformFit = _str(aiSrc, ['platform_fit']);

    // ── Recommended ambassadors ─────────────────────────────────────────
    final recRaw = aiSection['top_recommended_ambassadors'] ??
        data['top_recommended_ambassadors'] ??
        data['recommended_ambassadors'] ??
        [];
    final topRecommended = _parseList(recRaw, (e) {
      return _parseAnalyticsAmbassador(_asMap(e));
    });

    // ── Most viewed ambassadors ─────────────────────────────────────────
    // API returns items with "id" (not "influencer_id") and nullable int fields
    final mostViewedRaw =
        data['most_viewed_ambassadors'] ?? data['most_searched_ambassadors'] ?? [];
    final mostViewed = _parseList(mostViewedRaw, (e) {
      return _parseAnalyticsAmbassador(_asMap(e));
    });

    // ── Audience insights ───────────────────────────────────────────────
    final audienceSection = _sub(data, ['audience_insights', 'audience']);
    final genderRaw =
        audienceSection['gender_distribution'] ?? audienceSection['gender'] ?? {};
    final genderMap = _asMap(genderRaw);
    final femalePercent = _double(genderMap, ['female', 'female_percent']);
    final malePercent = _double(genderMap, ['male', 'male_percent']);
    final topAgeGroup =
        _str(audienceSection, ['top_age_group', 'dominant_age_group', 'age_group']);
    final topCountries = _parseLabelCount(
      audienceSection['top_countries'] ?? audienceSection['countries'],
    );

    return BrandAnalyticsModel(
      // Activity — try nested section first, fallback to root data
      totalSearchesDone:
          _int(activitySrc, ['total_searches_done', 'searches_done', 'total_searches']),
      totalOffersCreated:
          _int(activitySrc, ['total_offers_created', 'offers_created', 'total_offers']),
      activeOffers: _int(activitySrc, ['active_offers']),
      invitationsSent: _int(activitySrc, ['invitations_sent', 'invitations']),
      totalAmbassadorApplications: _int(activitySrc, [
        'total_ambassador_applications',
        'ambassador_applications',
        'total_applications',
      ]),
      totalInfluencerApplications: _int(activitySrc, [
        'total_influencer_applications',
        'influencer_applications',
      ]),
      totalSearchesPerformed: _int(
          searchSrc, ['total_searches_performed', 'total_searches', 'searches_count']),
      topSearchFilters:
          _strList(searchSrc['top_search_filters'] ?? searchSrc['top_filters']),
      mostViewedAmbassadors: mostViewed,
      performanceChart: chart,
      topNiches: topNiches,
      topRegions: topRegions,
      viewedOffer: _int(statsSrc, ['viewed_offer', 'offer_views', 'total_offer_views', 'views']),
      openedDetails:
          _int(statsSrc, ['opened_details', 'detail_opens', 'details_opened']),
      applicants: _int(statsSrc, ['applicants', 'total_applicants', 'total_applications']),
      approved: _int(statsSrc, ['approved', 'total_approved']),
      aiMatchScore: score,
      nicheFit: nicheFit,
      audienceFit: audienceFit,
      platformFit: platformFit,
      topRecommendedAmbassadors: topRecommended,
      femalePercent: femalePercent,
      malePercent: malePercent,
      topAgeGroup: topAgeGroup,
      topCountries: topCountries,
    );
  }

  // ── Analytics-specific ambassador parser ─────────────────────────────────
  // API returns a different structure than AiMatchResultModel:
  // - "id" instead of "influencer_id"
  // - "total_followers" can be int, null, or String
  // - "average_rating", "engagement_rate" can be null
  // - No "score", "region", "city", "categories" fields
  static AiMatchResultEntity _parseAnalyticsAmbassador(Map<String, dynamic> m) {
    // Try standard key first ("influencer_id"), fall back to "id"
    final influencerId = _int(m, ['influencer_id', 'id']);

    // total_followers: API may send int, String, or null — normalise to String
    final followersRaw = m['total_followers'];
    final String totalFollowers;
    if (followersRaw == null) {
      totalFollowers = '0';
    } else if (followersRaw is int) {
      totalFollowers = followersRaw.toString();
    } else {
      totalFollowers = followersRaw.toString();
    }

    // average_rating: can be null or double/string
    final ratingRaw = m['average_rating'];
    final String averageRating;
    if (ratingRaw == null) {
      averageRating = '0';
    } else if (ratingRaw is num) {
      averageRating = ratingRaw.toString();
    } else {
      averageRating = ratingRaw.toString();
    }

    // engagement_rate: can be null
    final engRaw = m['engagement_rate'];
    final String engagementRate =
        engRaw == null ? '0' : engRaw.toString();

    // For ambassadors from this endpoint, try AiMatchResultModel keys first
    // (in case the backend starts returning the full format later)
    if (m.containsKey('influencer_id')) {
      return AiMatchResultModel.fromJson(m).toEntity();
    }

    return AiMatchResultEntity(
      influencerId: influencerId,
      displayName: m['display_name']?.toString() ?? '',
      avatarUrl: m['avatar_url']?.toString() ?? '',
      averageRating: averageRating,
      totalReviews: _int(m, ['total_reviews']),
      totalFollowers: totalFollowers,
      engagementRate: engagementRate,
      region: m['region']?.toString() ?? '',
      city: m['city']?.toString() ?? '',
      categories: m['categories']?.toString() ?? '',
      isVerified: m['is_verified'] as bool? ?? false,
      isTop: m['is_top'] as bool? ?? false,
      score: _double(m, ['score', 'view_count']),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  static Map<String, dynamic> _asMap(dynamic v) {
    if (v is Map<String, dynamic>) return v;
    if (v is Map) return Map<String, dynamic>.from(v);
    return {};
  }

  static Map<String, dynamic> _sub(Map<String, dynamic> data, List<String> keys) {
    for (final k in keys) {
      if (data[k] is Map) return _asMap(data[k]);
    }
    return {};
  }

  static int _int(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      final v = m[k];
      if (v is int) return v;
      if (v is double) return v.round();
      if (v is String) {
        final i = int.tryParse(v);
        if (i != null) return i;
        final d = double.tryParse(v);
        if (d != null) return d.round();
      }
    }
    return 0;
  }

  static double _double(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      final v = m[k];
      if (v is double) return v;
      if (v is int) return v.toDouble();
      if (v is String) {
        final d = double.tryParse(v);
        if (d != null) return d;
      }
    }
    return 0;
  }

  static String _str(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      final v = m[k];
      if (v is String && v.isNotEmpty) return v;
    }
    return '';
  }

  static List<String> _strList(dynamic raw) {
    if (raw is List) return raw.map((e) => e.toString()).toList();
    return [];
  }

  static List<T> _parseList<T>(dynamic raw, T Function(dynamic) mapper) {
    if (raw is! List) return [];
    return raw.map(mapper).toList();
  }

  static List<LabelCountStat> _parseLabelCount(dynamic raw) {
    if (raw is List) {
      return raw.map((e) {
        final m = _asMap(e);
        return LabelCountStat(
          label: m['label']?.toString() ??
              m['name']?.toString() ??
              m['niche']?.toString() ??
              m['region']?.toString() ??
              '',
          count: _int(m, ['count', 'value', 'total']),
        );
      }).toList();
    }
    if (raw is Map) {
      return _asMap(raw).entries.map((e) {
        final v = e.value;
        final count = v is int
            ? v
            : (v is double
                ? v.round()
                : (int.tryParse(v.toString()) ?? 0));
        return LabelCountStat(label: e.key, count: count);
      }).toList();
    }
    return [];
  }
}
