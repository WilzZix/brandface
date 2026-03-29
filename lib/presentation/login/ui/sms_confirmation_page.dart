import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

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
            SizedBox(height: 8),
            Text(
              'We have sent SMS code to your phone number **${widget.arguments.phoneNumber.replaceAll(' ', '').substring(widget.arguments.phoneNumber.length - 4)},please enter this code',
              style: Typographies.bodySmall,
            ),
            SizedBox(height: 24),
            Pinput(
              length: 6,
              defaultPinTheme: PinTheme(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.borderColor, width: 1),
                ),
                width: 64,
                height: 64,
              ),
              focusedPinTheme: PinTheme(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryDark, width: 1),
                ),
                width: 64,
                height: 64,
              ),
            ),
            SizedBox(height: 24),
            Text('00:59', style: Typographies.bodyMedium),
            Spacer(),
            AppButtons.primary(title: t.onboarding.kContinue, onTap: () {}),
            SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
