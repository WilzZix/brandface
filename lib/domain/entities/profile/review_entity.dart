import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final int id;
  final String reviewerName;
  final int rating;
  final String text;
  final DateTime? createdAt;

  const ReviewEntity({
    required this.id,
    required this.reviewerName,
    required this.rating,
    required this.text,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, reviewerName, rating, text, createdAt];
}
