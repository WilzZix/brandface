import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/typography/typography.dart';

class AmbassadorExperiencePageView extends StatefulWidget {
  const AmbassadorExperiencePageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<AmbassadorExperiencePageView> createState() =>
      _AmbassadorExperiencePageViewState();
}

class _AmbassadorExperiencePageViewState
    extends State<AmbassadorExperiencePageView> {
  final TextEditingController _promoExperienceController =
      TextEditingController();
  final TextEditingController _optionalExperienceController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Experience in referral/promo code campaigns',
            style: Typographies.titleMedium,
          ),
          const SizedBox(height: 8),
          CredInputField(
            controller: _promoExperienceController,
            label: 'Describe your experience',
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
          CredInputField(
            controller: _optionalExperienceController,
            label: 'Describe optional experience',
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
