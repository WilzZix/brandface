import 'package:brandface/presentation/splash_screen/bloc/init_app_cubit.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_assets.dart';
import '../../core/i18n/strings.g.dart';
import '../home_page/ui/home_page.dart';
import '../login/ui/login_page.dart';
import '../registration/ui/registration_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String tag = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InitAppCubit, InitAppState>(
        listener: (context, state) {
          state.maybeWhen(
            appInitialized: (isLoggedIn) {
              context.go(LoginPage.tag);
            },
            orElse: () {},
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 46 + MediaQuery.of(context).padding.top,
              ),
              child: SvgPicture.asset(AppAssets.icSplashBg),
            ),
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .5),
                Center(child: SvgPicture.asset(AppAssets.icLogo)),
                Spacer(),
                Text(
                  t.splash.app_version(version: '1.0.0'),
                  style: Typographies.bodySmall.copyWith(
                    color: AppColors.mutedBlack,
                  ),
                ),
                SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
