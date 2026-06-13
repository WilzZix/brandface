import 'package:brandface/core/navigation/app_navigator_key.dart';
import 'package:brandface/core/router/route_logger.dart';
import 'package:brandface/presentation/login/ui/sms_confirmation_page.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/city/city_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/language/language_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/region/region_cubit.dart';
import 'package:brandface/presentation/registration/bloc/get_profile/get_profile_cubit.dart';
import 'package:brandface/presentation/splash_screen/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/registration/registration_entity.dart';
import '../../presentation/home_page/brand/bloc/ai_matching/ai_matching_cubit.dart';
import '../../presentation/home_page/brand/bloc/brand_stats_cubit.dart';
import '../../presentation/home_page/brand/bloc/collaboration_offers_cubit.dart';
import '../../presentation/home_page/brand/bloc/create_offer/create_offer_cubit.dart';
import '../../presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart';
import '../../presentation/home_page/brand/ui/ambassadors_page.dart';
import '../../presentation/home_page/brand/ui/ambassadors_filter_page.dart';
import '../../presentation/home_page/brand/ui/ambassador_details_page.dart';
import '../../presentation/home_page/brand/ui/ambassador_portfolio_details_page.dart';
import '../../presentation/home_page/brand/ui/send_enquiry_page.dart';
import '../../presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_cubit.dart';
import '../../presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_cubit.dart';
import '../../domain/entities/profile/portfolio_entity.dart';
import '../../presentation/home_page/brand/ui/brand_home_page.dart';
import '../../presentation/home_page/brand/ui/create_offer_page.dart';
import '../../presentation/home_page/bloc/home_cubit.dart';
import '../../presentation/home_page/brand/ui/brand_profile_menu_page.dart';
import '../../presentation/home_page/brand/ui/brand_profile_page.dart';
import '../../presentation/home_page/brand/ui/ai_matching_results_page.dart';
import '../../presentation/home_page/brand/ui/favourites_page.dart';
import '../../presentation/home_page/brand/bloc/favourites/favourites_cubit.dart';
import '../../presentation/home_page/brand/ui/brand_analytics_page.dart';
import '../../presentation/home_page/brand/bloc/brand_analytics/brand_analytics_cubit.dart';
import '../../presentation/home_page/brand/ui/brand_plan_page.dart';
import '../../presentation/home_page/brand/ui/brand_offer_detail_page.dart';
import '../../presentation/home_page/brand/ui/collaboration_offers_page.dart';
import '../../presentation/home_page/profile/bloc/profile_information/profile_information_cubit.dart';
import '../../presentation/registration/bloc/fill_brand_profile/fill_brand_profile_bloc.dart';
import '../../presentation/home_page/home_page.dart';
import '../../presentation/home_page/messages/bloc/messages_cubit.dart';
import '../../presentation/home_page/messages/messages_page.dart';
import '../../presentation/home_page/notifications/bloc/notifications_cubit.dart';
import '../../presentation/home_page/notifications/notifications_page.dart';
import '../../presentation/home_page/notifications/notification_details_page.dart';
import '../../domain/entities/notification/notification_entity.dart';
import '../../presentation/home_page/offers/bloc/offer_detail_cubit.dart';
import '../../presentation/home_page/offers/bloc/offers_feed_cubit.dart';
import '../../presentation/home_page/offers/offer_detail_page.dart';
import '../../presentation/home_page/offers/offers_from_brands_page.dart';
import '../../domain/entities/billing/billing_entities.dart';
import '../../presentation/home_page/brand/ui/brand_my_cards_page.dart';
import '../../presentation/home_page/brand/ui/add_payment_method_page.dart';
import '../../presentation/home_page/brand/ui/sms_otp_page.dart';
import '../../presentation/home_page/profile/bloc/billing/billing_cubit.dart';
import '../../presentation/home_page/profile/bloc/portfolio/portfolio_item_cubit.dart';
import '../../presentation/home_page/profile/bloc/portfolio/portfolio_list_cubit.dart';
import '../../presentation/home_page/profile/bloc/reviews/reviews_cubit.dart';
import '../../presentation/home_page/profile/bloc/stats/stats_cubit.dart';
import '../../presentation/home_page/profile/ui/billing.dart';
import '../../presentation/home_page/profile/ui/calendar_page.dart';
import '../../presentation/home_page/profile/ui/edit_portfolio_page.dart';
import '../../presentation/home_page/profile/ui/portfolio_details_page.dart';
import '../../presentation/home_page/profile/ui/portfolio_page.dart';
import '../../presentation/home_page/profile/ui/profile_information_page.dart';
import '../../presentation/home_page/profile/ui/profile_page.dart';
import '../../presentation/home_page/profile/ui/reviews.dart';
import '../../presentation/home_page/profile/ui/stats_page.dart';
import '../../presentation/home_page/profile/ui/top_profile_page.dart';
import '../../presentation/home_page/recomendations/recomendations.dart';
import '../../presentation/login/ui/arguments/sms_confirmation_page_arguments.dart';
import '../../presentation/login/ui/linkedin_auth_page.dart';
import '../../presentation/login/ui/login_page.dart';
import '../../presentation/login/ui/telegram_auth_page.dart';
import '../../presentation/login/ui/term_of_use_page.dart';
import '../../presentation/onboarding/onboarding.dart';
import '../../presentation/registration/ui/fill_profile_information_page.dart';
import '../../presentation/registration/ui/registration_page.dart';
import '../di/app_di.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: appNavigatorKey,
    initialLocation: SplashScreen.tag,
    // Logs every navigation event to console AND updates the on-screen
    // path overlay (see RoutePathOverlay in main.dart).
    debugLogDiagnostics: true,
    observers: [RouteLoggerObserver()],
    // redirect: (context, state) {
    //   final authService = sl<IAuthLocalService>();
    //   final loggedIn = authService.isLoggedIn();
    //
    //   // Foydalanuvchi login sahifasida bo'lsa
    //   final isLoggingIn = state.matchedLocation == LoginPage.tag;
    //
    //   if (!loggedIn) {
    //     // Login qilmagan bo'lsa va login sahifasida bo'lmasa -> Loginga haydaymiz
    //     return isLoggingIn ? null : LoginPage.tag;
    //   }
    //
    //   // Agar login qilgan bo'lsa va yana loginga kirmoqchi bo'lsa -> Homega
    //   if (isLoggingIn) {
    //     return HomePage.tag;
    //   }
    //
    //   // Qolgan holatlarda o'z yo'lida davom etadi
    //   return null;
    // },
    routes: [
      GoRoute(
        path: SplashScreen.tag,
        name: SplashScreen.tag,
        builder: (_, _) {
          return SplashScreen();
        },
      ),
      GoRoute(
        path: Onboarding.tag,
        name: Onboarding.tag,
        builder: (_, _) => Onboarding(),
      ),
      GoRoute(
        path: LoginPage.tag,
        name: LoginPage.tag,
        builder: (_, _) => LoginPage(),
      ),
      GoRoute(
        path: TermOfUsePage.tag,
        name: TermOfUsePage.tag,
        builder: (_, _) => TermOfUsePage(),
      ),
      GoRoute(
        path: HomePage.tag,
        name: HomePage.tag,
        builder: (_, _) => BlocProvider<HomeCubit>(
          create: (context) => sl<HomeCubit>()..loadHome(),
          child: HomePage(),
        ),
      ),
      GoRoute(
        path: BrandHomePage.tag,
        name: BrandHomePage.tag,
        builder: (_, _) => MultiBlocProvider(
          providers: [
            BlocProvider<BrandStatsCubit>(
              create: (context) => sl<BrandStatsCubit>()..loadStats(),
            ),
            BlocProvider<AiMatchingCubit>(
              create: (context) => sl<AiMatchingCubit>()..init(),
            ),
            BlocProvider<ProfileInformationCubit>(
              create: (context) =>
                  sl<ProfileInformationCubit>()..getInfluencerProfileInformation(),
            ),
          ],
          child: BrandHomePage(),
        ),
      ),
      GoRoute(
        path: BrandProfileMenuPage.tag,
        name: BrandProfileMenuPage.tag,
        builder: (_, _) => const BrandProfileMenuPage(),
      ),
      GoRoute(
        path: BrandProfilePage.tag,
        name: BrandProfilePage.tag,
        builder: (_, _) => MultiBlocProvider(
          providers: [
            BlocProvider<LanguageCubit>(
              create: (context) => sl<LanguageCubit>(),
            ),
            BlocProvider<ProfileInformationCubit>(
              create: (context) =>
                  sl<ProfileInformationCubit>()..getInfluencerProfileInformation(),
            ),
            BlocProvider<FillBrandProfileBloc>(
              create: (context) => sl<FillBrandProfileBloc>(),
            ),
          ],
          child: const BrandProfilePage(),
        ),
      ),
      GoRoute(
        path: ProfilePage.tag,
        name: ProfilePage.tag,
        builder: (_, _) => ProfilePage(),
      ),
      GoRoute(
        path: RegistrationPage.tag,
        name: RegistrationPage.tag,
        builder: (_, _) => RegistrationPage(),
      ),
      GoRoute(
        path: FillProfileInformationPage.tag,
        name: FillProfileInformationPage.tag,
        builder: (_, state) => BlocProvider(
          create: (context) => GetProfileCubit(
            getProfileUseCase: sl(),
            getInfluencerProfileUseCase: sl(),
          ),
          child: FillProfileInformationPage(
            registrationEntity: state.extra as RegistrationEntity,
          ),
        ),
      ),
      GoRoute(
        path: SmsConfirmationPage.tag,
        name: SmsConfirmationPage.tag,
        builder: (_, state) => SmsConfirmationPage(
          arguments: state.extra as SmsConfirmationPageArguments,
        ),
      ),
      GoRoute(
        path: LinkedInAuthPage.tag,
        name: LinkedInAuthPage.tag,
        builder: (_, _) => const LinkedInAuthPage(),
      ),
      GoRoute(
        path: TelegramAuthPage.tag,
        name: TelegramAuthPage.tag,
        builder: (_, _) => const TelegramAuthPage(),
      ),

      GoRoute(
        path: NotificationsPage.tag,
        name: NotificationsPage.tag,
        builder: (_, _) => BlocProvider<NotificationsCubit>(
          create: (context) => sl<NotificationsCubit>()..loadNotifications(),
          child: NotificationsPage(),
        ),
      ),
      GoRoute(
        path: NotificationDetailsPage.tag,
        name: NotificationDetailsPage.tag,
        builder: (_, state) => NotificationDetailsPage(
          notification: state.extra as NotificationEntity,
        ),
      ),
      GoRoute(
        path: MessagesPage.tag,
        name: MessagesPage.tag,
        builder: (_, _) => BlocProvider<MessagesCubit>(
          create: (context) => sl<MessagesCubit>()..loadMessages(),
          child: const MessagesPage(),
        ),
      ),
      GoRoute(
        path: OffersFromBrandsPage.tag,
        name: OffersFromBrandsPage.tag,
        builder: (_, _) => MultiBlocProvider(
          providers: [
            BlocProvider<OffersFeedCubit>(
              create: (context) => sl<OffersFeedCubit>()..loadAvailableOffers(),
            ),
            BlocProvider<CategoryCubit>(
              create: (context) => sl<CategoryCubit>()..getCategory(),
            ),
          ],
          child: OffersFromBrandsPage(),
        ),
      ),
      GoRoute(
        path: Recommendation.tag,
        name: Recommendation.tag,
        builder: (_, _) => BlocProvider<OffersFeedCubit>(
          create: (context) => sl<OffersFeedCubit>()..loadRecommendedOffers(),
          child: Recommendation(),
        ),
      ),
      GoRoute(
        path: OfferDetailPage.tag,
        name: OfferDetailPage.tag,
        builder: (_, state) => BlocProvider<OfferDetailCubit>(
          create: (context) {
            final cubit = sl<OfferDetailCubit>();
            final offerId = state.extra is int ? state.extra as int : null;
            if (offerId != null) {
              cubit.loadOffer(offerId);
            }
            return cubit;
          },
          child: OfferDetailPage(
            offerId: state.extra is int ? state.extra as int : null,
          ),
        ),
      ),
      GoRoute(
        path: ProfileInformationPage.tag,
        name: ProfileInformationPage.tag,
        builder: (_, _) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<ProfileInformationCubit>()),
            BlocProvider(create: (context) => sl<LanguageCubit>()),
            BlocProvider(create: (context) => sl<CategoryCubit>()),
          ],
          child: const ProfileInformationPage(),
        ),
      ),
      GoRoute(
        path: Reviews.tag,
        name: Reviews.tag,
        builder: (_, _) => BlocProvider<ReviewsCubit>(
          create: (context) => sl<ReviewsCubit>()..loadReviews(),
          child: Reviews(),
        ),
      ),
      GoRoute(
        path: StatsPage.tag,
        name: StatsPage.tag,
        builder: (_, _) => BlocProvider<StatsCubit>(
          create: (context) => sl<StatsCubit>()..loadAnalytics(),
          child: const StatsPage(),
        ),
      ),
      GoRoute(
        path: CalendarPage.tag,
        name: CalendarPage.tag,
        builder: (_, _) => const CalendarPage(),
      ),
      GoRoute(
        path: PortfolioPage.tag,
        name: PortfolioPage.tag,
        builder: (_, _) => BlocProvider<PortfolioListCubit>(
          create: (context) => sl<PortfolioListCubit>()..loadPortfolios(),
          child: const PortfolioPage(),
        ),
      ),
      GoRoute(
        path: PortfolioDetailsPage.tag,
        name: PortfolioDetailsPage.tag,
        builder: (_, state) => BlocProvider<PortfolioItemCubit>(
          create: (context) {
            final cubit = sl<PortfolioItemCubit>();
            final portfolioId = state.extra is int ? state.extra as int : 0;
            if (portfolioId > 0) {
              cubit.loadPortfolio(portfolioId);
            }
            return cubit;
          },
          child: PortfolioDetailsPage(
            portfolioId: state.extra is int ? state.extra as int : 0,
          ),
        ),
      ),
      GoRoute(
        path: EditPortfolioPage.tag,
        name: EditPortfolioPage.tag,
        builder: (_, state) => BlocProvider<PortfolioItemCubit>(
          create: (context) {
            final cubit = sl<PortfolioItemCubit>();
            final portfolioId = state.extra is int ? state.extra as int : 0;
            if (portfolioId > 0) {
              cubit.loadPortfolio(portfolioId);
            }
            return cubit;
          },
          child: EditPortfolioPage(
            portfolioId: state.extra is int ? state.extra as int : 0,
          ),
        ),
      ),
      GoRoute(
        path: TopProfilePage.tag,
        name: TopProfilePage.tag,
        builder: (_, _) => BlocProvider<BillingCubit>(
          create: (context) => sl<BillingCubit>()..loadBilling(),
          child: const TopProfilePage(),
        ),
      ),
      GoRoute(
        path: Billing.tag,
        name: Billing.tag,
        builder: (_, _) => BlocProvider<BillingCubit>(
          create: (context) => sl<BillingCubit>()..loadBilling(),
          child: Billing(),
        ),
      ),
      GoRoute(
        path: CollaborationOffersPage.tag,
        name: CollaborationOffersPage.tag,
        builder: (_, _) => BlocProvider<CollaborationOffersCubit>(
          create: (context) => sl<CollaborationOffersCubit>()..loadActive(),
          child: CollaborationOffersPage(),
        ),
      ),
      GoRoute(
        path: BrandOfferDetailPage.tag,
        name: BrandOfferDetailPage.tag,
        builder: (_, state) => BlocProvider<OfferDetailCubit>(
          create: (context) {
            final cubit = sl<OfferDetailCubit>();
            final offerId = state.extra is int ? state.extra as int : null;
            if (offerId != null) cubit.loadOffer(offerId);
            return cubit;
          },
          child: BrandOfferDetailPage(
            offerId: state.extra is int ? state.extra as int : 0,
          ),
        ),
      ),
      GoRoute(
        path: AmbassadorsPage.tag,
        name: AmbassadorsPage.tag,
        builder: (_, state) {
          final args = state.extra as AmbassadorsPageArguments?;
          return BlocProvider<AmbassadorsCubit>(
            create: (context) =>
                sl<AmbassadorsCubit>()..load(role: args?.role),
            child: AmbassadorsPage(title: args?.title),
          );
        },
      ),
      GoRoute(
        path: AmbassadorsFilterPage.tag,
        name: AmbassadorsFilterPage.tag,
        builder: (_, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<CategoryCubit>()..getCategory(),
            ),
            BlocProvider(
              create: (_) => sl<RegionCubit>()..getCategories(),
            ),
            BlocProvider(
              create: (_) => sl<LanguageCubit>()..getLanguages(),
            ),
          ],
          child: AmbassadorsFilterPage(
            initial: state.extra as AmbassadorsFilterParams?,
          ),
        ),
      ),
      GoRoute(
        path: AmbassadorDetailsPage.tag,
        name: AmbassadorDetailsPage.tag,
        builder: (_, state) {
          final ambassadorId = state.extra as int;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    sl<AmbassadorDetailCubit>()..load(ambassadorId),
              ),
              BlocProvider(
                create: (_) =>
                    sl<AmbassadorPortfolioCubit>()..load(ambassadorId),
              ),
            ],
            child: AmbassadorDetailsPage(ambassadorId: ambassadorId),
          );
        },
      ),
      GoRoute(
        path: AmbassadorPortfolioDetailsPage.tag,
        name: AmbassadorPortfolioDetailsPage.tag,
        builder: (_, state) => AmbassadorPortfolioDetailsPage(
          item: state.extra as PortfolioItemEntity,
        ),
      ),
      GoRoute(
        path: SendEnquiryPage.tag,
        name: SendEnquiryPage.tag,
        builder: (_, state) => SendEnquiryPage(
          arguments: state.extra as SendEnquiryArguments,
        ),
      ),
      GoRoute(
        path: AiMatchingResultsPage.tag,
        name: AiMatchingResultsPage.tag,
        builder: (_, _) => BlocProvider<AiMatchingCubit>(
          create: (context) => sl<AiMatchingCubit>()..init(),
          child: const AiMatchingResultsPage(),
        ),
      ),
      GoRoute(
        path: FavouritesPage.tag,
        name: FavouritesPage.tag,
        builder: (_, _) => BlocProvider<FavouritesCubit>(
          create: (context) => sl<FavouritesCubit>()..load(),
          child: const FavouritesPage(),
        ),
      ),
      GoRoute(
        path: BrandPlanPage.tag,
        name: BrandPlanPage.tag,
        builder: (_, _) => BlocProvider<BillingCubit>(
          create: (context) => sl<BillingCubit>()..loadBilling(),
          child: const BrandPlanPage(),
        ),
      ),
      GoRoute(
        path: BrandAnalyticsPage.tag,
        name: BrandAnalyticsPage.tag,
        builder: (_, _) => BlocProvider<BrandAnalyticsCubit>(
          create: (context) => sl<BrandAnalyticsCubit>()..load(),
          child: const BrandAnalyticsPage(),
        ),
      ),
      GoRoute(
        path: BrandMyCardsPage.tag,
        name: BrandMyCardsPage.tag,
        builder: (_, _) => BlocProvider<BillingCubit>(
          create: (context) => sl<BillingCubit>()..loadBilling(),
          child: const BrandMyCardsPage(),
        ),
      ),
      GoRoute(
        path: AddPaymentMethodPage.tag,
        name: AddPaymentMethodPage.tag,
        builder: (_, state) => BlocProvider<BillingCubit>(
          create: (context) => sl<BillingCubit>()..loadBilling(),
          child: AddPaymentMethodPage(
            editCard: state.extra is BillingCardEntity
                ? state.extra as BillingCardEntity
                : null,
          ),
        ),
      ),
      GoRoute(
        path: SmsOtpPage.tag,
        name: SmsOtpPage.tag,
        builder: (_, state) => SmsOtpPage(
          args: state.extra as SmsOtpArgs,
        ),
      ),
      GoRoute(
        path: CreateOfferPage.tag,
        name: CreateOfferPage.tag,
        builder: (_, _) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CreateOfferCubit>()),
            BlocProvider(create: (_) => sl<CategoryCubit>()),
            BlocProvider(create: (_) => sl<RegionCubit>()),
            BlocProvider(create: (_) => sl<CityCubit>()),
          ],
          child: const CreateOfferPage(),
        ),
      ),
    ],
  );
}
