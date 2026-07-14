import 'dart:convert';

import 'package:brandface/domain/entities/notification/notification_entity.dart';

final class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.notificationType,
    required super.title,
    super.body,
    required super.isRead,
    super.readAt,
    super.data,
    super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: _toInt(json['id']),
      notificationType: json['notification_type']?.toString() ?? 'system',
      title: json['title']?.toString() ?? 'Notification',
      body: json['body']?.toString(),
      isRead: json['is_read'] == true,
      readAt: _toDateTime(json['read_at']),
      data: _stringifyData(json['data']),
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

  static String? _stringifyData(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is String) {
      return value;
    }

    try {
      return jsonEncode(value);
    } catch (_) {
      return value.toString();
    }
  }
}
