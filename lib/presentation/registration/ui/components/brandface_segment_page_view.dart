import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_geography.dart';
import 'choose_spoken_language.dart';

class BrandfaceSegmentPageView extends StatefulWidget {
  const BrandfaceSegmentPageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<BrandfaceSegmentPageView> createState() =>
      _BrandfaceSegmentPageViewState();
}

class _BrandfaceSegmentPageViewState extends State<BrandfaceSegmentPageView> {
  final FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final List<LangItemModel> _selectedSegments = [];
  final List<LangItemModel> _selectedGeographies = [];

  final List<LangItemModel> _segments = [
    LangItemModel(name: 'Luxury', id: 0),
    LangItemModel(name: 'Premium', id: 1),
    LangItemModel(name: 'Mass market', id: 2),
    LangItemModel(name: 'Budget', id: 3),
  ];

  void _updateData() {
    widget.onChanged(_param);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Brand segment fit', style: Typographies.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _segments.map((segment) {
              final isSelected =
                  _selectedSegments.any((e) => e.id == segment.id);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedSegments.removeWhere((e) => e.id == segment.id);
                    } else {
                      _selectedSegments.add(segment);
                    }
                  });
                  _updateData();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.black : AppColors.lightBg2,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.black
                          : AppColors.borderColor,
                    ),
                  ),
                  child: Text(
                    segment.name,
                    style: Typographies.labelMedium.copyWith(
                      color:
                          isSelected ? AppColors.lightBg : AppColors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text('Geography', style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseGeography(
            onItemSelected: (LangItemModel item) {
              setState(() {
                if (!_selectedGeographies.any((e) => e.id == item.id)) {
                  _selectedGeographies.add(item);
                  _updateData();
                }
              });
            },
          ),
          if (_selectedGeographies.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Selected geography', style: Typographies.titleSmall),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _selectedGeographies.length,
              itemBuilder: (context, index) {
                final item = _selectedGeographies[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.name, style: Typographies.bodyMedium),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedGeographies.removeAt(index);
                            _updateData();
                          });
                        },
                        child: Text(
                          'Delete',
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
}
