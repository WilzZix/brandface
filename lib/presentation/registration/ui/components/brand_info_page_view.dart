import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/usecase/registration/upload_profile_file_use_case.dart';
import 'package:brandface/uikit/components/inputs/bio_input_field.dart';
import 'package:brandface/uikit/components/ui_components/profile_image.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/usecase/registration/params/fill_brand_profile_param.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import 'choose_spoken_language.dart';

class BrandInfoPageView extends StatefulWidget {
  const BrandInfoPageView({
    super.key,
    required this.onChanged,
    this.initialParam,
  });

  final Function(FillBrandProfileParam) onChanged;
  final FillBrandProfileParam? initialParam;

  @override
  State<BrandInfoPageView> createState() => _BrandInfoPageViewState();
}

class _BrandInfoPageViewState extends State<BrandInfoPageView>
    with AutomaticKeepAliveClientMixin<BrandInfoPageView> {
  FillBrandProfileParam _param = FillBrandProfileParam();
  final TextEditingController _bioController = TextEditingController();
  bool _isUploadingLogo = false;
  String? _logoUrl;
  String? _logoFileName;

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

  @override
  void initState() {
    super.initState();
    _param = widget.initialParam ?? FillBrandProfileParam();
    _logoUrl = widget.initialParam?.logoUrl;
    _bioController.text = widget.initialParam?.description ?? '';
    _selectedRegionId = widget.initialParam?.regionId;
    _selectedCityId = widget.initialParam?.cityId;
    _selectedSphereId = widget.initialParam?.sphereId;
  }

  void _updateData() {
    _param = _param.copyWith(
      regionId: _selectedRegionId,
      cityId: _selectedCityId,
      sphereId: _selectedSphereId,
      description: _bioController.text.isEmpty ? null : _bioController.text,
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
          Text(
            t.registration.upload_profile_picture,
            style: Typographies.titleMedium,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                height: 96,
                width: 96,
                child: ProfileImage(imageUrl: _logoUrl, size: 96),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _isUploadingLogo ? null : _pickAndUploadLogo,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(999),
                        color: _isUploadingLogo
                            ? AppColors.lightBg2
                            : AppColors.primary,
                      ),
                      child: Row(
                        children: [
                          if (_isUploadingLogo)
                            const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          else
                            SvgPicture.asset(AppAssets.icAttachFile),
                          const SizedBox(width: 8),
                          Text(
                            _isUploadingLogo
                                ? 'Uploading...'
                                : t.registration.choose_file,
                            style: Typographies.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.registration.file_format_hint,
                    style: Typographies.bodySmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  if (_logoFileName != null) ...[
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 190,
                      child: Text(
                        _logoFileName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Typographies.bodySmall.copyWith(
                          color: AppColors.mutedBlack,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
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

  Future<void> _pickAndUploadLogo() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['svg', 'png', 'jpg', 'jpeg', 'gif'],
      withData: false,
    );

    if (!mounted || result == null || result.files.isEmpty) {
      return;
    }

    final selectedFile = result.files.single;
    final path = selectedFile.path;
    if (path == null || path.isEmpty) {
      _showMessage('Selected file path is unavailable.');
      return;
    }

    setState(() {
      _isUploadingLogo = true;
      _logoFileName = selectedFile.name;
    });

    final uploadResult = await sl<UploadProfileFileUseCase>().call(
      params: path,
    );
    UploadedFileEntity? uploadedFile;
    Object? uploadFailure;
    uploadResult.fold(
      ifLeft: (failure) => uploadFailure = failure,
      ifRight: (file) => uploadedFile = file,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isUploadingLogo = false;
    });

    if (uploadedFile == null) {
      _showMessage(uploadFailure?.toString() ?? 'File upload failed.');
      return;
    }

    _param = _param.copyWith(
      logoId: uploadedFile!.id,
      logoUrl: uploadedFile!.fileUrl,
    );
    setState(() {
      _logoUrl = uploadedFile!.fileUrl;
      _logoFileName = selectedFile.name;
    });
    widget.onChanged(_param);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
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
