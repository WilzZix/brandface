import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';

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
  final TextEditingController _optionalExperienceController =
      TextEditingController();
  bool _exclusivityAvailability = false;

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
          ),
          const SizedBox(height: 24),
          Text('Optional experience', style: Typographies.titleMedium),
          const SizedBox(height: 8),
          CredInputField(
            controller: _optionalExperienceController,
            label: 'Describe optional experience',
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.lightBg2,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Exclusivity availability',
                    style: Typographies.bodyMedium,
                  ),
                ),
                Switch(
                  value: _exclusivityAvailability,
                  onChanged: (val) {
                    setState(() => _exclusivityAvailability = val);
                    _updateData();
                  },
                  activeThumbColor: AppColors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
