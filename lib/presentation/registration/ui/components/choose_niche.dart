import 'package:brandface/core/error/failures.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_spoken_language.dart';

class ChooseNiche extends StatefulWidget {
  const ChooseNiche({super.key, required this.onItemSelected});

  final Function(LangItemModel) onItemSelected;

  @override
  State<ChooseNiche> createState() => _ChooseNicheState();
}

class _ChooseNicheState extends State<ChooseNiche> {
  String? _selectedText;
  int? _selectedId;

  @override
  void initState() {
    _selectedText = 'Select niche';
    // Ma'lumotni yuklash
    context.read<CategoryCubit>().getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // BlocBuilder orqali holatni kuzatamiz
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                // BottomSheet ochish
                await BrandfaceBottomSheet.openBottomSheet(
                  context: context,
                  header: 'Select niche',
                  onConfirm: () {
                    context.pop();
                  },
                  builder: (context, bottomState) {
                    // BU YERDA RETURN BO'LISHI SHART
                    return state.maybeWhen(
                      loading: () => const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      categoryLoaded: (categories) {
                        // Serverdan kelgan ma'lumotlarni map qilamiz
                        // Agar LangItemModel va Category har xil bo'lsa, konvertatsiya qiling
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: categories.map((item) {
                            return ChooseLangItem(
                              title: item.nameUz,
                              // Category modelida name bor deb hisoblaymiz
                              isSelected: item.id == _selectedId,
                              onTap: () {
                                // 1. Lokal o'zgaruvchilarni yangilaymiz
                                setState(() {
                                  _selectedId = item.id;
                                  _selectedText = item.nameUz;
                                });

                                // 2. Ota-onaga tanlangan obyektni yuboramiz
                                widget.onItemSelected(
                                  LangItemModel(name: item.nameUz, id: item.id),
                                );

                                // 3. BottomSheet ichidagi UI'ni yangilaymiz (check belgisini ko'rsatish uchun)
                                bottomState(() {});
                              },
                            );
                          }).toList(),
                        );
                      },
                      categoryLoadFailure: (failure) =>
                          Center(child: Text(failure.localized)),
                      orElse: () => const SizedBox.shrink(),
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
      },
    );
  }
}
