base class SocialAuthEntity {
  final String? access;
  final String? refresh;
  final bool? isNewUser;
  final String? role;

  const SocialAuthEntity({
    required this.access,
    required this.refresh,
    required this.isNewUser,
    required this.role,
  });
}
