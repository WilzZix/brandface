enum SocialProvider {
  google('google'),
  telegram('telegram'),
  facebook('facebook'),
  linkedin('linkedin'),
  apple('apple'),
  instagram('instagram');

  final String apiValue;

  const SocialProvider(this.apiValue);

  bool get isSupportedByBackend =>
      this == .google ||
      this == .telegram ||
      this == .facebook ||
      this == .linkedin ||
      this == .apple;
}
