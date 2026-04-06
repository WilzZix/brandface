import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';

class AmbassadorContractPageView extends StatefulWidget {
  const AmbassadorContractPageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<AmbassadorContractPageView> createState() =>
      _AmbassadorContractPageViewState();
}

class _AmbassadorContractPageViewState
    extends State<AmbassadorContractPageView> {
  final FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  bool _longTermContract = false;
  bool _kpiBasedModel = false;
  bool _offlineEvents = false;

  void _updateData() {
    widget.onChanged(_param);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ToggleOption(
            title: 'Available for long-term contract?',
            value: _longTermContract,
            onChanged: (val) {
              setState(() => _longTermContract = val);
              _updateData();
            },
          ),
          const SizedBox(height: 16),
          _ToggleOption(
            title: 'KPI-based model',
            value: _kpiBasedModel,
            onChanged: (val) {
              setState(() => _kpiBasedModel = val);
              _updateData();
            },
          ),
          const SizedBox(height: 16),
          _ToggleOption(
            title: 'Available for offline events?',
            value: _offlineEvents,
            onChanged: (val) {
              setState(() => _offlineEvents = val);
              _updateData();
            },
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightBg2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(title, style: Typographies.bodyMedium),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.black,
          ),
        ],
      ),
    );
  }
}
