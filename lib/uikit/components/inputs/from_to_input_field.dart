import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../typography/typography.dart';

class FromToInputField extends StatefulWidget {
  const FromToInputField({
    super.key,
    required this.controllerFrom,
    required this.controllerTo,
    required this.labelFrom,
    required this.labelTo,
    required this.title,
    this.onChanged,
  });

  final TextEditingController controllerFrom;
  final TextEditingController controllerTo;
  final String title;
  final String labelFrom;
  final String labelTo;
  final VoidCallback? onChanged;

  @override
  State<FromToInputField> createState() => _FromToInputFieldState();
}

class _FromToInputFieldState extends State<FromToInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Typographies.titleMedium),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  widget.onChanged?.call();
                },
                controller: widget.controllerFrom,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: widget.labelFrom,
                  labelStyle: Typographies.bodySmall.copyWith(
                    color: AppColors.mutedBlack,
                  ),
                  hintText: widget.labelFrom,
                  hintStyle: Typographies.bodyLarge.copyWith(
                    color: AppColors.mutedBlack,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.borderColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.borderColor,
                    ),
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
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  widget.onChanged?.call();
                },
                controller: widget.controllerTo,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: widget.labelTo,
                  labelStyle: Typographies.bodySmall.copyWith(
                    color: AppColors.mutedBlack,
                  ),
                  hintText: widget.labelTo,
                  hintStyle: Typographies.bodyLarge.copyWith(
                    color: AppColors.mutedBlack,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.borderColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.borderColor,
                    ),
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}
