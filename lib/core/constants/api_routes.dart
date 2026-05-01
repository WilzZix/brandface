class ApiRoutes {
  static String baseUrl = 'https://api.influerax.com/api/';
  static String mediaBaseUrl = 'https://api.influerax.com';

  ///Login
  static String sendOtp = 'accounts/v1/auth/send-otp/';
  static String verifyOtp = 'accounts/v1/auth/verify-otp/';
  static String refreshToken = 'accounts/v1/auth/refresh-token/';
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
  static String niches = 'catalog/v1/niches/';
  static String serviceType = 'catalog/v1/service-types/';
  static String regions = 'catalog/v1/regions/';
  static String cities = 'catalog/v1/cities/';
  static String spheres = 'catalog/v1/spheres/';
  static String languages = 'catalog/v1/languages/';
  static String socialProfileStats = 'profiles/v1/social/channel-stats/';

  static String profile(String profileId) =>
      'profiles/v1/influencers/$profileId/';

  static String myProfile = 'profiles/v1/my/';
  static String myProfileGeneral = 'profiles/v1/my/general/';
  static String myProfileAudience = 'profiles/v1/my/audience/';
  static String myProfilePricing = 'profiles/v1/my/pricing/';
  static String influencerReviews(int influencerId) =>
      'profiles/v1/influencers/$influencerId/reviews/';

  static String myAwards = 'profiles/v1/my/awards/';
  static String deleteAward(int awardId) => 'profiles/v1/my/awards/$awardId/';

  static String brandOffers = 'offers/v1/';
  static String myApplications = 'offers/v1/my-applications/';
  static String recommendedOffers = 'offers/v1/recommended/';
  static String availableOffers = 'offers/v1/available/';
  static String availableOfferDetail(int id) => 'offers/v1/available/$id/';
  static String applyToOffer(int id) => 'offers/v1/$id/apply/';
  static String conversations = 'messaging/v1/conversations/';
  static String sendMessage(int conversationId) =>
      'messaging/v1/conversations/$conversationId/messages/send/';
  static String influencerAnalytics = 'analytics/v1/influencer/';
  static String notifications = 'notifications/v1/';
  static String markNotificationAsRead(int id) => 'notifications/v1/$id/read/';
  static String readAllNotifications = 'notifications/v1/read-all/';
  static String unreadNotificationsCount = 'notifications/v1/unread-count/';

  static String boostProfile = 'billing/v1/boost/';
  static String boostPackages = 'billing/v1/boost-packages/';
  static String cancelSubscription = 'billing/v1/cancel/';
  static String billingCards = 'billing/v1/cards/';
  static String billingCard(int cardId) => 'billing/v1/cards/$cardId/';
  static String mySubscription = 'billing/v1/my-subscription/';
  static String billingPlans = 'billing/v1/plans/';
  static String subscribeToPlan = 'billing/v1/subscribe/';
  static String billingTransactions = 'billing/v1/transactions/';
  static String portfolio = 'portfolio/v1/';
  static String portfolioDetail(int id) => 'portfolio/v1/$id/';
  static String addPortfolioImage(int id) => 'portfolio/v1/$id/images/';
  static String removePortfolioImage(int id, int imageId) =>
      'portfolio/v1/$id/images/$imageId/';
  static String publicPortfolio(int influencerId) =>
      'portfolio/v1/influencers/$influencerId/';
  static String uploadFile = 'uploads/v1/upload/file/';
  static String ambassadors = 'profiles/v1/influencers/';

  static String aiMatchRun(int offerId) => 'ai/v1/offers/$offerId/match/';
  static String aiMatchResults(int offerId) => 'ai/v1/offers/$offerId/results/';
  static String favourites = 'favourites/v1/';
  static String favouriteItem(int influencerId) => 'favourites/v1/$influencerId/';
  static String brandAnalytics = 'analytics/v1/brand/';
}
