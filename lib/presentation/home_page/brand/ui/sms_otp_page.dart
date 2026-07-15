import 'dart:async';

import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SmsOtpPage extends StatefulWidget {
  const SmsOtpPage({super.key, required this.args});

  static const String tag = '/sms-otp';

  final SmsOtpArgs args;

  @override
  State<SmsOtpPage> createState() => _SmsOtpPageState();
}

class _SmsOtpPageState extends State<SmsOtpPage> {
  static const _otpLength = 6;
  static const _totalSeconds = 59;

  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  int _secondsLeft = _totalSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
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
    setState(() => _secondsLeft = _totalSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _onChanged(String value) {
    // Enforce digits only + max length
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits != value) {
      _controller.value = TextEditingValue(
        text: digits,
        selection: TextSelection.collapsed(offset: digits.length),
      );
      return;
    }
    setState(() {});
    if (digits.length == _otpLength) {
      _onContinue();
    }
  }

  void _onContinue() {
    final digits = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length < _otpLength) return;
    widget.args.onSuccess();
    if (context.canPop()) context.pop();
  }

  String get _digits =>
      _controller.text.replaceAll(RegExp(r'[^0-9]'), '');

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final isFilled = _digits.length == _otpLength;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_focusNode),
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.lightBg,
          scrolledUnderElevation: 0,
          title: const SizedBox.shrink(),
        ),
        body: Column(
          children: [
            const Spacer(),

            // ── Title + subtitle ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Text(
                    t.login.sms_confirmation,
                    style: Typographies.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.login.sms_sent_to(phoneEnd: '8877'),
                    style: Typographies.bodyMedium
                        .copyWith(color: AppColors.mutedBlack),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ── OTP circles ───────────────────────────────────────────────
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
                    color:
                        filled ? AppColors.primary : AppColors.lightBg3,
                    border: Border.all(
                      color: filled
                          ? AppColors.primary
                          : AppColors.borderColor,
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

            // ── Hidden TextField (drives system keyboard) ─────────────────
            SizedBox(
              height: 1,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                maxLength: _otpLength,
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

            // ── Timer / Resend ────────────────────────────────────────────
            GestureDetector(
              onTap: _secondsLeft == 0 ? _startTimer : null,
              child: Text(
                _secondsLeft > 0
                    ? '00:${_secondsLeft.toString().padLeft(2, '0')}'
                    : t.login.send_code_again,
                style: Typographies.bodyMedium.copyWith(
                  color: _secondsLeft > 0
                      ? AppColors.mutedBlack
                      : AppColors.primary,
                ),
              ),
            ),

            const Spacer(),

            // ── Continue button ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: _onContinue,
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isFilled
                        ? AppColors.primary
                        : AppColors.borderColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    t.common.continue_label,
                    style: Typographies.labelLarge,
                  ),
                ),
              ),
            ),

            SizedBox(height: bottom > 0 ? 8 : 24),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Args passed to this page
// ─────────────────────────────────────────────────────────────────────────────

class SmsOtpArgs {
  final VoidCallback onSuccess;
  const SmsOtpArgs({required this.onSuccess});
}
