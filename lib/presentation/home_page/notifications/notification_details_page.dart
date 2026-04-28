import 'package:brandface/domain/entities/notification/notification_entity.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class NotificationDetailsPage extends StatelessWidget {
  const NotificationDetailsPage({super.key, required this.notification});

  static const String tag = '/notification-details';

  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        backgroundColor: AppColors.lightBg,
        scrolledUnderElevation: 0,
        title: Text('Notification details', style: Typographies.titleMedium),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title,
              style: Typographies.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              _formatDate(notification.createdAt),
              style: Typographies.bodySmall.copyWith(color: AppColors.grey),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            if ((notification.body ?? '').trim().isNotEmpty)
              Text(
                notification.body!.trim(),
                style: Typographies.bodyMedium.copyWith(
                  height: 1.6,
                  color: AppColors.black,
                ),
              )
            else
              Text(
                'No additional details.',
                style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? value) {
    if (value == null) return '';
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    final local = value.toLocal();
    return '${local.day} ${months[local.month - 1]}, ${local.year}';
  }
}
