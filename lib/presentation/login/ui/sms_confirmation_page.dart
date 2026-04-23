import 'dart:async';

import 'package:brandface/domain/usecase/login/params/verify_otp_params.dart';
import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/presentation/home_page/brand_home_page.dart';
import 'package:brandface/presentation/home_page/home_page.dart';
import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:brandface/presentation/registration/ui/registration_page.dart';
import 'package:brandface/utils/services/profile_service.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  final TextEditingController _controller = TextEditingController();
  static const int _otpTimeSeconds = 60;
  Timer? _otpTimer;
  int _remainingSeconds = _otpTimeSeconds;
  bool _isTimeExpired = false;

  void _startOtpTimer() {
    _otpTimer?.cancel();

    setState(() {
      _remainingSeconds = _otpTimeSeconds;
      _isTimeExpired = false;
    });

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        if (_remainingSeconds <= 1) {
          _remainingSeconds = 0;
          _isTimeExpired = true;
          timer.cancel();
        } else {
          _remainingSeconds--;
        }
      });
    });
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    _controller.text = widget.arguments.otpCode;
    super.initState();
    _startOtpTimer();
  }

  @override
  void dispose() {
    _otpTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
          otpVerified: (verifyOtpEntity) {
            if (verifyOtpEntity.isNewUser ?? true) {
              context.go(RegistrationPage.tag);
            } else {
              final role = sl<ProfileService>().getRole();
              if (role == 'brand') {
                context.go(BrandHomePage.tag);
              } else {
                context.go(HomePage.tag);
              }
            }
          },
          otpReceived: (otpEntity) {
            _controller.text = otpEntity.code ?? '';
            _startOtpTimer();
          },
          verifyingOtpFailure: (msg) {},
          otpReceivingFailure: (_) {},
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
              Text(t.login.sms_confirmation, style: Typographies.headlineSmall),
              SizedBox(height: 8),
              Text(
                t.login.sms_sent_to(phoneEnd: widget.arguments.phoneNumber.replaceAll(' ', '').substring(widget.arguments.phoneNumber.length - 4)),
                style: Typographies.bodySmall,
              ),
              SizedBox(height: 24),
              IgnorePointer(
                ignoring: _isTimeExpired,
                child: Pinput(
                  controller: _controller,
                  length: 6,
                  defaultPinTheme: PinTheme(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                    ),
                    width: 64,
                    height: 64,
                  ),
                  focusedPinTheme: PinTheme(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryDark,
                        width: 1,
                      ),
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
              ),
              SizedBox(height: 24),
              _isTimeExpired
                  ? GestureDetector(
                      onTap: () {
                        _controller.clear();
                        context.read<LoginBloc>().add(
                          LoginEvent.sendOtp(
                            phone: widget.arguments.phoneNumber,
                          ),
                        );
                      },
                      child: Text(
                        t.login.send_code_again,
                        style: Typographies.titleSmall,
                      ),
                    )
                  : Text(
                      _formatTime(_remainingSeconds),
                      style: Typographies.bodyMedium.copyWith(
                        color: _isTimeExpired
                            ? AppColors.red
                            : Typographies.bodyMedium.color,
                      ),
                    ),
              Spacer(),
              AppButtons.primary(
                title: t.onboarding.kContinue,
                onTap: () {
                  final bloc = context.read<LoginBloc>();
                  final otp = _controller.text.replaceAll(RegExp(r'\D'), '');
                  bloc.add(
                    LoginEvent.verifyOtp(
                      params: VerifyOtpParams(
                        phone: widget.arguments.phoneNumber,
                        code: otp,
                      ),
                    ),
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
