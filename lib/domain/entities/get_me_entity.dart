import 'package:equatable/equatable.dart';

base class UserEntity extends Equatable {
  final int id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String role;
  final bool isVerified;

  const UserEntity({
    required this.id,
    required this.username,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    required this.role,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    firstName,
    lastName,
    phoneNumber,
    role,
    isVerified,
  ];
}