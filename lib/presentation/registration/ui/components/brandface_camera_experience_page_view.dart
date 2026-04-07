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
          Text('Years of camera experience', style: Typographies.titleMedium),
          const SizedBox(height: 8),
          CredInputField(
            controller: _yearsController,
            label: 'Write years of experience',
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Text('Optional experience', style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseOptionWidget(title: 'TV/Ad Experience'),
          ChooseOptionWidget(title: 'Press Mentions'),
          ChooseOptionWidget(title: 'Agency Representation'),
          SizedBox(height: 16),
          Text('Partners', style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChoosePartners(
            onItemSelected: (LangItemModel p1) {
              _updateData();
            },
          ),
          SizedBox(height: 16),
          Text('Exclusivity availability', style: Typographies.bodyMedium),
          const SizedBox(height: 8),
          YesNoWidget(onItemTaped: (value) {}),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Social media accounts', style: Typographies.titleSmall),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CredInputField(
                      controller: _awardController,
                      label: 'Write award info here',
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  AppButtons.primary(title: 'Apply', onTap: () {}),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
