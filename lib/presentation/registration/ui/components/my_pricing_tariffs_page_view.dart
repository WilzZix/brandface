import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:brandface/uikit/components/inputs/from_to_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_currency.dart';
import 'choose_spoken_language.dart';

class MyPricingTariffsPageView extends StatefulWidget {
  const MyPricingTariffsPageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<MyPricingTariffsPageView> createState() =>
      _MyPricingTariffsPageViewState();
}

class _MyPricingTariffsPageViewState extends State<MyPricingTariffsPageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final List<LangItemModel> _selectedNichesItems = [];
  final TextEditingController _hourlyRateFrom = TextEditingController();
  final TextEditingController _hourlyRateTo = TextEditingController();
  final TextEditingController _paymentByProjectController =
      TextEditingController();

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
          Text('Currency', style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseCurrency(
            onItemSelected: (LangItemModel p1) {
              _updateData();
            },
          ),
          SizedBox(height: 16),
          FromToInputField(
            controllerFrom: _hourlyRateFrom,
            controllerTo: _hourlyRateTo,
            labelFrom: 'Min',
            labelTo: 'Max',
            title: 'Write your hourly rate',
          ),
          SizedBox(height: 16),
          Text(
            'Projectly payment starting price',
            style: Typographies.titleMedium,
          ),
          const SizedBox(height: 8),
          CredInputField(
            controller: _paymentByProjectController,
            label: 'Write starting price',
          ),
          SizedBox(height: 16),
          Text('Payment types', style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseCurrency(onItemSelected: (LangItemModel p1) {}),
        ],
      ),
    );
  }
}
