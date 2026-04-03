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
  final Function(List<int>) onItemSelected;

  @override
  State<ChooseSpokenLanguage> createState() => _ChooseSpokenLanguageState();
}

class _ChooseSpokenLanguageState extends State<ChooseSpokenLanguage> {
  String? _selectedLangLabel; // Tanlangan tillar nomini ko'rsatish uchun
  List<int> _selectedLangIds = []; // Tanlangan ID'lar ro'yxati

  List<LangItemModel> langItems = [
    LangItemModel(name: "O'zbek", id: 0),
    LangItemModel(name: 'English', id: 1),
    LangItemModel(name: 'Русский', id: 2),
  ];

  @override
  void initState() {
    _selectedLangLabel = widget.title;
    super.initState();
  }

  // Tanlash mantig'ini alohida funksiyaga chiqaramiz (toza kod uchun)
  void _toggleLanguage(LangItemModel item, StateSetter bottomState) {
    bottomState(() {
      if (_selectedLangIds.contains(item.id)) {
        _selectedLangIds.remove(item.id); // Bor bo'lsa, olib tashlaymiz
      } else {
        _selectedLangIds.add(item.id); // Yo'q bo'lsa, qo'shamiz
      }

      // UI uchun tanlangan tillar nomini birlashtiramiz
      if (_selectedLangIds.isEmpty) {
        _selectedLangLabel = widget.title;
      } else {
        _selectedLangLabel = langItems
            .where((element) => _selectedLangIds.contains(element.id))
            .map((e) => e.name)
            .join(', ');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Typographies.titleSmall),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            await BrandfaceBottomSheet.openBottomSheet<String>(
              context: context,
              header: 'Spoken language',
              onConfirm: () {
                // Tanlangan barcha ID'larni yuboramiz
                widget.onItemSelected(_selectedLangIds);
                setState(() {}); // Asosiy UI'ni yangilash
                context.pop();
              },
              builder: (context, bottomState) {
                return Column(
                  children: langItems.map((item) {
                    return ChooseLangItem(
                      title: item.name,
                      // Ro'yxatda bor bo'lsa, belgilangan (check) bo'ladi
                      isSelected: _selectedLangIds.contains(item.id),
                      onTap: () => _toggleLanguage(item, bottomState),
                    );
                  }).toList(),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightBg2,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tanlangan tillar ro'yxati uzun bo'lsa sig'ishi uchun Expanded
                Expanded(
                  child: Text(
                    _selectedLangLabel ?? '',
                    style: Typographies.labelLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
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
