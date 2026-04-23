import 'package:brandface/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_brand_profile_param.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_niche.dart';
import 'choose_spoken_language.dart';

class BrandCategoriesPageView extends StatefulWidget {
  const BrandCategoriesPageView({super.key, required this.onChanged});

  final Function(FillBrandProfileParam) onChanged;

  @override
  State<BrandCategoriesPageView> createState() =>
      _BrandCategoriesPageViewState();
}

class _BrandCategoriesPageViewState extends State<BrandCategoriesPageView>
    with AutomaticKeepAliveClientMixin<BrandCategoriesPageView> {
  FillBrandProfileParam _param = FillBrandProfileParam();
  final List<LangItemModel> _selectedCategories = [];

  void _updateData() {
    _param = _param.copyWith(
      categoryIds: _selectedCategories.map((e) => e.id).toList(),
    );
    widget.onChanged(_param);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.registration.categories, style: Typographies.titleMedium),
          const SizedBox(height: 24),
          ChooseNiche(
            onItemSelected: (LangItemModel item) {
              setState(() {
                if (!_selectedCategories.any((e) => e.id == item.id)) {
                  _selectedCategories.add(item);
                  _updateData();
                }
              });
            },
          ),
          if (_selectedCategories.isNotEmpty) ...[
            const SizedBox(height: 32),
            Text(t.registration.selected_categories, style: Typographies.titleSmall),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _selectedCategories.length,
              itemBuilder: (context, index) {
                final item = _selectedCategories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.name, style: Typographies.bodyMedium),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategories.removeAt(index);
                            _updateData();
                          });
                        },
                        child: Text(
                          t.common.delete,
                          style: Typographies.labelLarge.copyWith(
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
