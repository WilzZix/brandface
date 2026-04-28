import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/influencer_analytics_entity.dart';
import 'package:equatable/equatable.dart';

enum StatsStatus { initial, loading, success, failure }

class StatsState extends Equatable {
  final StatsStatus status;
  final InfluencerAnalyticsEntity analytics;
  final Failure? failure;

  const StatsState({
    this.status = StatsStatus.initial,
    this.analytics = const InfluencerAnalyticsEntity(),
    this.failure,
  });

  StatsState copyWith({
    StatsStatus? status,
    InfluencerAnalyticsEntity? analytics,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return StatsState(
      status: status ?? this.status,
      analytics: analytics ?? this.analytics,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, analytics, failure];
}
