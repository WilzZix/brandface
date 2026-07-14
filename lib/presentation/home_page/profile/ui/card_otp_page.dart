import 'dart:async';

import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/presentation/home_page/profile/bloc/my_cards/cards_cubit.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Arguments for the dedicated card-confirmation OTP screen.
class CardOtpArgs {
  /// Original card details — reused when the user requests a resend.
  final InitBillingCardParams params;
  final bool isDefault;

  const CardOtpArgs({required this.params, this.isDefault = false});
}

/// Confirms the OTP for the two-step Paylov card registration. Shares the
/// [CardsCubit] instance of the screen that started the add flow (provide it
/// with `BlocProvider.value` when pushing this page). Pops `true` once the card
/// is saved.
class CardOtpPage extends StatefulWidget {
  const CardOtpPage({super.key, required this.args});

  final CardOtpArgs args;

  @override
  State<CardOtpPage> createState() => _CardOtpPageState();
}

class _CardOtpPageState extends State<CardOtpPage> {
  static const _otpLength = 6;
  static const _resendSeconds = 59;

  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _timer;
  int _secondsLeft = _resendSeconds;

  // The page opens right after step 1, so the flow starts on `otpSent`.
  AddCardStage _lastStage = AddCardStage.otpSent;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = _resendSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  String get _digits => _controller.text.replaceAll(RegExp(r'[^0-9]'), '');

  void _onChanged(String value) {
    setState(() {});
    if (_digits.length == _otpLength) _submit();
  }

  void _submit() {
    if (_digits.length < _otpLength) return;
    FocusScope.of(context).unfocus();
    context.read<CardsCubit>().confirmOtp(
      otp: _digits,
      isDefault: widget.args.isDefault,
    );
  }

  void _resend() {
    _controller.clear();
    setState(() {});
    _startTimer();
    context.read<CardsCubit>().resendOtp(widget.args.params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardsCubit, CardsState>(
      listenWhen: (prev, curr) => prev.addStage != curr.addStage,
      listener: (context, state) {
        final wasConfirming = _lastStage == AddCardStage.confirming;
        _lastStage = state.addStage;

        // Success: confirming → idle with no failure means the card was saved.
        if (wasConfirming &&
            state.addStage == AddCardStage.idle &&
            state.addFailure == null) {
          context.showAppSnackBar('Card added', type: AppSnackBarType.success);
          Navigator.of(context).pop(true);
          return;
        }
        // Failure: a confirm or resend attempt landed back on otpSent with an
        // error.
        if (state.addStage == AddCardStage.otpSent &&
            state.addFailure != null) {
          context.showAppSnackBar(
            state.addFailure!.message,
            type: AppSnackBarType.error,
          );
          _controller.clear();
          setState(() {});
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_focusNode),
        child: Scaffold(
          backgroundColor: AppColors.lightBg,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: AppColors.lightBg,
            scrolledUnderElevation: 0,
          ),
          body: BlocBuilder<CardsCubit, CardsState>(
            builder: (context, state) {
              final busy = state.addStage == AddCardStage.confirming ||
                  state.addStage == AddCardStage.initializing;
              final phone = state.otpSentPhone;
              return Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        Text(
                          'SMS confirmation',
                          style: Typographies.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          phone == null || phone.isEmpty
                              ? 'Enter the SMS code sent to your card\'s phone number'
                              : 'We sent an SMS code to $phone,\nplease enter it below',
                          style: Typographies.bodyMedium.copyWith(
                            color: AppColors.mutedBlack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_otpLength, (i) {
                      final digit = i < _digits.length ? _digits[i] : null;
                      final filled = digit != null;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filled ? AppColors.primary : AppColors.lightBg3,
                          border: Border.all(
                            color:
                                filled ? AppColors.primary : AppColors.borderColor,
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: filled
                            ? Text(digit, style: Typographies.titleSmall)
                            : null,
                      );
                    }),
                  ),
                  SizedBox(
                    height: 1,
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      maxLength: _otpLength,
                      enabled: !busy,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: _onChanged,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        height: 0.001,
                        fontSize: 1,
                        color: Colors.transparent,
                      ),
                      cursorColor: Colors.transparent,
                      cursorWidth: 0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _secondsLeft == 0 && !busy ? _resend : null,
                    child: Text(
                      _secondsLeft > 0
                          ? '00:${_secondsLeft.toString().padLeft(2, '0')}'
                          : 'Resend code',
                      style: Typographies.bodyMedium.copyWith(
                        color: _secondsLeft > 0
                            ? AppColors.mutedBlack
                            : AppColors.primary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: busy ? null : _submit,
                      child: Container(
                        height: 52,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _digits.length == _otpLength && !busy
                              ? AppColors.primary
                              : AppColors.borderColor,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        alignment: Alignment.center,
                        child: busy
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.black,
                                ),
                              )
                            : Text('Continue', style: Typographies.labelLarge),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom > 0
                        ? 8
                        : 24,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
