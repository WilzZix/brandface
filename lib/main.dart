import 'package:brandface/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: TranslationProvider.of(context).locale.flutterLocale,
      routerConfig: AppRouter.router,
      theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
    );
  }
}
