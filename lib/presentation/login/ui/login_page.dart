import 'package:brandface/presentation/login/ui/term_of_use_page.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../uikit/components/divider/login_divider.dart';
import '../../../uikit/components/divider/login_methods.dart';
import '../../../uikit/components/inputs/phone_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String tag = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(t.login.welcome_msg, style: Typographies.headlineSmall),
            SizedBox(height: 24),
            PhoneInputField(),
            SizedBox(height: 24),
            LoginDivider(),
            SizedBox(height: 24),
            LoginMethods(),
            Spacer(),
            AppButtons.primary(title: t.onboarding.kContinue, onTap: () {}),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                context.push(TermOfUsePage.tag);
              },
              child: RichText(
                text: TextSpan(
                  text: t.login.term_of_use_first,
                  style: Typographies.bodySmall,
                  children: [
                    TextSpan(
                      text: t.login.term_of_use_second,
                      style: Typographies.bodySmall.copyWith(color: AppColors.primaryDark),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
