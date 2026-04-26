import 'package:brandface/domain/entities/home/home_dashboard_entity.dart';

class HomeDashboardModel extends HomeDashboardEntity {
  const HomeDashboardModel({
    required super.profile,
    required super.unreadNotificationsCount,
    required super.activeOffersCount,
    required super.messagesCount,
    required super.recommendations,
  });
}

class RecommendedHomeOfferModel extends RecommendedHomeOfferEntity {
  const RecommendedHomeOfferModel({
    required super.id,
    required super.title,
    super.description,
    super.brandName,
    super.deadline,
    super.categories,
    super.score,
    super.reward,
    super.rewardAmount,
    super.rewardCurrency,
  });

  factory RecommendedHomeOfferModel.fromJson(Map<String, dynamic> json) {
    final nestedOfferJson = _readMap(json['offer']);
    final offerJson = nestedOfferJson.isNotEmpty ? nestedOfferJson : json;
    final categoriesRaw = offerJson['categories'];
    final categories = categoriesRaw is List
        ? categoriesRaw
              .map((item) => _readMap(item)['name']?.toString())
              .whereType<String>()
              .where((item) => item.trim().isNotEmpty)
              .toList()
        : <String>[];

    return RecommendedHomeOfferModel(
      id: _toInt(offerJson['id']),
      title: offerJson['title']?.toString() ?? 'Untitled offer',
      description: offerJson['description']?.toString(),
      brandName: offerJson['brand_name']?.toString(),
      deadline: _toDateTime(offerJson['deadline']),
      categories: categories,
      score: _toDouble(json['score']),
      reward: offerJson['reward']?.toString(),
      rewardAmount: offerJson['reward_amount']?.toString(),
      rewardCurrency: offerJson['reward_currency']?.toString(),
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

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime? _toDateTime(dynamic value) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value.toString());
  }
}
