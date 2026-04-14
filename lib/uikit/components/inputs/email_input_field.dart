import 'package:brandface/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../typography/typography.dart';

class EmailInputField extends StatefulWidget {
  const EmailInputField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<EmailInputField> createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  TextEditingController get _controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        labelText: t.common.email,
        labelStyle: Typographies.bodySmall.copyWith(
          color: AppColors.mutedBlack,
        ),
        hintText: t.common.email,
        hintStyle: Typographies.bodyLarge.copyWith(color: AppColors.mutedBlack),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(width: 1, color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(width: 1, color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(width: 1, color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(width: 1, color: AppColors.red),
        ),
      ),
    );
  }
}
