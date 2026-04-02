import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';

class ChooseSpokenLanguage extends StatefulWidget {
  const ChooseSpokenLanguage({
    super.key,
    required this.title,
    required this.label,
    required this.onItemSelected,
  });

  final String title;
  final String label;
  final Function(String) onItemSelected;

  @override
  State<ChooseSpokenLanguage> createState() => _ChooseSpokenLanguageState();
}

class _ChooseSpokenLanguageState extends State<ChooseSpokenLanguage> {
  String? _selectedLang;
  int _selectedLangId = 0;
  List<LangItemModel> langItems = [
    LangItemModel(name: "O'zbek", id: 0),
    LangItemModel(name: 'English', id: 1),
    LangItemModel(name: 'Русский', id: 2),
  ];

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
                        _selectedLang = langItems[0].name;
                        _selectedLangId = langItems[0].id;
                        bottomState(() {});
                        setState(() {});
                      },
                    ),
                    ChooseLangItem(
                      title: langItems[1].name,
                      isSelected: langItems[1].id == _selectedLangId,
                      onTap: () {
                        _selectedLang = langItems[1].name;
                        _selectedLangId = langItems[1].id;
                        bottomState(() {});
                        setState(() {});
                      },
                    ),
                    ChooseLangItem(
                      title: langItems[2].name,
                      isSelected: langItems[2].id == _selectedLangId,
                      onTap: () {
                        _selectedLang = langItems[2].name;
                        _selectedLangId = langItems[2].id;
                        bottomState(() {});
                        setState(() {});
                      },
                    ),
                  ],
                );
              },
              header: 'Spoken language',
              onConfirm: () {
                widget.onItemSelected(_selectedLang ?? '');
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
      ],
    );
  }
}

class ChooseLangItem extends StatefulWidget {
  const ChooseLangItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final Function() onTap;

  @override
  State<ChooseLangItem> createState() => _ChooseLangItemState();
}

class _ChooseLangItemState extends State<ChooseLangItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: Typographies.labelLarge),
              if (widget.isSelected) SvgPicture.asset(AppAssets.icCheck),
            ],
          ),
        ),
      ),
    );
  }
}

class LangItemModel {
  final String name;
  final int id;

  LangItemModel({required this.name, required this.id});
}
