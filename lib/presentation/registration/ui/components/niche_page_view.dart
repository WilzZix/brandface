import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_niche.dart';
import 'choose_spoken_language.dart';

class NichePageView extends StatefulWidget {
  const NichePageView({
    super.key,
    required this.onChanged,
    this.initialCategoryIds,
  });

  final Function(FillInfluencerProfileParam) onChanged;
  final List<int>? initialCategoryIds;

  @override
  State<NichePageView> createState() => _NichePageViewState();
}

class _NichePageViewState extends State<NichePageView>
    with AutomaticKeepAliveClientMixin<NichePageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final List<LangItemModel> _selectedNichesItems = [];
  final bool _prefilledFromInitial = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.registration.niches, style: Typographies.titleMedium),
          const SizedBox(height: 24),
          SizedBox(
            height: 24,
            child: ListView.separated(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen,

                    border: Border.all(color: AppColors.primaryDark, width: 1),

                    borderRadius: BorderRadius.circular(999),
                  ),

                  child: Text('Business', style: Typographies.labelMedium),
                );
              },

              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 8);
              },
            ),
          ),
          SizedBox(height: 16),
          ChooseNiche(
            onItemSelected: (LangItemModel item) {
              setState(() {
                if (!_selectedNichesItems.any((e) => e.id == item.id)) {
                  _selectedNichesItems.add(item);
                  _updateData();
                }
              });
            },
          ),
          const SizedBox(height: 32),
          if (_selectedNichesItems.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.registration.selected_niches,
                  style: Typographies.titleSmall,
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _selectedNichesItems.length,

                  itemBuilder: (context, index) {
                    final niche = _selectedNichesItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(niche.name, style: Typographies.bodyMedium),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedNichesItems.removeAt(index);
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
            ),
        ],
      ),
    );
  }

  void _updateData() {
    _param = _param.copyWith(
      categoryIds: _selectedNichesItems.map((e) => e.id).toList(),
    );
    widget.onChanged(_param);
  }

  @override
  bool get wantKeepAlive => true;
}
