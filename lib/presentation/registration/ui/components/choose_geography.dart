import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/catalog/region/region_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/error/failures.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_spoken_language.dart';

class ChooseGeography extends StatefulWidget {
  const ChooseGeography({super.key, required this.onItemSelected});

  final Function(LangItemModel) onItemSelected;

  @override
  State<ChooseGeography> createState() => _ChooseGeographyState();
}

class _ChooseGeographyState extends State<ChooseGeography> {
  String? _selectedText;
  int? _selectedId;

  @override
  void initState() {
    _selectedText = t.common.select;
    context.read<RegionCubit>().getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionCubit, RegionState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                state.maybeWhen(
                  regionLoadFailure: (failure) {
                    BrandfaceBottomSheet.openFailureBottomSheet(
                      context: context,
                      message: failure.localized,
                    );
                  },
                  orElse: () async {
                    await BrandfaceBottomSheet.openBottomSheet<String>(
                      context: context,
                      header: t.choose.select_geography,
                      onConfirm: () {
                        context.pop();
                      },
                      builder: (context, bottomState) {
                        return state.maybeWhen(
                          loading: () => const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          orElse: () => const SizedBox.shrink(),
                          regionsLoaded: (region) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: region.map((item) {
                                return ChooseLangItem(
                                  title: item.name,
                                  isSelected: item.id == _selectedId,
                                  onTap: () {
                                    _selectedText = item.name;
                                    _selectedId = item.id;
                                    setState(() {});
                                    widget.onItemSelected(
                                      LangItemModel(
                                        name: item.name,
                                        id: item.id,
                                      ),
                                    );
                                    bottomState(() {});
                                  },
                                );
                              }).toList(),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
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
      },
    );
  }
}
