import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';

/// FCM qurilma tokenini backend bilan sinxronlaydigan data source.
///
/// Backend kontrakti:
///   PUT    /api/accounts/v1/auth/device-token/  { "fcm_token": "..." }
///   DELETE /api/accounts/v1/auth/device-token/
/// Ikkalasi ham `Authorization: Bearer <access>` talab qiladi — bu header
/// [DioClient]dagi AuthInterceptor tomonidan avtomatik qo'shiladi.
abstract interface class DeviceTokenDataSource {
  /// Tokenni saqlash / yangilash (login yoki token refresh'dan keyin).
  Future<void> registerToken(String fcmToken);

  /// Tokenni o'chirish (logout'dan oldin, access token hali amal qilayotganda).
  Future<void> deleteToken();
}

final class DeviceTokenDataSourceImpl implements DeviceTokenDataSource {
  final DioClient _dioClient;

  DeviceTokenDataSourceImpl(this._dioClient);

  @override
  Future<void> registerToken(String fcmToken) async {
    await _dioClient.put(
      ApiRoutes.deviceToken,
      data: {'fcm_token': fcmToken},
    );
  }

  @override
  Future<void> deleteToken() async {
    await _dioClient.delete(ApiRoutes.deviceToken);
  }
}
