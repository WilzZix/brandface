import 'package:brandface/domain/entities/profile/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.reviewerName,
    required super.rating,
    required super.text,
    super.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: _toInt(json['id']),
      reviewerName: json['reviewer_name']?.toString() ?? 'Anonymous',
      rating: _toInt(json['rating']),
      text: json['text']?.toString() ?? '',
      createdAt: _toDateTime(json['created_at']),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime? _toDateTime(dynamic value) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value.toString());
  }
}
