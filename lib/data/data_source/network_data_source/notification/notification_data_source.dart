import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/models/notification/notification_model.dart';

abstract interface class NotificationDataSource {
  Future<List<NotificationModel>> getNotifications({bool? isRead});

  Future<NotificationModel> markAsRead({required int id});

  Future<int> markAllAsRead();
}

final class NotificationDataSourceImpl implements NotificationDataSource {
  final DioClient _dioClient;

  NotificationDataSourceImpl(this._dioClient);

  @override
  Future<List<NotificationModel>> getNotifications({bool? isRead}) async {
    final response = await _dioClient.get(
      ApiRoutes.notifications,
      queryParameters: isRead == null ? null : {'is_read': isRead},
    );

    final root = _asMap(response.data);
    final data = root['data'];
    final list = data is List ? data : <dynamic>[];

    return list
        .map((item) => NotificationModel.fromJson(_asMap(item)))
        .toList();
  }

  @override
  Future<NotificationModel> markAsRead({required int id}) async {
    final response = await _dioClient.post(
      ApiRoutes.markNotificationAsRead(id),
    );
    final root = _asMap(response.data);
    final data = root['data'];

    return NotificationModel.fromJson(
      data is Map ? Map<String, dynamic>.from(data) : root,
    );
  }

  @override
  Future<int> markAllAsRead() async {
    final response = await _dioClient.post(ApiRoutes.readAllNotifications);
    final root = _asMap(response.data);
    final data = root['data'];

    if (data is Map) {
      return _toInt(data['marked_count']);
    }

    return _toInt(root['marked_count']);
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return <String, dynamic>{};
  }

  int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
