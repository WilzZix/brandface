import 'package:brandface/domain/entities/offer/offer_detail_entity.dart';

class OfferDetailModel extends OfferDetailEntity {
  const OfferDetailModel({
    required super.id,
    required super.title,
    required super.brandName,
    super.categories,
    super.status,
    super.visibility,
    super.requiredGender,
    super.requiredAgeMin,
    super.requiredAgeMax,
    super.requiredRegion,
    super.requiredCity,
    super.requiredFollowersMin,
    super.requiredFollowersMax,
    super.reward,
    super.rewardAmount,
    super.rewardCurrency,
    super.duration,
    super.deadline,
    super.viewsCount,
    super.applicationsCount,
    super.createdAt,
    super.description,
    super.requiredLanguages,
    super.requiredContentTypes,
    super.requiredEngagementRate,
    super.updatedAt,
    super.isApplied,
  });

  factory OfferDetailModel.fromJson(Map<String, dynamic> json) {
    return OfferDetailModel(
      id: _toInt(json['id']),
      title: json['title']?.toString() ?? 'Offer',
      brandName: json['brand_name']?.toString() ?? 'Brand',
      categories: _readNames(json['categories']),
      status: json['status']?.toString() ?? '',
      visibility: json['visibility']?.toString() ?? '',
      requiredGender: _nullableString(json['required_gender']),
      requiredAgeMin: _nullableInt(json['required_age_min']),
      requiredAgeMax: _nullableInt(json['required_age_max']),
      requiredRegion: _readMap(json['required_region'])['name']?.toString(),
      requiredCity: _readMap(json['required_city'])['name']?.toString(),
      requiredFollowersMin: _nullableInt(json['required_followers_min']),
      requiredFollowersMax: _nullableInt(json['required_followers_max']),
      reward: _nullableString(json['reward']),
      rewardAmount: _nullableString(json['reward_amount']),
      rewardCurrency: _nullableString(json['reward_currency']),
      duration: _nullableString(json['duration']),
      deadline: _toDateTime(json['deadline']),
      viewsCount: _toInt(json['views_count']),
      applicationsCount: _toInt(json['applications_count']),
      createdAt: _toDateTime(json['created_at']),
      description: _nullableString(json['description']),
      requiredLanguages: _readNames(json['required_languages']),
      requiredContentTypes: _readNames(json['required_content_types']),
      requiredEngagementRate: _nullableString(json['required_engagement_rate']),
      updatedAt: _toDateTime(json['updated_at']),
    );
  }

  static Map<String, dynamic> _readMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return <String, dynamic>{};
  }

  static List<String> _readNames(dynamic value) {
    if (value is! List) {
      return const [];
    }

    return value
        .map((item) => _readMap(item)['name']?.toString())
        .whereType<String>()
        .where((item) => item.trim().isNotEmpty)
        .toList();
  }

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int? _nullableInt(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is int) {
      return value;
    }

    return int.tryParse(value.toString());
  }

  static String? _nullableString(dynamic value) {
    final text = value?.toString().trim();
    if (text == null || text.isEmpty || text == 'null') {
      return null;
    }

    return text;
  }

  static DateTime? _toDateTime(dynamic value) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value.toString());
  }
}
