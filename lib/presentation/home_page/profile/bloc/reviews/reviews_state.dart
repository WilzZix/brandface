import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/review_entity.dart';
import 'package:equatable/equatable.dart';

enum ReviewsStatus { initial, loading, success, failure }

class ReviewsState extends Equatable {
  final ReviewsStatus status;
  final List<ReviewEntity> reviews;
  final Failure? failure;
  final double averageRating;
  final int totalReviews;

  const ReviewsState({
    this.status = ReviewsStatus.initial,
    this.reviews = const [],
    this.failure,
    this.averageRating = 0,
    this.totalReviews = 0,
  });

  ReviewsState copyWith({
    ReviewsStatus? status,
    List<ReviewEntity>? reviews,
    Failure? failure,
    bool clearFailure = false,
    double? averageRating,
    int? totalReviews,
  }) {
    return ReviewsState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      failure: clearFailure ? null : failure ?? this.failure,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }

  @override
  List<Object?> get props => [
    status,
    reviews,
    failure,
    averageRating,
    totalReviews,
  ];
}
