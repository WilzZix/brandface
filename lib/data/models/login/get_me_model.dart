import '../../../domain/entities/get_me_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.username,
    super.firstName,
    super.lastName,
    super.phoneNumber,
    required super.role,
    super.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      role: json['role'] ?? 'guest',
      isVerified: json['is_verified'] ?? false,
    );
  }

  // Agar kerak bo'lsa JSON-ga qaytarish uchun
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'role': role,
      'is_verified': isVerified,
    };
  }

  UserEntity toEntity() => this;
}
