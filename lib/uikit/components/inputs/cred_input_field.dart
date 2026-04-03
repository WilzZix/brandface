import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../typography/typography.dart';

class CredInputField extends StatefulWidget {
  const CredInputField({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  State<CredInputField> createState() => _CredInputFieldState();
}

class _CredInputFieldState extends State<CredInputField> {
  final FocusNode _credFocusNode = FocusNode();

  TextEditingController get _controller => widget.controller;

  @override
  void dispose() {
    _credFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _credFocusNode,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Typographies.bodySmall.copyWith(
          color: AppColors.mutedBlack,
        ),
        hintText: widget.label,
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
