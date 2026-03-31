import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/presentation/registration/ui/components/profile_avatar_item.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralInfoPageView extends StatefulWidget {
  const GeneralInfoPageView({super.key});

  @override
  State<GeneralInfoPageView> createState() => _GeneralInfoPageViewState();
}

class _GeneralInfoPageViewState extends State<GeneralInfoPageView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upload profile picture', style: Typographies.titleMedium),
          SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                height: 96,
                width: 96,
                child: Image.asset('assets/images/im_person_avatar_sample.png', fit: BoxFit.cover),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(999),
                      color: AppColors.primary,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssets.icAttachFile),
                        SizedBox(width: 8),
                        Text('Choose file', style: Typographies.bodyMedium),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'SVG, PNG, JPG or GIF (MAX. 800x400px).',
                    style: Typographies.bodySmall.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          ProfileAvatarItem(onTap: (int p1) {}, items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
        ],
      ),
    );
  }
}
