import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final int id;
  final String notificationType;
  final String title;
  final String? body;
  final bool isRead;
  final DateTime? readAt;
  final String? data;
  final DateTime? createdAt;

  const NotificationEntity({
    required this.id,
    required this.notificationType,
    required this.title,
    this.body,
    required this.isRead,
    this.readAt,
    this.data,
    this.createdAt,
  });

  NotificationEntity copyWith({
    int? id,
    String? notificationType,
    String? title,
    String? body,
    bool? isRead,
    DateTime? readAt,
    String? data,
    DateTime? createdAt,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      notificationType: notificationType ?? this.notificationType,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    notificationType,
    title,
    body,
    isRead,
    readAt,
    data,
    createdAt,
  ];
}
