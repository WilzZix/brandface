import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/buttons/buttons.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_partners.dart';
import 'choose_spoken_language.dart';

class ExperiencePageView extends StatefulWidget {
  const ExperiencePageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<ExperiencePageView> createState() => _ExperiencePageViewState();
}

class _ExperiencePageViewState extends State<ExperiencePageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final List<LangItemModel> _selectedNichesItems = [];
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();

  void _updateData() {
    _param = _param.copyWith(
      categoryIds: _selectedNichesItems.map((e) => e.id).toList(),
    );
    widget.onChanged(_param);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.registration.years_of_experience, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          CredInputField(
            controller: _experienceController,
            label: t.registration.write_years_of_experience,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return t.common.please_enter_text;
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Text(t.registration.partners, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChoosePartners(
            onItemSelected: (LangItemModel p1) {
              _updateData();
            },
          ),
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
