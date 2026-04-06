import 'package:brandface/uikit/components/inputs/from_to_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_currency.dart';
import 'choose_spoken_language.dart';

class BrandfacePricingPageView extends StatefulWidget {
  const BrandfacePricingPageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<BrandfacePricingPageView> createState() =>
      _BrandfacePricingPageViewState();
}

class _BrandfacePricingPageViewState extends State<BrandfacePricingPageView> {
  final FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  bool _exclusivityAvailability = false;
  final TextEditingController _priceFrom = TextEditingController();
  final TextEditingController _priceTo = TextEditingController();

  void _updateData() {
    widget.onChanged(_param);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const SizedBox(height: 24),
          Text('Pricing options', style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseCurrency(
            onItemSelected: (LangItemModel p1) {
              _updateData();
            },
          ),
          const SizedBox(height: 16),
          FromToInputField(
            controllerFrom: _priceFrom,
            controllerTo: _priceTo,
            title: 'Price range',
            labelFrom: 'Min',
            labelTo: 'Max',
          ),
        ],
      ),
    );
  }
}
