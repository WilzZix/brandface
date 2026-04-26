import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/home/home_dashboard_entity.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final HomeDashboardEntity? dashboard;
  final Failure? failure;

  const HomeState({
    this.status = HomeStatus.initial,
    this.dashboard,
    this.failure,
  });

  HomeState copyWith({
    HomeStatus? status,
    HomeDashboardEntity? dashboard,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, dashboard, failure];
}
