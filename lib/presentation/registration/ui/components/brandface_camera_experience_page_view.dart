import 'package:brandface/core/error/failures.dart' show FailureLocalization;
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/award/award_cubit.dart';
import 'package:brandface/presentation/registration/ui/components/ambassador_experience_page_view.dart';
import 'package:brandface/presentation/registration/ui/components/choose_partners.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/buttons/buttons.dart';
import '../../../../uikit/typography/typography.dart';
import '../../../../utils/extansions/snackbar_x.dart';
import 'choose_spoken_language.dart';

class BrandfaceCameraExperiencePageView extends StatefulWidget {
  const BrandfaceCameraExperiencePageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<BrandfaceCameraExperiencePageView> createState() =>
      _BrandfaceCameraExperiencePageViewState();
}

class _BrandfaceCameraExperiencePageViewState
    extends State<BrandfaceCameraExperiencePageView>
    with AutomaticKeepAliveClientMixin<BrandfaceCameraExperiencePageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();
  final List<LangItemModel> _selectedPartners = [];

  void _updatePartners() {
    _param = _param.copyWith(
      partners: _selectedPartners.map((e) => e.id.toString()).toList(),
    );
    widget.onChanged(_param);
  }

  @override
  void initState() {
    super.initState();
    _yearsController.addListener(_onYearsChanged);
  }

  void _onYearsChanged() {
    final years = int.tryParse(_yearsController.text);
    if (years != null) {
      _param = _param.copyWith(yearsOfExperience: years);
      widget.onChanged(_param);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _yearsController.removeListener(_onYearsChanged);
    _yearsController.dispose();
    _awardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.registration.years_of_camera_experience,
            style: Typographies.titleMedium,
          ),
          const SizedBox(height: 8),
          CredInputField(
            controller: _yearsController,
            label: t.registration.write_years_of_experience,
            validator: (String? value) {
              if (value == null || value.isEmpty)
                return t.common.please_enter_text;
              return null;
            },
          ),
          const SizedBox(height: 24),
          Text(
            t.registration.optional_experience,
            style: Typographies.titleMedium,
          ),
          const SizedBox(height: 8),
          ChooseOptionWidget(
            title: t.optional_items.tv_ad_experience,
            onChanged: (val) {
              _param = _param.copyWith(hasAdExperience: val);
              widget.onChanged(_param);
            },
          ),
          ChooseOptionWidget(
            title: t.optional_items.press_mentions,
            onChanged: (val) {
              _param = _param.copyWith(pressMentions: val);
              widget.onChanged(_param);
            },
          ),
          ChooseOptionWidget(
            title: t.optional_items.agency_representation,
            onChanged: (val) {
              _param = _param.copyWith(agencyRepresentation: val);
              widget.onChanged(_param);
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
          Text(
            t.registration.exclusivity_availability,
            style: Typographies.bodyMedium,
          ),
          const SizedBox(height: 8),
          YesNoWidget(
            onItemTaped: (value) {
              _param = _param.copyWith(
                pricing: (_param.pricing ?? Pricing()).copyWith(
                  exclusivityAvailable: value,
                ),
              );
              widget.onChanged(_param);
            },
          ),
          SizedBox(height: 16),
          BlocConsumer<AwardCubit, AwardState>(
            listener: (context, state) {
              state.maybeWhen(
                failure: (awards, failure) {
                  context.showAppSnackBar(
                    failure.localized,
                    type: AppSnackBarType.error,
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
                        onTap: () {
                          if (isLoading) return;
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
}
