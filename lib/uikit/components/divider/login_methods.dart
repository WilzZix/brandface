import 'package:brandface/presentation/registration/ui/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../tokens/colors.dart';

class LoginMethods extends StatefulWidget {
  const LoginMethods({super.key});

  @override
  State<LoginMethods> createState() => _LoginMethodsState();
}

class _LoginMethodsState extends State<LoginMethods> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          child: LoginMethodItem(iconPath: AppAssets.icGoogle),
          onTap: () => context.pushNamed(RegistrationPage.tag),
        ),
        LoginMethodItem(iconPath: AppAssets.icLinkedin),
        LoginMethodItem(iconPath: AppAssets.icApple),
        LoginMethodItem(iconPath: AppAssets.icInstagram),
        LoginMethodItem(iconPath: AppAssets.icTelegram),
        LoginMethodItem(iconPath: AppAssets.icFacebook),
      ],
    );
  }
}

class LoginMethodItem extends StatelessWidget {
  const LoginMethodItem({super.key, required this.iconPath});

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: BoxBorder.all(width: 1, color: AppColors.borderColor),
      ),
      child: SvgPicture.asset(iconPath),
    );
  }
}
