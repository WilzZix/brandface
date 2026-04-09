import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/ui/components/ambassador_experience_page_view.dart';
import 'package:brandface/presentation/registration/ui/components/choose_partners.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/buttons/buttons.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_spoken_language.dart';

class BrandfaceCameraExperiencePageView extends StatefulWidget {
  const BrandfaceCameraExperiencePageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<BrandfaceCameraExperiencePageView> createState() =>
      _BrandfaceCameraExperiencePageViewState();
}

class _BrandfaceCameraExperiencePageViewState
    extends State<BrandfaceCameraExperiencePageView> {
  final FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();


  void _updateData() {
    widget.onChanged(_param);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.registration.years_of_camera_experience, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          CredInputField(
            controller: _yearsController,
            label: t.registration.write_years_of_experience,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return t.common.please_enter_text;
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Text(t.registration.optional_experience, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseOptionWidget(title: t.optional_items.tv_ad_experience),
          ChooseOptionWidget(title: t.optional_items.press_mentions),
          ChooseOptionWidget(title: t.optional_items.agency_representation),
          SizedBox(height: 16),
          Text(t.registration.partners, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChoosePartners(
            onItemSelected: (LangItemModel p1) {
              _updateData();
            },
          ),
          SizedBox(height: 16),
          Text(t.registration.exclusivity_availability, style: Typographies.bodyMedium),
          const SizedBox(height: 8),
          YesNoWidget(onItemTaped: (value) {}),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.registration.social_media_accounts, style: Typographies.titleSmall),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CredInputField(
                      controller: _awardController,
                      label: t.registration.write_award_info,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return t.common.please_enter_text;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  AppButtons.primary(title: t.common.apply, onTap: () {}),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
