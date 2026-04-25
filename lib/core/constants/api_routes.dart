class ApiRoutes {
  static String baseUrl = 'https://api.influerax.com/api/';
  static String mediaBaseUrl = 'https://api.influerax.com';

  ///Login
  static String sendOtp = 'accounts/v1/auth/send-otp/';
  static String verifyOtp = 'accounts/v1/auth/verify-otp/';
  static String me = 'accounts/v1/auth/me/';
  static String deleteAccount = 'accounts/v1/auth/me/';

  ///Registration
  static String registration = 'accounts/v1/register/influencer/';
  static String brandRegistration = 'accounts/v1/register/brand/';

  static String fillProfile(String profileId) =>
      'accounts/v1/register/influencer/$profileId/';

  static String fillBrandProfile(String profileId) =>
      'accounts/v1/register/brand/$profileId/';

  ///Catalog public routes
  static String categories = 'catalog/v1/categories/';
  static String serviceType = 'catalog/v1/service-types/';
  static String regions = 'catalog/v1/regions/';
  static String cities = 'catalog/v1/cities/';
  static String languages = 'catalog/v1/languages/';
  static String socialProfileStats = 'profiles/v1/social/channel-stats/';

  static String profile(String profileId) =>
      'profiles/v1/influencers/$profileId/';

  static String myProfile = 'profiles/v1/my/';

  static String myAwards = 'profiles/v1/my/awards/';
  static String deleteAward(int awardId) => 'profiles/v1/my/awards/$awardId/';

  static String uploadFile = 'uploads/v1/upload/file/';

  ///Brand
  static String myBrandProfile = 'profiles/v1/me/brand/';
  static String brandAnalytics = 'analytics/v1/brand/';
  static String brandOffers = 'offers/v1/';
  static String aiMatchingResults(int offerId) =>
      'ai/v1/offers/$offerId/results/';

  ///Auth
  static String logout = 'accounts/v1/auth/logout/';
}
