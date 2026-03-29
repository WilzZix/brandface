import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:brandface/presentation/login/ui/term_of_use_page.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/app_di.dart';
import '../../../core/i18n/strings.g.dart';
import '../../../uikit/components/divider/login_divider.dart';
import '../../../uikit/components/divider/login_methods.dart';
import '../../../uikit/components/inputs/phone_input_field.dart';
import 'arguments/sms_confirmation_page_arguments.dart';
import 'sms_confirmation_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String tag = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          state.maybeWhen(
            otpReceived: (otpEntity) {
              context.push(
                SmsConfirmationPage.tag,
                extra: SmsConfirmationPageArguments(phoneNumber: _controller.text, otpCode: otpEntity.code ?? ''),
              );
            },
            otpReceivingFailure: (msg) {
              //TODO error handling
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(t.login.welcome_msg, style: Typographies.headlineSmall),
                SizedBox(height: 24),
                PhoneInputField(controller: _controller),
                SizedBox(height: 24),
                LoginDivider(),
                SizedBox(height: 24),
                LoginMethods(),
                Spacer(),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return AppButtons.primary(
                      title: t.onboarding.kContinue,
                      onTap: () {
                        context.read<LoginBloc>().add(LoginEvent.sendOtp(phone: _controller.text));
                      },
                    );
                  },
                ),
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
        ),
      ),
    );
  }
}
