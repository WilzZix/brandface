import 'dart:io';

import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/i18n/strings.g.dart';

class UploadedAvatarItem {
  final int id;
  final File file;

  const UploadedAvatarItem({required this.id, required this.file});
}

class ProfileAvatarItem extends StatefulWidget {
  const ProfileAvatarItem({
    super.key,
    required this.onSetMain,
    required this.onDelete,
    required this.items,
  });

  final Function(int id) onSetMain;
  final Function(int id) onDelete;
  final List<UploadedAvatarItem> items;

  @override
  State<ProfileAvatarItem> createState() => _ProfileAvatarItemState();
}

class _ProfileAvatarItemState extends State<ProfileAvatarItem> {
  int? _selectedId;

  @override
  void initState() {
    super.initState();
    if (widget.items.isNotEmpty) {
      _selectedId = widget.items.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        itemCount: widget.items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return GestureDetector(
            onTap: () {
              setState(() => _selectedId = item.id);
              widget.onSetMain(item.id);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipOval(
                      child: Image.file(
                        item.file,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: -6,
                      right: -6,
                      child: GestureDetector(
                        onTap: () => widget.onDelete(item.id),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.icTrashBin,
                            width: 12,
                            height: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _selectedId == item.id
                        ? SvgPicture.asset(AppAssets.icCheckBox)
                        : SvgPicture.asset(AppAssets.icCheckBoxDisabled),
                    const SizedBox(width: 4),
                    Text(t.common.set_as_main, style: Typographies.labelSmall),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 16),
      ),
    );
  }
}
