import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_spoken_language.dart';

class ChooseNiche extends StatefulWidget {
  const ChooseNiche({super.key, required this.onItemSelected});

  // Niche odatda ko'p tanlanishi mumkin (List<int>),
  // lekin hozircha bitta tanlash mantiqida yozamiz
  final Function(LangItemModel) onItemSelected;

  @override
  State<ChooseNiche> createState() => _ChooseNicheState();
}

class _ChooseNicheState extends State<ChooseNiche> {
  String? _selectedText;
  int? _selectedId;

  // Modelni shu yerning o'zida yoki alohida faylda e'lon qiling
  final List<LangItemModel> nicheItems = [
    LangItemModel(name: "Business", id: 0),
    LangItemModel(name: 'Fashion', id: 1),
    LangItemModel(name: 'Finance', id: 2),
    LangItemModel(name: 'Marketing', id: 3),
    LangItemModel(name: 'Movies', id: 4),
    LangItemModel(name: 'Rap', id: 5),
  ];

  @override
  void initState() {
    _selectedText = 'Select niche';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            await BrandfaceBottomSheet.openBottomSheet<String>(
              context: context,
              header: 'Select niche',
              onConfirm: () {
                if (_selectedId != null) {
                  // Tanlangan obyektni topamiz
                  final selectedItem = nicheItems.firstWhere(
                    (item) => item.id == _selectedId,
                  );

                  // Ota-onaga yuboramiz
                  widget.onItemSelected(selectedItem);

                  // UI ni yangilaymiz
                  setState(() {
                    _selectedText = selectedItem.name;
                  });
                }
                context.pop();
              },
              builder: (context, bottomState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: nicheItems.map((item) {
                    return ChooseLangItem(
                      title: item.name,
                      isSelected: item.id == _selectedId,
                      onTap: () {
                        _selectedText = item.name;
                        _selectedId = item.id;
                        bottomState(
                          () {},
                        ); // Faqat bottomSheet UI'ni yangilaydi
                      },
                    );
                  }).toList(),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.lightBg2,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedText ?? 'Select',
                  style: Typographies.labelLarge.copyWith(
                    color: _selectedId == null
                        ? AppColors.grey
                        : AppColors.black,
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
