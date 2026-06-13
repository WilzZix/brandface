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
      this == SocialProvider.google ||
      this == SocialProvider.telegram ||
      this == SocialProvider.facebook ||
      this == SocialProvider.linkedin ||
      this == SocialProvider.apple;
}
