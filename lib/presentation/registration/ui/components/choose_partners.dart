import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_spoken_language.dart';

class ChoosePartners extends StatefulWidget {
  const ChoosePartners({super.key, required this.onItemSelected});

  final Function(LangItemModel) onItemSelected;

  @override
  State<ChoosePartners> createState() => _ChoosePartnersState();
}

class _ChoosePartnersState extends State<ChoosePartners> {
  String? _selectedText;
  int? _selectedId;

  final List<LangItemModel> nicheItems = [
    LangItemModel(name: "Akfa", id: 0),
    LangItemModel(name: 'Open', id: 1),
    LangItemModel(name: 'Alif', id: 2),
    LangItemModel(name: 'Humo', id: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            await BrandfaceBottomSheet.openBottomSheet<String>(
              context: context,
              header: 'Select partners',
              onConfirm: () {
                if (_selectedId != null) {
                  final selectedItem = nicheItems.firstWhere(
                        (item) => item.id == _selectedId,
                  );
                  widget.onItemSelected(selectedItem);
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
                        bottomState(() {});
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
