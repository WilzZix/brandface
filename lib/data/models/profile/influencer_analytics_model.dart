import 'package:brandface/domain/entities/profile/influencer_analytics_entity.dart';

class InfluencerAnalyticsModel extends InfluencerAnalyticsEntity {
  const InfluencerAnalyticsModel({
    required super.totalProfileViews,
    required super.last30DaysProfileViews,
    required super.averageRating,
    required super.totalReviews,
    required super.totalApplicationsSubmitted,
    required super.applicationsByStatus,
  });

  factory InfluencerAnalyticsModel.fromApiJson(dynamic payload) {
    final root = _asMap(payload);
    final rawData = root['data'];
    final data = rawData is Map<String, dynamic>
        ? rawData
        : rawData is Map
        ? Map<String, dynamic>.from(rawData)
        : root;

    final applicationsByStatus = _readStatusBreakdown(data);
    final explicitTotalApplications = _readInt(data, const [
      'total_applications_submitted',
      'applications_submitted_total',
      'total_applications',
    ]);

    return InfluencerAnalyticsModel(
      totalProfileViews: _readInt(data, const [
        'total_profile_views',
        'profile_views_total',
        'profile_views',
        'total_views',
      ]),
      last30DaysProfileViews: _readInt(data, const [
        'last_30_days_profile_views',
        'profile_views_last_30_days',
        'last30_profile_views',
        'views_last_30_days',
      ]),
      averageRating: _readDouble(data, const ['average_rating']),
      totalReviews: _readInt(data, const ['total_reviews']),
      totalApplicationsSubmitted: explicitTotalApplications > 0
          ? explicitTotalApplications
          : applicationsByStatus.values.fold<int>(
              0,
              (sum, value) => sum + value,
            ),
      applicationsByStatus: applicationsByStatus,
    );
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return <String, dynamic>{};
  }

  static int _readInt(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is int) {
        return value;
      }
      if (value is double) {
        return value.round();
      }
      if (value is String) {
        final parsedInt = int.tryParse(value);
        if (parsedInt != null) {
          return parsedInt;
        }
        final parsedDouble = double.tryParse(value);
        if (parsedDouble != null) {
          return parsedDouble.round();
        }
      }
    }
    return 0;
  }

  static double _readDouble(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is double) {
        return value;
      }
      if (value is int) {
        return value.toDouble();
      }
      if (value is String) {
        final parsed = double.tryParse(value);
        if (parsed != null) {
          return parsed;
        }
      }
    }
    return 0;
  }

  static Map<String, int> _readStatusBreakdown(Map<String, dynamic> data) {
    final breakdownValue =
        data['applications_by_status'] ??
        data['applications_breakdown'] ??
        data['application_status_breakdown'];

    if (breakdownValue is Map<String, dynamic>) {
      return breakdownValue.map(
        (key, value) => MapEntry(key, _readStatusValue(value)),
      );
    }

    if (breakdownValue is Map) {
      return Map<String, dynamic>.from(
        breakdownValue,
      ).map((key, value) => MapEntry(key, _readStatusValue(value)));
    }

    return <String, int>{};
  }

  static int _readStatusValue(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value.round();
    }
    if (value is String) {
      return int.tryParse(value) ?? double.tryParse(value)?.round() ?? 0;
    }
    if (value is Map<String, dynamic>) {
      return _readInt(value, const ['count', 'total', 'value']);
    }
    if (value is Map) {
      return _readInt(Map<String, dynamic>.from(value), const [
        'count',
        'total',
        'value',
      ]);
    }
    return 0;
  }
}
