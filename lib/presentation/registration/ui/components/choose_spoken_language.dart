import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';

class ChooseSpokenLanguage extends StatefulWidget {
  const ChooseSpokenLanguage({super.key, required this.title, required this.label, required this.onItemSelected});

  final String title;
  final String label;
  final Function(String) onItemSelected;

  @override
  State<ChooseSpokenLanguage> createState() => _ChooseSpokenLanguageState();
}

class _ChooseSpokenLanguageState extends State<ChooseSpokenLanguage> {
  String? _selectedLang;

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
          onTap: () {
            /// bottomsheetdan tanlangan stringni callBack qilish
            widget.onItemSelected(_selectedLang ?? '');
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.lightBg2, borderRadius: BorderRadius.circular(999)),
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
