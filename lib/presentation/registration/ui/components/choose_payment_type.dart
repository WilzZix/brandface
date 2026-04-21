import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/i18n/strings.g.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_spoken_language.dart';

class ChoosePaymentType extends StatefulWidget {
  const ChoosePaymentType({super.key, required this.onItemSelected});

  final Function(LangItemModel) onItemSelected;

  @override
  State<ChoosePaymentType> createState() => _ChoosePaymentTypeState();
}

class _ChoosePaymentTypeState extends State<ChoosePaymentType> {
  String? _selectedText;
  int? _selectedId;

  final List<LangItemModel> currencyItems = [
    LangItemModel(name: "Cash", id: 0),
    LangItemModel(name: 'Bank transfer', id: 1),
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
              header: 'Select payment type',
              onConfirm: () {
                if (_selectedId != null) {
                  final selectedItem = currencyItems.firstWhere(
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
                  children: currencyItems.map((item) {
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
                  _selectedText ?? t.common.select,
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
