import 'package:brandface/presentation/login/ui/sms_confirmation_page.dart';
import 'package:brandface/presentation/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/home_page/ui/home_page.dart';
import '../../presentation/login/ui/arguments/sms_confirmation_page_arguments.dart';
import '../../presentation/login/ui/login_page.dart';
import '../../presentation/login/ui/term_of_use_page.dart';
import '../../presentation/onboarding/onboarding.dart';
import '../../presentation/registration/ui/fill_profile_information_page.dart';
import '../../presentation/registration/ui/registration_page.dart';
import '../enums/enums.dart';

class AppRouter {
  static GoRouter router = GoRouter(
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
        builder: (_, _) => HomePage(),
      ),
      GoRoute(
        path: RegistrationPage.tag,
        name: RegistrationPage.tag,
        builder: (_, _) => RegistrationPage(),
      ),
      GoRoute(
        path: FillProfileInformationPage.tag,
        name: FillProfileInformationPage.tag,
        builder: (_, state) =>
            FillProfileInformationPage(userRole: state.extra as UserRole),
      ),
      GoRoute(
        path: SmsConfirmationPage.tag,
        name: SmsConfirmationPage.tag,
        builder: (_, state) => SmsConfirmationPage(
          arguments: state.extra as SmsConfirmationPageArguments,
        ),
      ),
    ],
  );
}
