import 'package:brandface/presentation/registration/ui/components/ambassador_experience_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/inputs/cred_input_field.dart';
import '../../../../uikit/components/inputs/from_to_input_field.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_currency.dart';
import 'choose_spoken_language.dart';

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
  final TextEditingController _hourlyRateFrom = TextEditingController();
  final TextEditingController _hourlyRateTo = TextEditingController();
  final TextEditingController _paymentByProjectController =
      TextEditingController();

  void _updateData() {
    widget.onChanged(_param);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available for long-term contract?',
            style: Typographies.titleMedium,
          ),
          const SizedBox(height: 8),
          YesNoWidget(
            onItemTaped: (value) {
              _updateData();
            },
          ),
          const SizedBox(height: 16),
          Text('KPI-based model', style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseOptionWidget(title: 'Willing to work on KPI-based model'),
          const SizedBox(height: 16),
          Text('Available for offline events', style: Typographies.titleMedium),
          const SizedBox(height: 8),
          YesNoWidget(onItemTaped: (value) {}),
          Text(
            'Projectly payment starting price',
            style: Typographies.titleMedium,
          ),
          const SizedBox(height: 8),
          CredInputField(
            controller: _paymentByProjectController,
            label: 'Write starting price',
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
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
          Text('Payment types', style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseCurrency(onItemSelected: (LangItemModel p1) {}),
        ],
      ),
    );
  }
}
