class ApiRoutes {
  static String baseUrl = 'https://api.influerax.com/api/';

  ///Login
  static String sendOtp = 'accounts/v1/auth/send-otp/';
  static String verifyOtp = 'accounts/v1/auth/verify-otp/';

  ///Registration
  static String registration = 'accounts/v1/register/influencer/';

  static String fillProfile(String profileId) =>
      'accounts/v1/register/influencer/$profileId/';

  ///Catalog public routes
  static String categories = 'catalog/v1/categories/';
  static String serviceType = 'catalog/v1/service-types/';
  static String regions = 'catalog/v1/regions/';
  static String cities = 'catalog/v1/cities/';
}
