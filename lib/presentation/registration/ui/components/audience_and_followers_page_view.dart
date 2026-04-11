import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/buttons/buttons.dart';
import '../../../../uikit/components/inputs/from_to_input_field.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_geography.dart';
import 'choose_spoken_language.dart';

class AudienceAndFollowersPageView extends StatefulWidget {
  const AudienceAndFollowersPageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<AudienceAndFollowersPageView> createState() =>
      _AudienceAndFollowersPageViewState();
}

class _AudienceAndFollowersPageViewState
    extends State<AudienceAndFollowersPageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final List<LangItemModel> _selectedNichesItems = [];
  final TextEditingController _controllerFrom = TextEditingController();
  final TextEditingController _controllerTo = TextEditingController();
  final TextEditingController _controllerFromWomen = TextEditingController();
  final TextEditingController _controllerToWomen = TextEditingController();
  final TextEditingController _controllerSocial = TextEditingController();

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
          Text(t.registration.geography, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseGeography(
            onItemSelected: (LangItemModel item) {
              setState(() {
                if (!_selectedNichesItems.any((e) => e.id == item.id)) {
                  _selectedNichesItems.add(item);
                  _updateData();
                }
              });
            },
          ),
          const SizedBox(height: 32),
          if (_selectedNichesItems.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.registration.selected_geography,
                  style: Typographies.titleSmall,
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _selectedNichesItems.length,

                  itemBuilder: (context, index) {
                    final niche = _selectedNichesItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(niche.name, style: Typographies.bodyMedium),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedNichesItems.removeAt(index);
                                _updateData();
                              });
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
                const SizedBox(height: 16),
              ],
            ),
          FromToInputField(
            controllerFrom: _controllerFrom,
            controllerTo: _controllerTo,
            title: t.registration.men,
            labelFrom: t.registration.age_from,
            labelTo: t.registration.age_to,
          ),
          SizedBox(height: 16),
          FromToInputField(
            controllerFrom: _controllerFromWomen,
            controllerTo: _controllerToWomen,
            title: t.registration.women,
            labelFrom: t.registration.age_from,
            labelTo: t.registration.age_to,
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.registration.social_media_accounts,
                style: Typographies.titleSmall,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CredInputField(
                      controller: _controllerSocial,
                      label: t.registration.paste_link_here,
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
