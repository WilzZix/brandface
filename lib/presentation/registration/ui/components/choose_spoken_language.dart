import 'package:brandface/core/error/failures.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/profile/catalog/language_entity.dart';
import 'package:brandface/presentation/registration/bloc/catalog/language/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    this.initialValue,
  });

  final String title;
  final String label;
  final List<int>? initialValue;
  final Function(List<int>) onItemSelected;

  @override
  State<ChooseSpokenLanguage> createState() => _ChooseSpokenLanguageState();
}

class _ChooseSpokenLanguageState extends State<ChooseSpokenLanguage> {
  final List<int> _selectedLangIds = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _selectedLangIds.addAll(widget.initialValue!);
    }
    context.read<LanguageCubit>().getLanguages();
  }

  String _getSelectedLabel(List<LanguageEntity> allLanguages) {
    if (_selectedLangIds.isEmpty) return widget.title;

    return allLanguages
        .where((lang) => _selectedLangIds.contains(lang.id))
        .map((lang) => lang.name)
        .join(', ');
  }

  void _toggleLanguage(int id, StateSetter bottomState) {
    bottomState(() {
      if (_selectedLangIds.contains(id)) {
        _selectedLangIds.remove(id);
      } else {
        _selectedLangIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final List<LanguageEntity> languages = state.maybeWhen(
          loaded: (langs) => langs,
          orElse: () => [],
        );

        final bool isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label, style: Typographies.titleSmall),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: isLoading
                  ? null
                  : () async {
                      await BrandfaceBottomSheet.openBottomSheet<void>(
                        context: context,
                        header: t.choose.spoken_language,
                        onConfirm: () {
                          widget.onItemSelected(_selectedLangIds);
                          setState(() {});
                          context.pop();
                        },
                        builder: (context, bottomState) {
                          return state.when(
                            initial: () => const SizedBox.shrink(),
                            loading: () => const Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            loadFailure: (failure) => Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(failure.localized),
                              ),
                            ),
                            loaded: (langs) {
                              if (langs.isEmpty) {
                                return const Center(
                                  child: Text("Tillar topilmadi"),
                                );
                              }
                              return SingleChildScrollView(
                                child: Column(
                                  children: langs.map((item) {
                                    return ChooseLangItem(
                                      title: item.name,
                                      isSelected: _selectedLangIds.contains(
                                        item.id,
                                      ),
                                      onTap: () =>
                                          _toggleLanguage(item.id, bottomState),
                                    );
                                  }).toList(),
                                ),
                              );
                            },
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
                    Expanded(
                      child: Text(
                        isLoading
                            ? 'Yuklanmoqda...'
                            : _getSelectedLabel(languages),
                        style: Typographies.labelLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isLoading)
                      const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
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

class ChooseLangItem extends StatelessWidget {
  const ChooseLangItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Typographies.labelLarge),
              if (isSelected) SvgPicture.asset(AppAssets.icCheck),
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
