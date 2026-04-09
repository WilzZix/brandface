import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/ui/components/profile_avatar_item.dart';
import 'package:brandface/uikit/components/inputs/bio_input_field.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import 'choose_spoken_language.dart';

class BrandInfoPageView extends StatefulWidget {
  const BrandInfoPageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<BrandInfoPageView> createState() => _BrandInfoPageViewState();
}

class _BrandInfoPageViewState extends State<BrandInfoPageView>
    with AutomaticKeepAliveClientMixin<BrandInfoPageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final TextEditingController _bioController = TextEditingController();

  final List<LangItemModel> _regions = [
    LangItemModel(name: 'Tashkent', id: 0),
    LangItemModel(name: 'Samarkand', id: 1),
    LangItemModel(name: 'Bukhara', id: 2),
    LangItemModel(name: 'Fergana', id: 3),
  ];

  final List<LangItemModel> _cities = [
    LangItemModel(name: 'Tashkent city', id: 0),
    LangItemModel(name: 'Samarkand city', id: 1),
    LangItemModel(name: 'Bukhara city', id: 2),
    LangItemModel(name: 'Fergana city', id: 3),
  ];

  final List<LangItemModel> _spheres = [
    LangItemModel(name: 'Technology', id: 0),
    LangItemModel(name: 'Fashion', id: 1),
    LangItemModel(name: 'Food & Beverage', id: 2),
    LangItemModel(name: 'Beauty', id: 3),
    LangItemModel(name: 'Sports', id: 4),
    LangItemModel(name: 'Finance', id: 5),
  ];

  int? _selectedRegionId;
  String? _selectedRegionName;
  int? _selectedCityId;
  String? _selectedCityName;
  int? _selectedSphereId;
  String? _selectedSphereName;

  void _updateData() {
    _param = _param.copyWith(
      regionId: _selectedRegionId,
      cityId: _selectedCityId,
      bio: _bioController.text,
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
          Text(t.registration.upload_profile_picture, style: Typographies.titleMedium),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                height: 96,
                width: 96,
                child: Image.asset(
                  'assets/images/im_person_avatar_sample.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(999),
                      color: AppColors.primary,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssets.icAttachFile),
                        const SizedBox(width: 8),
                        Text(t.registration.choose_file, style: Typographies.bodyMedium),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.registration.file_format_hint,
                    style: Typographies.bodySmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          ProfileAvatarItem(
            onTap: (int id) {
              _param = _param.copyWith(avatarId: id);
              widget.onChanged(_param);
            },
            items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
          ),
          const SizedBox(height: 40),
          Text(t.registration.region, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          _DropdownField(
            selectedText: _selectedRegionName ?? t.choose.select_region,
            isSelected: _selectedRegionId != null,
            onTap: () async {
              await BrandfaceBottomSheet.openBottomSheet<String>(
                context: context,
                header: t.choose.select_region,
                onConfirm: () {
                  _updateData();
                  context.pop();
                },
                builder: (context, bottomState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _regions.map((item) {
                      return ChooseLangItem(
                        title: item.name,
                        isSelected: item.id == _selectedRegionId,
                        onTap: () {
                          setState(() {
                            _selectedRegionId = item.id;
                            _selectedRegionName = item.name;
                          });
                          bottomState(() {});
                        },
                      );
                    }).toList(),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),
          Text(t.registration.city, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          _DropdownField(
            selectedText: _selectedCityName ?? t.choose.select_city,
            isSelected: _selectedCityId != null,
            onTap: () async {
              await BrandfaceBottomSheet.openBottomSheet<String>(
                context: context,
                header: t.choose.select_city,
                onConfirm: () {
                  _updateData();
                  context.pop();
                },
                builder: (context, bottomState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _cities.map((item) {
                      return ChooseLangItem(
                        title: item.name,
                        isSelected: item.id == _selectedCityId,
                        onTap: () {
                          setState(() {
                            _selectedCityId = item.id;
                            _selectedCityName = item.name;
                          });
                          bottomState(() {});
                        },
                      );
                    }).toList(),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),
          Text(t.registration.sphere, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          _DropdownField(
            selectedText: _selectedSphereName ?? t.choose.select_sphere,
            isSelected: _selectedSphereId != null,
            onTap: () async {
              await BrandfaceBottomSheet.openBottomSheet<String>(
                context: context,
                header: t.choose.select_sphere,
                onConfirm: () {
                  _updateData();
                  context.pop();
                },
                builder: (context, bottomState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _spheres.map((item) {
                      return ChooseLangItem(
                        title: item.name,
                        isSelected: item.id == _selectedSphereId,
                        onTap: () {
                          setState(() {
                            _selectedSphereId = item.id;
                            _selectedSphereName = item.name;
                          });
                          bottomState(() {});
                        },
                      );
                    }).toList(),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 24),
          BioInputField(
            controller: _bioController,
            label: t.registration.profile_information,
            onChanged: () {
              _updateData();
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.selectedText,
    required this.isSelected,
    required this.onTap,
  });

  final String selectedText;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              selectedText,
              style: Typographies.labelLarge.copyWith(
                color: isSelected ? AppColors.black : AppColors.grey,
              ),
            ),
            SvgPicture.asset(AppAssets.icArrowDown),
          ],
        ),
      ),
    );
  }
}
