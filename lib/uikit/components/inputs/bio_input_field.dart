import 'package:brandface/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../typography/typography.dart';

class BioInputField extends StatefulWidget {
  const BioInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final VoidCallback onChanged;

  @override
  State<BioInputField> createState() => _BioInputFieldState();
}

class _BioInputFieldState extends State<BioInputField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Typographies.titleSmall),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          maxLines: 4,
          onChanged: (value) {
            widget.onChanged();
          },
          decoration: InputDecoration(
            hintText: t.common.write_text_here,
            hintStyle: Typographies.bodyMedium.copyWith(color: AppColors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
