import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/inputs/from_to_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/inputs/cred_input_field.dart';
import '../../../../uikit/typography/typography.dart';
import 'ambassador_experience_page_view.dart';
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
          SizedBox(height: 16),
          Text(t.registration.exclusivity_availability, style: Typographies.bodyMedium),
          const SizedBox(height: 8),
          YesNoWidget(
            onItemTaped: (value) {
              _updateData();
            },
          ),

          const SizedBox(height: 24),
          Text(t.registration.pricing_options, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseOptionWidget(title: t.optional_items.willing_to_work_kpi),
          ChooseOptionWidget(title: t.optional_items.campaign_based_fee),
          ChooseOptionWidget(title: t.optional_items.event_appearance_fee),
          const SizedBox(height: 16),
          Text(
            t.registration.projectly_payment_starting_price,
            style: Typographies.titleMedium,
          ),
          const SizedBox(height: 8),
          CredInputField(
            controller: _paymentByProjectController,
            label: t.registration.write_starting_price,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return t.common.please_enter_text;
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Text(t.registration.currency, style: Typographies.titleMedium),
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
            labelFrom: t.registration.min,
            labelTo: t.registration.max,
            title: t.registration.write_hourly_rate,
          ),
          SizedBox(height: 16),
          Text(t.registration.payment_types, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseCurrency(onItemSelected: (LangItemModel p1) {}),
        ],
      ),
    );
  }
}
