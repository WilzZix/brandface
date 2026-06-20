import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/services/app_auth_local_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_assets.dart';
import '../../core/i18n/strings.g.dart';
import '../../uikit/components/buttons/buttons.dart';
import '../../uikit/tokens/colors.dart';
import '../login/ui/login_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  static const String tag = '/onboarding';

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 46 + MediaQuery.of(context).padding.top),
            child: SvgPicture.asset(AppAssets.icSplashBg),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                SizedBox(height: 32, child: SvgPicture.asset(AppAssets.icLogo)),
                SizedBox(height: 42),
                SvgPicture.asset(AppAssets.icOnBoarding),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  decoration: BoxDecoration(color: AppColors.lightBg2, borderRadius: BorderRadius.circular(128)),
                  child: Text(
                    textAlign: TextAlign.center,
                    t.onboarding.description,
                    style: Typographies.bodyMedium,
                  ),
                ),
                Spacer(),
                AppButtons.primary(
                  title: t.onboarding.kContinue,
                  onTap: () async {
                    await sl<IAuthLocalService>().markOnboardingSeen();
                    if (!context.mounted) return;
                    context.go(LoginPage.tag);
                  },
                ),
                SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
