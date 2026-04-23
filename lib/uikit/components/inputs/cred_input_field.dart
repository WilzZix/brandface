import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../typography/typography.dart';

class CredInputField extends StatefulWidget {
  const CredInputField({
    super.key,
    required this.controller,
    required this.label,
    this.validator, // Required emas, null bo'lishi mumkin
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  // BU YERNI O'ZGARTIRDIK: String qabul qiladigan qildik
  final Function(String)? onChanged;

  @override
  State<CredInputField> createState() => _CredInputFieldState();
}

class _CredInputFieldState extends State<CredInputField> {
  final FocusNode _credFocusNode = FocusNode();

  @override
  void dispose() {
    _credFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      focusNode: _credFocusNode,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        // Qiymatni tashqariga uzatamiz
        widget.onChanged?.call(value);
      },
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Typographies.bodySmall.copyWith(
          color: AppColors.mutedBlack,
        ),
        hintText: widget.label,
        hintStyle: Typographies.bodyLarge.copyWith(color: AppColors.mutedBlack),

        border: _buildBorder(AppColors.borderColor),
        enabledBorder: _buildBorder(AppColors.borderColor),
        focusedBorder: _buildBorder(AppColors.primary),
        errorBorder: _buildBorder(AppColors.red),
        focusedErrorBorder: _buildBorder(AppColors.red),

        // Error xabari chiqsa border qizil bo'lishi uchun padding
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(999),
      borderSide: BorderSide(width: 1, color: color),
    );
  }
}