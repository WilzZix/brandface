import 'dart:ui';

import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:brandface/presentation/registration/bloc/brand_registration/brand_registration_bloc.dart';
import 'package:brandface/presentation/registration/bloc/fill_brand_profile/fill_brand_profile_bloc.dart';
import 'package:brandface/presentation/registration/bloc/fill_profile/fill_profile_bloc.dart';
import 'package:brandface/presentation/registration/bloc/registration/registration_bloc.dart';
import 'package:brandface/presentation/splash_screen/bloc/init_app_cubit.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/di/app_di.dart';
import 'core/router/app_router.dart';
import 'firebase_options.dart';
import 'utils/services/app_language_service.dart';
import 'utils/services/push_notification_background_handler.dart';
import 'utils/services/push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await AppDi().init();

  final pushService = sl<PushNotificationService>();
  pushService.onNotificationTap = (data) {
    // Currently route to home for any notification.
    // Future: switch on data['type'] to route to specific screens.
    AppRouter.router.go('/');
  };
  await pushService.init();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  final savedLocale = await AppLanguageService(prefs: sl()).getAppLocale();
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  LocaleSettings.setLocale(savedLocale);
  runApp(TranslationProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<LoginBloc>()),
        BlocProvider(create: (context) => sl<RegistrationBloc>()),
        BlocProvider(create: (context) => sl<BrandRegistrationBloc>()),
        BlocProvider(create: (context) => sl<FillProfileBloc>()),
        BlocProvider(create: (context) => sl<FillBrandProfileBloc>()),
        BlocProvider(create: (context) => sl<InitAppCubit>()..initApp()),
      ],
      child: MaterialApp.router(
        locale: TranslationProvider.of(context).locale.flutterLocale,
        routerConfig: AppRouter.router,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.lightBg,
            titleTextStyle: Typographies.titleLarge,
          ),
          textTheme: GoogleFonts.interTextTheme(),
          scaffoldBackgroundColor: AppColors.lightBg,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: AppColors.lightBg,
          ),
        ),
      ),
    );
  }
}
