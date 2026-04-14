import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/buttons/buttons.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_partners.dart';
import 'choose_spoken_language.dart';

class AmbassadorExperiencePageView extends StatefulWidget {
  const AmbassadorExperiencePageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<AmbassadorExperiencePageView> createState() =>
      _AmbassadorExperiencePageViewState();
}

class _AmbassadorExperiencePageViewState
    extends State<AmbassadorExperiencePageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final TextEditingController _promoExperienceController =
      TextEditingController();
  final TextEditingController _awardController = TextEditingController();
  final List<LangItemModel> _selectedNichesItems = [];

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
            controller: _promoExperienceController,
            label: t.registration.describe_your_experience,
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
          const SizedBox(height: 24),
          Text(
            t.registration.experience_in_referral,
            style: Typographies.titleMedium,
          ),
          const SizedBox(height: 8),
          YesNoWidget(onItemTaped: (bool p1) {}),
          const SizedBox(height: 16),
          Text(t.registration.optional_experience, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseOptionWidget(title: t.optional_items.previous_brand_collaborations),
          const SizedBox(height: 16),
          ChooseOptionWidget(title: t.optional_items.case_study_link),
          const SizedBox(height: 16),
          ChooseOptionWidget(title: t.optional_items.conversion_metrics),
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

class YesNoWidget extends StatefulWidget {
  const YesNoWidget({super.key, required this.onItemTaped});

  final Function(bool) onItemTaped;

  @override
  State<YesNoWidget> createState() => _YesNoWidgetState();
}

class _YesNoWidgetState extends State<YesNoWidget> {
  bool _isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              widget.onItemTaped(true);
              _isSelected = true;
              setState(() {});
            },
            child: Row(
              children: [
                _isSelected
                    ? SvgPicture.asset(AppAssets.icCheckBox)
                    : SvgPicture.asset(AppAssets.icCheckBoxDisabled),
                SizedBox(width: 8),
                Text(t.common.yes, style: Typographies.labelLarge),
              ],
            ),
          ),
          SizedBox(width: 24),
          GestureDetector(
            onTap: () {
              widget.onItemTaped(false);
              _isSelected = false;
              setState(() {});
            },
            child: Row(
              children: [
                _isSelected
                    ? SvgPicture.asset(AppAssets.icCheckBoxDisabled)
                    : SvgPicture.asset(AppAssets.icCheckBox),
                SizedBox(width: 8),
                Text(t.common.no, style: Typographies.labelLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseOptionWidget extends StatefulWidget {
  const ChooseOptionWidget({super.key, required this.title});

  final String title;

  @override
  State<ChooseOptionWidget> createState() => _ChooseOptionWidgetState();
}

class _ChooseOptionWidgetState extends State<ChooseOptionWidget> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
        });
      },
      child: Row(
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            side: BorderSide(
              color: _selected ? Color(0xFF497D00) : AppColors.borderColor,
              // Your custom border color
              width: 1.0, // Optional: thickness
            ),
            activeColor: AppColors.primary,
            value: _selected,
            onChanged: (value) {
              _selected = value!;
              setState(() {});
            },
          ),
          Text(widget.title, style: Typographies.labelLarge),
        ],
      ),
    );
  }
}
