import 'dart:io';

import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/catalog/city/city_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/city/city_state.dart';
import 'package:brandface/presentation/registration/bloc/catalog/region/region_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/sphere/sphere_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/sphere/sphere_state.dart';
import 'package:brandface/presentation/registration/bloc/upload/upload_cubit.dart';
import 'package:brandface/presentation/registration/ui/components/profile_avatar_item.dart';
import 'package:brandface/uikit/components/inputs/bio_input_field.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/usecase/registration/params/fill_brand_profile_param.dart';
import '../../../../uikit/components/avatar/avatar_placeholder.dart';
import '../../../../utils/services/image_crop_service.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../utils/extansions/snackbar_x.dart';
import 'choose_spoken_language.dart';

class BrandInfoPageView extends StatefulWidget {
  const BrandInfoPageView({
    super.key,
    required this.onChanged,
    this.initialLogoUrl,
    this.initialLogoId,
    this.initialParam,
    this.initialRegionName,
    this.initialCityName,
    this.initialSphereName,
  });

  final Function(FillBrandProfileParam) onChanged;
  final String? initialLogoUrl;
  final int? initialLogoId;
  final FillBrandProfileParam? initialParam;
  final String? initialRegionName;
  final String? initialCityName;
  final String? initialSphereName;

  @override
  State<BrandInfoPageView> createState() => _BrandInfoPageViewState();
}

class _BrandInfoPageViewState extends State<BrandInfoPageView>
    with AutomaticKeepAliveClientMixin<BrandInfoPageView> {
  FillBrandProfileParam _param = FillBrandProfileParam();
  File? _pickedImage;
  String? _currentLogoUrl;
  final List<UploadedAvatarItem> _uploadedItems = [];

  final TextEditingController _bioController = TextEditingController();

  int? _selectedRegionId;
  String? _selectedRegionName;
  int? _selectedCityId;
  String? _selectedCityName;
  int? _selectedSphereId;
  String? _selectedSphereName;
  List<int> _selectedLanguageIds = [];

  @override
  void initState() {
    super.initState();
    context.read<RegionCubit>().getCategories();
    context.read<CityCubit>().getCities();
    context.read<SphereCubit>().getSpheres();
    final initial = widget.initialParam;
    if (initial != null) {
      _param = initial;
      _selectedRegionId = initial.regionId;
      _selectedCityId = initial.cityId;
      _selectedSphereId = initial.sphereId;
      _selectedRegionName = widget.initialRegionName;
      _selectedCityName = widget.initialCityName;
      _selectedSphereName = widget.initialSphereName;
      if (initial.languageIds != null) {
        _selectedLanguageIds = List<int>.from(initial.languageIds!);
      }
      if (initial.description != null && initial.description!.isNotEmpty) {
        _bioController.text = initial.description!;
      }
    }
    final logoId = widget.initialLogoId ?? initial?.logoId;
    final logoUrl = widget.initialLogoUrl ?? initial?.logoUrl;
    _currentLogoUrl = logoUrl;
    if (logoId != null && logoUrl != null && logoUrl.isNotEmpty) {
      _uploadedItems.add(UploadedAvatarItem(id: logoId, url: logoUrl));
      _param = _param.copyWith(logoId: logoId);
    }
    if (initial != null) {
      widget.onChanged(_param);
    }
  }

  void _updateData() {
    _param = _param.copyWith(
      regionId: _selectedRegionId,
      cityId: _selectedCityId,
      sphereId: _selectedSphereId,
      languageIds: _selectedLanguageIds.isEmpty ? null : _selectedLanguageIds,
      description: _bioController.text.isEmpty ? null : _bioController.text,
    );
    widget.onChanged(_param);
  }

  Future<void> _pickAndUpload() async {
    final result = await FilePicker.pickFiles(
      type: FileType.image,
      withData: false,
    );
    if (!mounted || result == null || result.files.isEmpty) return;
    final path = result.files.single.path;
    if (path == null || path.isEmpty) return;
    final cropped = await cropImage(source: File(path));
    if (!mounted || cropped == null) return;
    setState(() => _pickedImage = cropped);
    context.read<UploadCubit>().uploadFile(cropped);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<UploadCubit, UploadState>(
      listener: (context, state) {
        state.maybeWhen(
          uploaded: (entity) {
            setState(() {
              _currentLogoUrl = entity.fileUrl;
              _uploadedItems.add(
                UploadedAvatarItem(id: entity.id, file: _pickedImage),
              );
            });
            _param = _param.copyWith(logoId: entity.id);
            widget.onChanged(_param);
          },
          failure: (_) {
            context.showAppSnackBar(
              t.misc.image_upload_failed,
              type: AppSnackBarType.error,
            );
          },
          orElse: () {},
        );
      },
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  child: ClipOval(
                    child: _pickedImage != null
                        ? Image.file(_pickedImage!, fit: BoxFit.cover)
                        : (_currentLogoUrl != null &&
                              _currentLogoUrl!.isNotEmpty)
                        ? Image.network(
                            _currentLogoUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                const AvatarPlaceholder(size: 96),
                          )
                        : const AvatarPlaceholder(size: 96),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<UploadCubit, UploadState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);
                        return GestureDetector(
                          onTap: isLoading ? null : _pickAndUpload,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(999),
                              color: AppColors.primary,
                            ),
                            child: isLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.black,
                                    ),
                                  )
                                : Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.icAttachFile),
                                      const SizedBox(width: 8),
                                      Text(t.registration.choose_file, style: Typographies.bodyMedium),
                                    ],
                                  ),
                          ),
                        );
                      },
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
            if (_uploadedItems.isNotEmpty) ...[
              const SizedBox(height: 24),
              ProfileAvatarItem(
                items: _uploadedItems,
                onSetMain: (id) {
                  _param = _param.copyWith(logoId: id);
                  widget.onChanged(_param);
                },
                onDelete: (id) {
                  setState(() {
                    _uploadedItems.removeWhere((e) => e.id == id);
                  });
                  if (_uploadedItems.isNotEmpty) {
                    _param = _param.copyWith(logoId: _uploadedItems.first.id);
                    widget.onChanged(_param);
                  }
                },
              ),
            ],
            const SizedBox(height: 40),
            Text(t.registration.region, style: Typographies.titleMedium),
            const SizedBox(height: 8),
            BlocBuilder<RegionCubit, RegionState>(
              builder: (context, regionState) {
                return _DropdownField(
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
                        return regionState.maybeWhen(
                          loading: () => const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          regionsLoaded: (data) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: data.map((item) {
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
                          ),
                          orElse: () => const SizedBox.shrink(),
                        );
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            Text(t.registration.city, style: Typographies.titleMedium),
            const SizedBox(height: 8),
            BlocBuilder<CityCubit, CityState>(
              builder: (context, cityState) {
                return _DropdownField(
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
                        if (cityState is CityLoading) {
                          return const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        if (cityState is CityLoaded) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: cityState.data.map((item) {
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
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            Text(t.registration.sphere, style: Typographies.titleMedium),
            const SizedBox(height: 8),
            BlocBuilder<SphereCubit, SphereState>(
              builder: (context, sphereState) {
                return _DropdownField(
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
                        if (sphereState is SphereLoading) {
                          return const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        if (sphereState is SphereLoaded) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: sphereState.data.map((item) {
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
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            ChooseSpokenLanguage(
              title: t.common.select,
              label: t.registration.spoken_languages,
              initialValue: _selectedLanguageIds.isEmpty ? null : _selectedLanguageIds,
              onItemSelected: (ids) {
                _selectedLanguageIds = ids;
                _updateData();
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
