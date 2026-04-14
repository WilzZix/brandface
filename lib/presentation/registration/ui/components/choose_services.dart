import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/catalog/service_type/service_type_cubit.dart';
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

class ChooseServices extends StatefulWidget {
  const ChooseServices({super.key, required this.onItemSelected});

  final Function(LangItemModel) onItemSelected;

  @override
  State<ChooseServices> createState() => _ChooseServicesState();
}

class _ChooseServicesState extends State<ChooseServices> {
  String? _selectedText;
  int? _selectedId;

  @override
  void initState() {
    _selectedText = t.choose.select_niche;
    context.read<ServiceTypeCubit>().getServiceType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceTypeCubit, ServiceTypeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                state.maybeWhen(
                  serviceTypeLoadedLoadFailure: (failure) {
                    BrandfaceBottomSheet.openFailureBottomSheet(
                      context: context,
                      message: failure.localized,
                    );
                  },
                  orElse: () async {
                    await BrandfaceBottomSheet.openBottomSheet<String>(
                      context: context,
                      header: t.choose.select_service,
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
                          serviceTypeLoaded: (serviceTypes) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: serviceTypes.map((item) {
                                return ChooseLangItem(
                                  title: item.name,
                                  isSelected: item.id == _selectedId,
                                  onTap: () {
                                    setState(() {
                                      _selectedId = item.id;
                                      _selectedText = item.name;
                                    });
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
