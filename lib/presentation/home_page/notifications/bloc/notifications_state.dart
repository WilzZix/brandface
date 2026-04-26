import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/notification/notification_entity.dart';
import 'package:equatable/equatable.dart';

enum NotificationsStatus { initial, loading, success, failure }

class NotificationsState extends Equatable {
  final NotificationsStatus status;
  final List<NotificationEntity> notifications;
  final Failure? failure;
  final bool isMarkAllLoading;

  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const [],
    this.failure,
    this.isMarkAllLoading = false,
  });

  int get unreadCount => notifications.where((item) => !item.isRead).length;

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<NotificationEntity>? notifications,
    Failure? failure,
    bool clearFailure = false,
    bool? isMarkAllLoading,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      failure: clearFailure ? null : failure ?? this.failure,
      isMarkAllLoading: isMarkAllLoading ?? this.isMarkAllLoading,
    );
  }

  @override
  List<Object?> get props => [status, notifications, failure, isMarkAllLoading];
}
