class RegistrationParams {
  final String role;
  final String firstName;
  final String lastName;

  RegistrationParams({required this.role, required this.firstName, required this.lastName});

  Map<String, dynamic> toJson() {
    return {'first_name': firstName, 'last_name': lastName, 'role': role};
  }
}
