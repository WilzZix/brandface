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

class _ExperiencePageViewState extends State<ExperiencePageView>
    with AutomaticKeepAliveClientMixin<ExperiencePageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _experienceController.addListener(_handleExperienceChange);
    _awardController.addListener(_handleAwardChange);
  }

  void _handleExperienceChange() {
    final text = _experienceController.text;
    if (text.isNotEmpty) {
      final years = int.tryParse(text);
      if (years != null) {
        _param = _param.copyWith(yearsOfExperience: years);
        widget.onChanged(_param);
      }
    }
  }

  void _handleAwardChange() {
    final text = _awardController.text;
    if (text.isNotEmpty) {
      widget.onChanged(_param);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.registration.years_of_experience,
            style: Typographies.titleMedium,
          ),
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
              _param = _param.copyWith(partners: [p1.id.toString()]);
              widget.onChanged(_param);
            },
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.registration.write_award_info,
                style: Typographies.titleSmall,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CredInputField(
                      onChanged: () {
                        //TODO awards qo'shish
                      },
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

  @override
  void dispose() {
    _experienceController.removeListener(_handleExperienceChange);
    _awardController.removeListener(_handleAwardChange);
    _experienceController.dispose();
    _awardController.dispose();
    super.dispose();
  }
}
