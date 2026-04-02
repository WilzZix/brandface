import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/components/buttons/buttons.dart';
import '../../../../uikit/components/inputs/email_input_field.dart';
import '../../../../uikit/components/inputs/phone_input_field.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_spoken_language.dart';

class ChooseContactDetail extends StatefulWidget {
  const ChooseContactDetail({
    super.key,
    required this.title,
    required this.label,
    required this.onItemSelected,
  });

  final String title;
  final String label;
  final Function(String) onItemSelected;

  @override
  State<ChooseContactDetail> createState() => _ChooseContactDetailState();
}

class _ChooseContactDetailState extends State<ChooseContactDetail> {
  String? _selectedLang;
  int _selectedLangId = 0;
  InputFieldType _inputFieldType = InputFieldType.phone;
  final TextEditingController _controller = TextEditingController();
  List<LangItemModel> langItems = [
    LangItemModel(name: "Phone", id: 0),
    LangItemModel(name: 'Email', id: 1),
    LangItemModel(name: 'Telegram', id: 2),
    LangItemModel(name: 'Instagram', id: 3),
  ];
  List<String> contactItems = [];

  void _onApply() {
    final value = _controller.text.trim();
    if (value.isNotEmpty) {
      setState(() {
        contactItems.add(value);
        _controller.clear();
      });
    }
  }

  @override
  void initState() {
    _selectedLang = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Typographies.titleSmall),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            await BrandfaceBottomSheet.openBottomSheet<String>(
              context: context,
              builder: (context, bottomState) {
                return Column(
                  children: [
                    ChooseLangItem(
                      title: langItems[0].name,
                      isSelected: langItems[0].id == _selectedLangId,
                      onTap: () {
                        _inputFieldType = InputFieldType.phone;
                        _selectedLang = langItems[0].name;
                        _selectedLangId = langItems[0].id;
                        bottomState(() {});
                      },
                    ),
                    ChooseLangItem(
                      title: langItems[1].name,
                      isSelected: langItems[1].id == _selectedLangId,
                      onTap: () {
                        _inputFieldType = InputFieldType.email;
                        _selectedLang = langItems[1].name;
                        _selectedLangId = langItems[1].id;
                        bottomState(() {});
                      },
                    ),
                    ChooseLangItem(
                      title: langItems[2].name,
                      isSelected: langItems[2].id == _selectedLangId,
                      onTap: () {
                        _inputFieldType = InputFieldType.telegram;
                        _selectedLang = langItems[2].name;
                        _selectedLangId = langItems[2].id;
                        bottomState(() {});
                      },
                    ),
                    ChooseLangItem(
                      title: langItems[3].name,
                      isSelected: langItems[3].id == _selectedLangId,
                      onTap: () {
                        _inputFieldType = InputFieldType.instagram;
                        _selectedLang = langItems[3].name;
                        _selectedLangId = langItems[3].id;
                        bottomState(() {});
                      },
                    ),
                  ],
                );
              },
              header: 'Select contact detail',
              onConfirm: () {
                widget.onItemSelected(_selectedLang ?? '');
                setState(() {});
                context.pop();
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightBg2,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedLang ?? '', style: Typographies.labelLarge),
                SvgPicture.asset(AppAssets.icArrowDown),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ContactInputFieldProvider(
              type: _inputFieldType,
              controller: _controller,
            ),
            SizedBox(width: 8),
            AppButtons.primary(title: 'Apply', onTap: _onApply),
          ],
        ),
        SizedBox(height: 24),
        if (contactItems.isNotEmpty)
          ListView.builder(
            itemCount: contactItems.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(contactItems[index], style: Typographies.bodyMedium),
                  GestureDetector(
                    onTap: () {
                      contactItems.remove(contactItems[index]);
                    },
                    child: Text(
                      'Delete',
                      style: Typographies.labelLarge.copyWith(
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}

class ContactInputFieldProvider extends StatefulWidget {
  const ContactInputFieldProvider({
    super.key,
    required this.type,
    required this.controller,
  });

  final InputFieldType type;
  final TextEditingController controller;

  @override
  State<ContactInputFieldProvider> createState() =>
      _ContactInputFieldProviderState();
}

class _ContactInputFieldProviderState extends State<ContactInputFieldProvider> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.type) {
      InputFieldType.phone => Expanded(
        child: PhoneInputField(controller: widget.controller),
      ),

      InputFieldType.email => Expanded(
        child: EmailInputField(controller: widget.controller),
      ),

      InputFieldType.telegram => Expanded(
        child: CredInputField(
          controller: widget.controller,
          label: 'Telegram user name',
        ),
      ),

      InputFieldType.instagram => Expanded(
        child: CredInputField(
          controller: widget.controller,
          label: 'Instagram account',
        ),
      ),
    };
  }
}

enum InputFieldType { phone, email, telegram, instagram }
