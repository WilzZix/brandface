base class RegistrationEntity {
  final String role;
  final int profileId;
  final bool isEditMode;

  RegistrationEntity({
    required this.role,
    required this.profileId,
    this.isEditMode = false,
  });
}
