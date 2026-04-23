import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/i18n/strings.g.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_spoken_language.dart';

class ChooseSocialMediaPlatform extends StatefulWidget {
  const ChooseSocialMediaPlatform({super.key, required this.onItemSelected});

  final Function(String) onItemSelected;

  @override
  State<ChooseSocialMediaPlatform> createState() =>
      _ChooseSocialMediaPlatformState();
}

class _ChooseSocialMediaPlatformState extends State<ChooseSocialMediaPlatform> {
  String? _selectedText;
  String? _selectedId;

  final List<String> platformItems = ['youtube', 'instagram', 'telegram'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            await BrandfaceBottomSheet.openBottomSheet<String>(
              context: context,
              header: 'Choose platform',
              onConfirm: () {
                if (_selectedId != null) {
                  final selectedItem = platformItems.firstWhere(
                    (item) => item == _selectedId,
                  );
                  widget.onItemSelected(selectedItem);
                  setState(() {
                    _selectedText = selectedItem;
                  });
                }
                context.pop();
              },
              builder: (context, bottomState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: platformItems.map((item) {
                    return ChooseLangItem(
                      title: item,
                      isSelected: item == _selectedText,
                      onTap: () {
                        _selectedText = item;
                        _selectedId = item;
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
