import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/entities/profile/award_entity.dart';
import 'package:brandface/domain/entities/profile/profile_entity.dart';
import 'package:brandface/domain/entities/profile/review_entity.dart';

final class AmbassadorDetailModel extends AmbassadorDetailEntity {
  const AmbassadorDetailModel({
    required super.id,
    super.displayName,
    super.avatarUrl,
    super.bio,
    super.regionName,
    super.cityName,
    super.gender,
    required super.categories,
    required super.services,
    required super.languages,
    super.yearsOfExperience,
    required super.isVerified,
    required super.isTop,
    required super.isVip,
    required super.averageRating,
    required super.totalReviews,
    required super.contacts,
    required super.partners,
    super.audience,
    super.pricing,
    required super.availableDates,
    required super.awards,
    required super.reviews,
  });

  factory AmbassadorDetailModel.fromJson(Map<String, dynamic> json) {
    List<String> names(dynamic raw) {
      if (raw is! List) return const [];
      return raw
          .map((e) => e is Map ? e['name']?.toString() ?? '' : e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList(growable: false);
    }

    double? rating;
    final rawRating = json['average_rating'];
    if (rawRating != null) {
      rating = rawRating is double ? rawRating : double.tryParse(rawRating.toString());
    }

    final contacts = (json['contacts'] as List?)
            ?.map((e) => ContactEntity(
                  type: e['type']?.toString(),
                  value: e['value']?.toString(),
                ))
            .toList() ??
        const [];

    final partners = (json['partners'] as List?)
            ?.map((e) => e?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList() ??
        const <String>[];

    final audience = json['audience_info'] is Map
        ? AudienceEntity.fromJson(json['audience_info'] as Map<String, dynamic>)
        : null;

    final pricing = json['pricing_info'] is Map
        ? PricingEntity.fromJson(json['pricing_info'] as Map<String, dynamic>)
        : null;

    final availableDates = (json['available_dates'] as List?)
            ?.whereType<Map>()
            .map((e) => AvailableDateItem(
                  id: e['id'] as int? ?? 0,
                  dateFrom: e['date_from']?.toString() ?? '',
                  dateTo: e['date_to']?.toString() ?? '',
                  note: e['note']?.toString(),
                ))
            .toList() ??
        const [];

    final awards = (json['awards'] as List?)
            ?.whereType<Map>()
            .map((e) => AwardEntity(
                  id: e['id'] as int? ?? 0,
                  title: e['title']?.toString() ?? '',
                ))
            .toList() ??
        const [];

    final reviews = (json['reviews'] as List?)
            ?.whereType<Map>()
            .map((e) => ReviewEntity(
                  id: e['id'] as int? ?? 0,
                  reviewerName: e['reviewer_name']?.toString() ?? '',
                  rating: e['rating'] as int? ?? 0,
                  text: e['text']?.toString() ?? '',
                  createdAt: e['created_at'] != null
                      ? DateTime.tryParse(e['created_at'].toString())
                      : null,
                ))
            .toList() ??
        const [];

    return AmbassadorDetailModel(
      id: json['id'] as int,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
      regionName: (json['region'] is Map) ? json['region']['name'] as String? : null,
      cityName: (json['city'] is Map) ? json['city']['name'] as String? : null,
      gender: json['gender'] as String?,
      categories: names(json['categories']),
      services: names(json['services']),
      languages: names(json['languages']),
      yearsOfExperience: json['years_of_experience'] as int?,
      isVerified: json['is_verified'] as bool? ?? false,
      isTop: json['is_top'] as bool? ?? false,
      isVip: json['is_vip'] as bool? ?? false,
      averageRating: rating,
      totalReviews: json['total_reviews'] as int? ?? 0,
      contacts: contacts,
      partners: partners,
      audience: audience,
      pricing: pricing,
      availableDates: availableDates,
      awards: awards,
      reviews: reviews,
    );
  }
}
