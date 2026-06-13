import '../../../domain/entities/social_auth_entity.dart';

class SocialAuthModel {
  final String? message;
  final SocialAuthData? data;

  SocialAuthModel({this.message, this.data});

  factory SocialAuthModel.fromJson(Map<String, dynamic> json) {
    return SocialAuthModel(
      message: json['message'] as String?,
      data: json['data'] != null
          ? SocialAuthData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  SocialAuthEntity toEntity() {
    return SocialAuthEntity(
      access: data?.access,
      refresh: data?.refresh,
      isNewUser: data?.isNewUser,
      role: data?.role,
    );
  }
}

class SocialAuthData {
  final String? access;
  final String? refresh;
  final bool? isNewUser;
  final String? role;

  SocialAuthData({this.access, this.refresh, this.isNewUser, this.role});

  factory SocialAuthData.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    final userMap = user is Map<String, dynamic> ? user : null;
    return SocialAuthData(
      access: (json['access_token'] ?? json['access']) as String?,
      refresh: (json['refresh_token'] ?? json['refresh']) as String?,
      isNewUser:
          (json['is_new_user'] ?? userMap?['is_new_user']) as bool?,
      role: (json['role'] ?? userMap?['role']) as String?,
    );
  }
}
