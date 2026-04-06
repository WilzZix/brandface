import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/presentation/registration/ui/components/profile_avatar_item.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/inputs/bio_input_field.dart';
import 'choose_contact_detail.dart';
import 'choose_date_of_birthday.dart';
import 'choose_gender.dart';
import 'choose_spoken_language.dart';

class GeneralInfoPageView extends StatefulWidget {
  const GeneralInfoPageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<GeneralInfoPageView> createState() => _GeneralInfoPageViewState();
}

class _GeneralInfoPageViewState extends State<GeneralInfoPageView>
    with AutomaticKeepAliveClientMixin<GeneralInfoPageView> {
  final TextEditingController _profileInfoController = TextEditingController();
  FillInfluencerProfileParam _fillInfluencerProfileParam =
      FillInfluencerProfileParam();

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                child: Image.asset(
                  'assets/images/im_person_avatar_sample.png',
                  fit: BoxFit.cover,
                ),
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
                    style: Typographies.bodySmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          ProfileAvatarItem(
            onTap: (int p1) {
              _fillInfluencerProfileParam = _fillInfluencerProfileParam
                  .copyWith(avatarId: p1);
              widget.onChanged(_fillInfluencerProfileParam);
            },
            items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
          ),
          SizedBox(height: 40),
          ChooseSpokenLanguage(
            title: 'Select',
            label: 'Spoken languages',
            onItemSelected: (List<int> ids) {
              _fillInfluencerProfileParam = _fillInfluencerProfileParam
                  .copyWith(languageIds: ids);
              widget.onChanged(_fillInfluencerProfileParam);
            },
          ),
          SizedBox(height: 24),
          ChooseDateOfBirthday(
            title: 'DD.MM.YYYY',
            label: 'Date of birth',
            onItemSelected: (DateTime date) {
              _fillInfluencerProfileParam = _fillInfluencerProfileParam
                  .copyWith(birthDate: date);
              widget.onChanged(_fillInfluencerProfileParam);
            },
            iconPath: AppAssets.icCalendar,
          ),
          SizedBox(height: 24),
          ChooseGender(
            title: 'Select',
            label: 'Gender',
            onItemSelected: (String p1) {
              _fillInfluencerProfileParam = _fillInfluencerProfileParam
                  .copyWith(gender: p1);
              widget.onChanged(_fillInfluencerProfileParam);
            },
          ),
          SizedBox(height: 24),
          ChooseContactDetail(
            title: 'Phone',
            label: 'Contact details',
            onItemSelected: (List<Contact> contacts) {
              _fillInfluencerProfileParam = _fillInfluencerProfileParam
                  .copyWith(contacts: contacts);
              widget.onChanged(_fillInfluencerProfileParam);
            },
          ),
          SizedBox(height: 24),
          BioInputField(
            controller: _profileInfoController,
            label: 'Profile information',
            onChanged: () {
              _fillInfluencerProfileParam = _fillInfluencerProfileParam
                  .copyWith(bio: _profileInfoController.text);
              widget.onChanged(_fillInfluencerProfileParam);
            },
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
