import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/i18n/strings.g.dart';

class PhoneInputField extends StatefulWidget {
  const PhoneInputField({super.key});

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  final maskFormatter = MaskTextInputFormatter(mask: '## ### ## ##', filter: {"#": RegExp(r'[0-9]')});
  final FocusNode _phoneFocusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _phoneFocusNode.addListener(() {
      setState(() {
        _isFocused = _phoneFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showPrefix = _isFocused || _controller.text.isNotEmpty;
    return TextField(
      controller: _controller,
      focusNode: _phoneFocusNode,
      inputFormatters: [maskFormatter],
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        prefixIcon: showPrefix
            ? Container(
                padding: const EdgeInsets.only(left: 24, top: 14, bottom: 14),
                child: Text('+998', style: Typographies.bodyLarge),
              )
            : null,
        labelText: t.login.phone_number,
        labelStyle: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
        hintText: t.login.phone_number,
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
