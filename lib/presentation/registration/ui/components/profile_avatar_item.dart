import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileAvatarItem extends StatefulWidget {
  const ProfileAvatarItem({super.key, required this.onTap, required this.items});

  final Function(int) onTap;
  final List<int> items;

  @override
  State<ProfileAvatarItem> createState() => _ProfileAvatarItemState();
}

class _ProfileAvatarItemState extends State<ProfileAvatarItem> {
  int? _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: ListView.separated(
        itemCount: widget.items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _selectedItem = widget.items[index];
              widget.onTap(widget.items[index]);
              setState(() {});
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.asset('assets/images/im_person_avatar_sample.png'),
                    Positioned(
                      top: 0,
                      right: -10,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                        child: SvgPicture.asset(AppAssets.icTrashBin),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _selectedItem == widget.items[index]
                        ? SvgPicture.asset(AppAssets.icCheckBox)
                        : SvgPicture.asset(AppAssets.icCheckBoxDisabled),
                    SizedBox(width: 4),
                    Text(t.common.set_as_main, style: Typographies.labelSmall),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 16);
        },
      ),
    );
  }
}
