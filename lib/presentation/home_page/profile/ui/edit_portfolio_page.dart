import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/presentation/home_page/profile/bloc/portfolio/portfolio_item_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/portfolio/portfolio_item_state.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class EditPortfolioPage extends StatefulWidget {
  const EditPortfolioPage({super.key, required this.portfolioId});

  static const String tag = '/edit-portfolio';
  final int portfolioId;

  @override
  State<EditPortfolioPage> createState() => _EditPortfolioPageState();
}

class _EditPortfolioPageState extends State<EditPortfolioPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedPlatform = 'Youtube';
  int? _coverImageId;
  String _coverImageUrl = '';
  List<PortfolioImageEntity> _galleryImages = const [];
  List<String> _links = const [];
  bool _initializedFromState = false;

  static const List<String> _platforms = [
    'Youtube',
    'Instagram',
    'TikTok',
    'Behance',
    'Website',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PortfolioItemCubit, PortfolioItemState>(
      listener: (context, state) {
        if (state.item != null && !_initializedFromState) {
          _hydrateFromItem(state.item!);
        } else if (state.item != null) {
          setState(() {
            _galleryImages = state.item!.images;
            if (_coverImageId == state.item!.coverImageId ||
                _coverImageId == null) {
              _coverImageId = state.item!.coverImageId;
              _coverImageUrl = state.item!.coverImageUrl;
            }
          });
        }

        if (state.status == PortfolioItemStatus.failure &&
            state.failure != null) {
          context.showAppSnackBar(
            state.failure!.message,
            type: AppSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        final isLoading =
            state.status == PortfolioItemStatus.loading ||
            (!_initializedFromState && state.item == null);
        final isBusy = state.status == PortfolioItemStatus.saving;

        if (isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.lightBg,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.lightBg,
          ),
          body: SafeArea(
            top: false,
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    MediaQuery.of(context).padding.bottom + 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fill profile information',
                        style: Typographies.titleLarge.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 16),
                      _StepHeader(onBack: () => context.pop()),
                      const SizedBox(height: 24),
                      Text(
                        'Upload thumbnail picture',
                        style: Typographies.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _EditablePreviewImage(
                            imageUrl: _coverImageUrl,
                            width: 96,
                            height: 96,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _ActionPillButton(
                                  iconPath: AppAssets.icAttachFile,
                                  label: 'Choose files',
                                  onTap: isBusy ? null : _pickCoverImage,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'SVG, PNG, JPG or GIF (MAX. 800×400px).',
                                  style: Typographies.bodySmall.copyWith(
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text('Portfolio name', style: Typographies.titleMedium),
                      const SizedBox(height: 8),
                      CredInputField(
                        controller: _titleController,
                        label: 'Portfolio name here',
                      ),
                      const SizedBox(height: 24),
                      Text('Add links', style: Typographies.titleSmall),
                      const SizedBox(height: 8),
                      _SelectorPill(
                        title: _selectedPlatform,
                        onTap: _pickPlatform,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _OutlinedField(
                              controller: _linkController,
                              hintText: 'Paste link',
                            ),
                          ),
                          const SizedBox(width: 8),
                          _ApplyButton(onTap: _applyLink),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ..._links.map(
                        (link) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  link,
                                  style: Typographies.bodyMedium,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _deleteLink(link),
                                child: Text(
                                  'Delete',
                                  style: Typographies.labelLarge.copyWith(
                                    color: AppColors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Upload profile picture',
                        style: Typographies.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      _ActionPillButton(
                        iconPath: AppAssets.icAttachFile,
                        label: 'Choose files',
                        onTap: isBusy ? null : _pickGalleryImage,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'SVG, PNG, JPG or GIF (MAX. 800×400px).',
                        style: Typographies.bodySmall.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 112,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _galleryImages.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            return _EditableGalleryImage(
                              imageUrl: _galleryImages[index].imageUrl,
                              onDelete: isBusy
                                  ? null
                                  : () => _deleteGalleryImage(
                                      _galleryImages[index],
                                    ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('Description', style: Typographies.titleSmall),
                      const SizedBox(height: 8),
                      _DescriptionField(controller: _descriptionController),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: AppButtons.primary(
                          title: 'Continue',
                          onTap: isBusy ? null : _savePortfolio,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: GestureDetector(
                          onTap: isBusy ? null : _savePortfolio,
                          child: Text(
                            'Save and continue later',
                            style: Typographies.labelLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isBusy)
                  Positioned.fill(
                    child: ColoredBox(
                      color: Colors.black.withValues(alpha: 0.08),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _hydrateFromItem(PortfolioItemEntity item) {
    _titleController.text = item.name;
    _descriptionController.text = item.description;
    _links = List<String>.from(item.links);
    _coverImageId = item.coverImageId;
    _coverImageUrl = item.coverImageUrl;
    _galleryImages = List<PortfolioImageEntity>.from(item.images);
    _initializedFromState = true;
    setState(() {});
  }

  Future<void> _pickPlatform() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      backgroundColor: AppColors.lightBg,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: _platforms
                .map(
                  (item) => ListTile(
                    title: Text(item),
                    trailing: item == _selectedPlatform
                        ? SvgPicture.asset(AppAssets.icCheck)
                        : null,
                    onTap: () => Navigator.of(bottomSheetContext).pop(item),
                  ),
                )
                .toList(),
          ),
        );
      },
    );

    if (!mounted || selected == null) {
      return;
    }

    setState(() {
      _selectedPlatform = selected;
    });
  }

  void _applyLink() {
    final value = _linkController.text.trim();
    if (value.isEmpty) {
      return;
    }

    setState(() {
      _links = [..._links, value];
      _linkController.clear();
    });
  }

  void _deleteLink(String link) {
    setState(() {
      _links = _links.where((item) => item != link).toList(growable: false);
    });
  }

  Future<void> _pickCoverImage() async {
    _showUploadUnavailableMessage();
  }

  Future<void> _pickGalleryImage() async {
    _showUploadUnavailableMessage();
  }

  Future<void> _deleteGalleryImage(PortfolioImageEntity image) async {
    await context.read<PortfolioItemCubit>().removeImage(
      portfolioId: widget.portfolioId,
      imageId: image.id,
    );
  }

  Future<void> _savePortfolio() async {
    final payload = <String, dynamic>{
      'name': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'cover_image': _coverImageId,
      'links': _links.join('\n'),
      'order': context.read<PortfolioItemCubit>().state.item?.order ?? 0,
    }..removeWhere((key, value) => value == null);

    final isSuccess = await context.read<PortfolioItemCubit>().savePortfolio(
      id: widget.portfolioId,
      data: payload,
    );

    if (!mounted || !isSuccess) {
      return;
    }

    context.pop(true);
  }

  void _showUploadUnavailableMessage() {
    context.showAppSnackBar(
      'File picker UI hali ulanmagan. Metadata save ishlaydi.',
    );
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StepArrow(onTap: onBack, iconPath: AppAssets.icArrowLeft),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.center,
            child: Text(
              'General info (1/6)',
              style: Typographies.labelMedium.copyWith(color: AppColors.white),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _StepArrow(iconPath: AppAssets.icArrowRight),
      ],
    );
  }
}

class _StepArrow extends StatelessWidget {
  const _StepArrow({required this.iconPath, this.onTap});

  final String iconPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Ink(
        width: 72,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.lightBg2,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Center(child: SvgPicture.asset(iconPath)),
      ),
    );
  }
}

class _ActionPillButton extends StatelessWidget {
  const _ActionPillButton({
    required this.iconPath,
    required this.label,
    this.onTap,
  });

  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(width: 8),
            Text(label, style: Typographies.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _SelectorPill extends StatelessWidget {
  const _SelectorPill({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Ink(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.lightBg2,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Typographies.labelLarge),
            const Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    );
  }
}

class _ApplyButton extends StatelessWidget {
  const _ApplyButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Ink(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            SvgPicture.asset(AppAssets.icCheck),
            const SizedBox(width: 8),
            Text('Apply', style: Typographies.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _OutlinedField extends StatelessWidget {
  const _OutlinedField({required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Typographies.bodyLarge.copyWith(color: AppColors.mutedBlack),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: AppColors.primaryDark),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      ),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 7,
      decoration: InputDecoration(
        hintText: 'Write text here ...',
        hintStyle: Typographies.bodyLarge.copyWith(color: AppColors.mutedBlack),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primaryDark),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}

class _EditablePreviewImage extends StatelessWidget {
  const _EditablePreviewImage({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  final String imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageUrl.isEmpty
          ? Container(
              width: width,
              height: height,
              color: AppColors.borderColor,
              alignment: Alignment.center,
              child: Icon(Icons.image_outlined, color: AppColors.grey),
            )
          : Image.network(
              imageUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: width,
                height: height,
                color: AppColors.borderColor,
                alignment: Alignment.center,
                child: Icon(Icons.image_outlined, color: AppColors.grey),
              ),
            ),
    );
  }
}

class _EditableGalleryImage extends StatelessWidget {
  const _EditableGalleryImage({required this.imageUrl, required this.onDelete});

  final String imageUrl;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 112,
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 112,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl.isEmpty
                  ? Container(
                      color: AppColors.borderColor,
                      alignment: Alignment.center,
                      child: Icon(Icons.image_outlined, color: AppColors.grey),
                    )
                  : Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onDelete,
              child: Icon(Icons.delete_outline, color: const Color(0xFFC70036)),
            ),
          ),
        ],
      ),
    );
  }
}
