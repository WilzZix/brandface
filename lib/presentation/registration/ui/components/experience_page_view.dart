import 'package:brandface/core/error/failures.dart' show FailureLocalization;
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/award/award_cubit.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/buttons/buttons.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_partners.dart';
import 'choose_spoken_language.dart';

class ExperiencePageView extends StatefulWidget {
  const ExperiencePageView({
    super.key,
    required this.initialParam,
    required this.onChanged,
  });

  final FillInfluencerProfileParam initialParam;
  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<ExperiencePageView> createState() => _ExperiencePageViewState();
}

class _ExperiencePageViewState extends State<ExperiencePageView>
    with AutomaticKeepAliveClientMixin<ExperiencePageView> {
  late FillInfluencerProfileParam _param;
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();
  final List<LangItemModel> _selectedPartners = [];

  @override
  void initState() {
    super.initState();
    _param = widget.initialParam;
    final years = widget.initialParam.yearsOfExperience;
    if (years != null) {
      _experienceController.text = years.toString();
    }
    _experienceController.addListener(_handleExperienceChange);
  }

  void _updatePartners() {
    _param = _param.copyWith(
      partners: _selectedPartners.map((e) => e.id.toString()).toList(),
    );
    widget.onChanged(_param);
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

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
              if (_selectedPartners.any((e) => e.id == p1.id)) return;
              setState(() {
                _selectedPartners.add(p1);
              });
              _updatePartners();
            },
          ),
          if (_selectedPartners.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _selectedPartners.length,
              itemBuilder: (context, index) {
                final partner = _selectedPartners[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(partner.name, style: Typographies.bodyMedium),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPartners.removeAt(index);
                          });
                          _updatePartners();
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
                  Text(
                    t.registration.write_award_info,
                    style: Typographies.titleSmall,
                  ),
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
                                  context.read<AwardCubit>().createAward(
                                    title: text,
                                  );
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
                                child: Text(
                                  award.title,
                                  style: Typographies.bodyMedium,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context
                                    .read<AwardCubit>()
                                    .deleteAward(awardId: award.id),
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
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _experienceController.removeListener(_handleExperienceChange);
    _experienceController.dispose();
    _awardController.dispose();
    super.dispose();
  }
}
