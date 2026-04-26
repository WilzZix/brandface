import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/notification/notification_entity.dart';
import 'package:brandface/domain/usecase/notification/get_notifications_use_case.dart';
import 'package:brandface/domain/usecase/notification/mark_all_notifications_read_use_case.dart';
import 'package:brandface/domain/usecase/notification/mark_notification_read_use_case.dart';
import 'package:brandface/presentation/home_page/notifications/bloc/notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final MarkNotificationReadUseCase _markNotificationReadUseCase;
  final MarkAllNotificationsReadUseCase _markAllNotificationsReadUseCase;

  NotificationsCubit({
    required GetNotificationsUseCase getNotificationsUseCase,
    required MarkNotificationReadUseCase markNotificationReadUseCase,
    required MarkAllNotificationsReadUseCase markAllNotificationsReadUseCase,
  }) : _getNotificationsUseCase = getNotificationsUseCase,
       _markNotificationReadUseCase = markNotificationReadUseCase,
       _markAllNotificationsReadUseCase = markAllNotificationsReadUseCase,
       super(const NotificationsState());

  Future<void> loadNotifications({bool force = false}) async {
    if (!force && state.status == NotificationsStatus.loading) {
      return;
    }

    emit(
      state.copyWith(status: NotificationsStatus.loading, clearFailure: true),
    );

    final result = await _getNotificationsUseCase.call(params: null);

    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(status: NotificationsStatus.failure, failure: failure),
      ),
      ifRight: (notifications) => emit(
        state.copyWith(
          status: NotificationsStatus.success,
          notifications: notifications,
          clearFailure: true,
        ),
      ),
    );
  }

  Future<void> markAsRead(NotificationEntity notification) async {
    if (notification.isRead) {
      return;
    }

    final currentNotifications = List<NotificationEntity>.from(
      state.notifications,
    );
    final optimisticNotifications = currentNotifications
        .map(
          (item) => item.id == notification.id
              ? item.copyWith(isRead: true, readAt: DateTime.now())
              : item,
        )
        .toList();

    emit(
      state.copyWith(
        notifications: optimisticNotifications,
        clearFailure: true,
      ),
    );

    final result = await _markNotificationReadUseCase.call(
      params: notification.id,
    );

    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(notifications: currentNotifications, failure: failure),
      ),
      ifRight: (updatedNotification) {
        final refreshedNotifications = optimisticNotifications
            .map(
              (item) => item.id == updatedNotification.id
                  ? updatedNotification
                  : item,
            )
            .toList();
        emit(
          state.copyWith(
            notifications: refreshedNotifications,
            clearFailure: true,
          ),
        );
      },
    );
  }

  Future<void> markAllAsRead() async {
    if (state.unreadCount == 0 || state.isMarkAllLoading) {
      return;
    }

    final currentNotifications = List<NotificationEntity>.from(
      state.notifications,
    );
    final now = DateTime.now();
    final optimisticNotifications = currentNotifications
        .map(
          (item) =>
              item.isRead ? item : item.copyWith(isRead: true, readAt: now),
        )
        .toList();

    emit(
      state.copyWith(
        notifications: optimisticNotifications,
        isMarkAllLoading: true,
        clearFailure: true,
      ),
    );

    final result = await _markAllNotificationsReadUseCase.call(params: null);

    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(
          notifications: currentNotifications,
          isMarkAllLoading: false,
          failure: failure,
        ),
      ),
      ifRight: (_) => emit(
        state.copyWith(
          notifications: optimisticNotifications,
          isMarkAllLoading: false,
          clearFailure: true,
        ),
      ),
    );
  }
}
