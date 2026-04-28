import 'package:brandface/core/navigation/app_navigator_key.dart';
import 'package:brandface/presentation/login/ui/sms_confirmation_page.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/language/language_cubit.dart';
import 'package:brandface/presentation/registration/bloc/get_profile/get_profile_cubit.dart';
import 'package:brandface/presentation/splash_screen/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/registration/registration_entity.dart';
import '../../presentation/home_page/brand_home_page.dart';
import '../../presentation/home_page/bloc/home_cubit.dart';
import '../../presentation/home_page/brand_profile_page.dart';
import '../../presentation/home_page/home_page.dart';
import '../../presentation/home_page/messages/bloc/messages_cubit.dart';
import '../../presentation/home_page/messages/messages_page.dart';
import '../../presentation/home_page/notifications/bloc/notifications_cubit.dart';
import '../../presentation/home_page/notifications/notifications_page.dart';
import '../../presentation/home_page/offers/bloc/offer_detail_cubit.dart';
import '../../presentation/home_page/offers/bloc/offers_feed_cubit.dart';
import '../../presentation/home_page/offers/offer_detail_page.dart';
import '../../presentation/home_page/offers/offers_from_brands_page.dart';
import '../../presentation/home_page/profile/bloc/profile_information/profile_information_cubit.dart';
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
import '../../presentation/login/ui/login_page.dart';
import '../../presentation/login/ui/term_of_use_page.dart';
import '../../presentation/onboarding/onboarding.dart';
import '../../presentation/registration/ui/fill_profile_information_page.dart';
import '../../presentation/registration/ui/registration_page.dart';
import '../di/app_di.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: appNavigatorKey,
    initialLocation: SplashScreen.tag,
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
        builder: (_, _) => BrandHomePage(),
      ),
      GoRoute(
        path: BrandProfilePage.tag,
        name: BrandProfilePage.tag,
        builder: (_, _) => BrandProfilePage(),
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
        path: NotificationsPage.tag,
        name: NotificationsPage.tag,
        builder: (_, _) => BlocProvider<NotificationsCubit>(
          create: (context) => sl<NotificationsCubit>()..loadNotifications(),
          child: NotificationsPage(),
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
    ],
  );
}
