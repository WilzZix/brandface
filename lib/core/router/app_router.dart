import 'package:brandface/presentation/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/onboarding/onboarding.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: SplashScreen.tag,
    routes: [
      GoRoute(
        path: SplashScreen.tag,
        name: SplashScreen.tag,
        builder: (_, _) {
          return SplashScreen();
        },
      ),
      GoRoute(path: Onboarding.tag, name: Onboarding.tag, builder: (_, _) => Onboarding()),
    ],
  );
}
