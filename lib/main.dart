import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:brandface/presentation/registration/bloc/fill_profile/fill_profile_bloc.dart';
import 'package:brandface/presentation/registration/bloc/registration/registration_bloc.dart';
import 'package:brandface/presentation/splash_screen/bloc/init_app_cubit.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/di/app_di.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDi().init();
  LocaleSettings.setLocale(AppLocale.ru);
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
        BlocProvider(create: (context) => sl<FillProfileBloc>()),
        BlocProvider(
          create: (context) => InitAppCubit(sharedPrefService: sl())..initApp(),
        ),
      ],
      child: MaterialApp.router(
        locale: TranslationProvider.of(context).locale.flutterLocale,
        routerConfig: AppRouter.router,
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: AppColors.lightBg),
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
