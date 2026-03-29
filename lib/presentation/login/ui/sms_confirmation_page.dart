import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../uikit/components/buttons/buttons.dart';
import '../../../uikit/typography/typography.dart';
import 'arguments/sms_confirmation_page_arguments.dart';

class SmsConfirmationPage extends StatefulWidget {
  const SmsConfirmationPage({super.key, required this.arguments});

  final SmsConfirmationPageArguments arguments;
  static const String tag = '/sms_confirmation_page';

  @override
  State<SmsConfirmationPage> createState() => _SmsConfirmationPageState();
}

class _SmsConfirmationPageState extends State<SmsConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.lightBg),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text('SMS confirmation', style: Typographies.headlineSmall),
            SizedBox(height: 24),
            AppButtons.primary(title: t.onboarding.kContinue, onTap: () {}),
            SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
