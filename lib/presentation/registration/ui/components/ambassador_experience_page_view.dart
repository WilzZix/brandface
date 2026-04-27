import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/error/failures.dart' show FailureLocalization;
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/award/award_cubit.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final TextEditingController _promoExperienceController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();
  final List<LangItemModel> _selectedNichesItems = [];

  @override
  void initState() {
    super.initState();
    _promoExperienceController.addListener(_onExperienceChanged);
  }

  void _onExperienceChanged() {
    final years = int.tryParse(_promoExperienceController.text);
    if (years != null) {
      _param = _param.copyWith(yearsOfExperience: years);
      widget.onChanged(_param);
    }
  }

  void _updateData() {
    _param = _param.copyWith(
      yearsOfExperience: int.tryParse(_promoExperienceController.text),
      partners: _selectedNichesItems.map((e) => e.id.toString()).toList(),
    );
    widget.onChanged(_param);
  }

  void _updateField(FillInfluencerProfileParam updated) {
    _param = updated;
    widget.onChanged(_param);
  }

  @override
  void dispose() {
    _promoExperienceController.removeListener(_onExperienceChanged);
    _promoExperienceController.dispose();
    _awardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.registration.years_of_experience, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          CredInputField(
            controller: _promoExperienceController,
            label: t.registration.describe_your_experience,
            validator: (String? value) {
              if (value == null || value.isEmpty) return t.common.please_enter_text;
              return null;
            },
          ),
          SizedBox(height: 16),
          Text(t.registration.partners, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChoosePartners(
            onItemSelected: (LangItemModel p1) {
              if (_selectedNichesItems.any((e) => e.id == p1.id)) return;
              setState(() {
                _selectedNichesItems.add(p1);
              });
              _updateData();
            },
          ),
          if (_selectedNichesItems.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _selectedNichesItems.length,
              itemBuilder: (context, index) {
                final partner = _selectedNichesItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(partner.name, style: Typographies.bodyMedium),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedNichesItems.removeAt(index);
                          });
                          _updateData();
                        },
                        child: Text(
                          t.common.delete,
                          style: Typographies.labelLarge.copyWith(
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          const SizedBox(height: 24),
          Text(t.registration.experience_in_referral, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          YesNoWidget(
            onItemTaped: (bool value) {
              _updateField(_param.copyWith(referralExperience: value));
            },
          ),
          const SizedBox(height: 16),
          Text(t.registration.optional_experience, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseOptionWidget(
            title: t.optional_items.previous_brand_collaborations,
            onChanged: (val) {
              _updateField(_param.copyWith(previousBrandCollaborations: val));
            },
          ),
          const SizedBox(height: 16),
          ChooseOptionWidget(
            title: t.optional_items.case_study_link,
            onChanged: (val) {
              _updateField(_param.copyWith(caseStudyAvailable: val));
            },
          ),
          const SizedBox(height: 16),
          ChooseOptionWidget(
            title: t.optional_items.conversion_metrics,
            onChanged: (val) {
              _updateField(_param.copyWith(conversionMetricsAvailable: val));
            },
          ),
          SizedBox(height: 16),
          BlocConsumer<AwardCubit, AwardState>(
            listener: (context, state) {
              state.maybeWhen(
                failure: (awards, failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(failure.localized),
                      backgroundColor: AppColors.red,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              final awards = state.awards;
              final isLoading = state.maybeWhen(
                loading: (_) => true,
                orElse: () => false,
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.registration.write_award_info,
                      style: Typographies.titleSmall),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CredInputField(
                          controller: _awardController,
                          label: t.registration.write_award_info,
                          validator: (v) => null,
                        ),
                      ),
                      SizedBox(width: 8),
                      AppButtons.primary(
                        title: t.common.apply,
                        onTap: isLoading
                            ? null
                            : () {
                                final text = _awardController.text.trim();
                                if (text.isNotEmpty) {
                                  context
                                      .read<AwardCubit>()
                                      .createAward(title: text);
                                  _awardController.clear();
                                }
                              },
                      ),
                    ],
                  ),
                  if (awards.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: awards.length,
                      itemBuilder: (context, index) {
                        final award = awards[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(award.title,
                                      style: Typographies.bodyMedium)),
                              GestureDetector(
                                onTap: () => context
                                    .read<AwardCubit>()
                                    .deleteAward(awardId: award.id),
                                child: Text(t.common.delete,
                                    style: Typographies.labelLarge
                                        .copyWith(color: AppColors.red)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              );
            },
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
  const ChooseOptionWidget({
    super.key,
    required this.title,
    this.onChanged,
  });

  final String title;
  final ValueChanged<bool>? onChanged;

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
        widget.onChanged?.call(_selected);
      },
      child: Row(
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            side: BorderSide(
              color: _selected ? Color(0xFF497D00) : AppColors.borderColor,
              width: 1.0,
            ),
            activeColor: AppColors.primary,
            value: _selected,
            onChanged: (value) {
              setState(() {
                _selected = value!;
              });
              widget.onChanged?.call(_selected);
            },
          ),
          Text(widget.title, style: Typographies.labelLarge),
        ],
      ),
    );
  }
}
