import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/profile/catalog/brand_short_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
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

  List<LangItemModel> _brandItems = const [];
  bool _loading = false;
  bool _loaded = false;

  Future<void> _ensureBrandsLoaded() async {
    if (_loaded || _loading) return;
    _loading = true;
    final result = await sl<IProfileRepository>().getBrands();
    result.fold(
      ifLeft: (_) {
        _brandItems = const [];
      },
      ifRight: (brands) {
        _brandItems = brands
            .map((BrandShortEntity b) =>
                LangItemModel(name: b.brandName, id: b.id))
            .toList();
      },
    );
    _loading = false;
    _loaded = true;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            await _ensureBrandsLoaded();
            if (!context.mounted) return;
            await BrandfaceBottomSheet.openBottomSheet<String>(
              context: context,
              header: t.choose.select_partners,
              onConfirm: () {
                if (_selectedId != null) {
                  final selectedItem = _brandItems.firstWhere(
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
                if (_brandItems.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _brandItems.map((item) {
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
