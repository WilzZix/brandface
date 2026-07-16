import 'package:brandface/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../typography/typography.dart';

/// Email input with a domain-suggestion dropdown. As the user types, common
/// domains are offered as full-email options (`user@gmail.com`, …); the list
/// filters down once an `@` and part of a domain are typed, and disappears once
/// a complete known domain is entered.
class EmailInputField extends StatefulWidget {
  const EmailInputField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<EmailInputField> createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  final FocusNode _focusNode = FocusNode();

  /// Common domains, ordered by expected local popularity.
  static const List<String> _domains = [
    'gmail.com',
    'mail.ru',
    'icloud.com',
    'yandex.ru',
    'outlook.com',
    'hotmail.com',
  ];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Iterable<String> _emailOptions(TextEditingValue value) {
    final text = value.text.trim();
    if (text.isEmpty) return const [];

    final atIndex = text.indexOf('@');
    final local = atIndex == -1 ? text : text.substring(0, atIndex);
    if (local.isEmpty) return const [];

    // A second '@' means it's no longer a plain local@domain shape.
    if (text.indexOf('@', atIndex + 1) != -1) return const [];

    final domainPart = atIndex == -1
        ? ''
        : text.substring(atIndex + 1).toLowerCase();

    return _domains
        .where((d) => d.startsWith(domainPart))
        .map((d) => '$local@$d')
        // Hide the option that already equals what's typed (domain complete).
        .where((suggestion) => suggestion != text);
  }

  InputDecoration _decoration() {
    return InputDecoration(
      labelText: t.common.email,
      labelStyle: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dropdownWidth =
            constraints.maxWidth.isFinite ? constraints.maxWidth : 360.0;
        return RawAutocomplete<String>(
          textEditingController: widget.controller,
          focusNode: _focusNode,
          optionsBuilder: _emailOptions,
          fieldViewBuilder:
              (context, controller, focusNode, onFieldSubmitted) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  onSubmitted: (_) => onFieldSubmitted(),
                  decoration: _decoration(),
                );
              },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 220,
                    maxWidth: dropdownWidth,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options.elementAt(index);
                      return InkWell(
                        onTap: () => onSelected(option),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Text(
                            option,
                            style: Typographies.bodyMedium,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
