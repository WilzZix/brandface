import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/notification/notification_entity.dart';
import 'package:brandface/presentation/home_page/notifications/bloc/notifications_cubit.dart';
import 'package:brandface/presentation/home_page/notifications/bloc/notifications_state.dart';
import 'package:brandface/presentation/home_page/notifications/notification_details_page.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static const String tag = '/notifications_page';

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsCubit, NotificationsState>(
      listenWhen: (previous, current) =>
          previous.failure != current.failure && current.failure != null,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.failure!.message)));
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(t.notifications.title, style: Typographies.titleLarge),
          actions: [
            BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                final canMarkAll =
                    state.unreadCount > 0 && !state.isMarkAllLoading;

                return TextButton(
                  onPressed: canMarkAll
                      ? () => context.read<NotificationsCubit>().markAllAsRead()
                      : null,
                  child: state.isMarkAllLoading
                      ? SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.black,
                          ),
                        )
                      : Text(
                          t.notifications.read_all,
                          style: Typographies.labelLarge.copyWith(
                            color: canMarkAll
                                ? AppColors.black
                                : AppColors.grey,
                          ),
                        ),
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state.status == NotificationsStatus.loading &&
                state.notifications.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == NotificationsStatus.failure &&
                state.notifications.isEmpty) {
              return _NotificationsErrorState(
                failure: state.failure,
                onRetry: () => context
                    .read<NotificationsCubit>()
                    .loadNotifications(force: true),
              );
            }

            if (state.notifications.isEmpty) {
              return RefreshIndicator(
                onRefresh: () => context
                    .read<NotificationsCubit>()
                    .loadNotifications(force: true),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  children: const [_NotificationsEmptyState()],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => context
                  .read<NotificationsCubit>()
                  .loadNotifications(force: true),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // Mark as read then open details
                      context
                          .read<NotificationsCubit>()
                          .markAsRead(notification);
                      context.pushNamed(
                        NotificationDetailsPage.tag,
                        extra: notification,
                      );
                    },
                    child: _NotificationCard(notification: notification),
                  );
                },
                separatorBuilder: (_, _) => const SizedBox(height: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification});

  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: notification.isRead ? AppColors.lightBg3 : AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  notification.title,
                  style: Typographies.titleMedium,
                ),
              ),
              if (!notification.isRead)
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.orange,
                  ),
                ),
            ],
          ),
          if ((notification.body ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              notification.body!.trim(),
              style: Typographies.bodyMedium.copyWith(
                color: AppColors.mutedBlack,
              ),
            ),
          ],
          const SizedBox(height: 12),
          Divider(color: AppColors.borderColor),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  _formatDate(notification.createdAt),
                  style: Typographies.titleSmall.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
              SvgPicture.asset(AppAssets.icChevronRight),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? value) {
    if (value == null) {
      return t.common.unknown_date;
    }

    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final local = value.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = monthNames[local.month - 1];
    final year = local.year.toString();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');

    return '$day $month $year, $hour:$minute';
  }
}

class _NotificationsEmptyState extends StatelessWidget {
  const _NotificationsEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        t.notifications.no_notifications,
        style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _NotificationsErrorState extends StatelessWidget {
  const _NotificationsErrorState({
    required this.failure,
    required this.onRetry,
  });

  final Failure? failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              failure?.message ?? t.notifications.error_load,
              style: Typographies.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              t.common.pull_refresh_or_retry,
              style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: AppColors.white,
              ),
              child: Text(t.common.try_again),
            ),
          ],
        ),
      ),
    );
  }
}
