import 'package:brandface/core/i18n/strings.g.dart';
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

class _MyPricingTariffsPageViewState extends State<MyPricingTariffsPageView>
    with AutomaticKeepAliveClientMixin<MyPricingTariffsPageView> {
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Text(t.registration.payment_types, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseCurrency(onItemSelected: (LangItemModel p1) {}),
        ],
      ),
    );
  }
}
