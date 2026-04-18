class RegistrationParams {
  final String role;
  final String? firstName;
  final String? lastName;
  final String? brandName;

  RegistrationParams({
    required this.role,
    this.firstName,
    this.lastName,
    this.brandName,
  });

  Map<String, dynamic> toJson() {
    if (brandName != null) {
      return {'brand_name': brandName, 'role': role};
    }
    return {'first_name': firstName, 'last_name': lastName, 'role': role};
  }
}
