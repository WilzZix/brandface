import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_spoken_language.dart';

class ChooseGender extends StatefulWidget {
  const ChooseGender({
    super.key,
    required this.title,
    required this.label,
    required this.onItemSelected,
  });

  final String title;
  final String label;
  final Function(String) onItemSelected;

  @override
  State<ChooseGender> createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
  String? _selectedLang;
  int _selectedLangId = 0;
  List<LangItemModel> langItems = [
    LangItemModel(name: "Male", id: 0),
    LangItemModel(name: 'Female', id: 1),
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
                      },
                    ),
                    ChooseLangItem(
                      title: langItems[1].name,
                      isSelected: langItems[1].id == _selectedLangId,
                      onTap: () {
                        _selectedLang = langItems[1].name;
                        _selectedLangId = langItems[1].id;
                        bottomState(() {});
                      },
                    ),
                  ],
                );
              },
              header: 'Select gender',
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
      ],
    );
  }
}
