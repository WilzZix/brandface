import 'package:brandface/presentation/home_page/ui/home_page.dart';
import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../core/di/app_di.dart';
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
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.arguments.otpCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
          otpVerified: () {
            context.go(HomePage.tag);
          },
          verifyingOtpFailure: () {},
          orElse: () {},
        );
      },
      child: Scaffold(
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
                controller: _controller,
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
                errorPinTheme: PinTheme(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.red, width: 1),
                  ),
                  width: 64,
                  height: 64,
                ),
              ),
              SizedBox(height: 24),
              Text('00:59', style: Typographies.bodyMedium),
              Spacer(),
              AppButtons.primary(
                title: t.onboarding.kContinue,
                onTap: () {
                  context.read<LoginBloc>().add(
                    LoginEvent.verifyOtp(phone: widget.arguments.phoneNumber, otp: widget.arguments.otpCode),
                  );
                },
              ),
              SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
