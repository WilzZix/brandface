import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:brandface/uikit/components/inputs/from_to_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_currency.dart';
import 'choose_payment_type.dart';
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
  FillInfluencerProfileParam _param = FillInfluencerProfileParam(
    pricing: Pricing(),
  );
  final List<String> _selectedPaymentTypes = [];
  final TextEditingController _hourlyRateFrom = TextEditingController();
  final TextEditingController _hourlyRateTo = TextEditingController();
  final TextEditingController _paymentByProjectController =
      TextEditingController();

  void _updateData() {
    _param = _param.copyWith(
      pricing: Pricing(
        hourlyRateMinUsd: _hourlyRateFrom.text,
        hourlyRateMinUzs: _hourlyRateFrom.text,
        hourlyRateMaxUsd: _hourlyRateTo.text,
        hourlyRateMaxUzs: _hourlyRateTo.text,
        paymentTypes: _selectedPaymentTypes,
        campaignFee: _paymentByProjectController.text,
      ),
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
              _param = _param.copyWith(
                pricing: Pricing(
                  hourlyRateMinUsd: _hourlyRateFrom.text,
                  hourlyRateMinUzs: _hourlyRateFrom.text,
                  hourlyRateMaxUsd: _hourlyRateTo.text,
                  hourlyRateMaxUzs: _hourlyRateTo.text,
                  paymentTypes: _selectedPaymentTypes,
                  campaignFee: _paymentByProjectController.text,
                  campaignFeeCurrency: p1.name,
                ),
              );
              widget.onChanged(_param);
            },
          ),
          SizedBox(height: 16),
          FromToInputField(
            onChanged: () {
              setState(() {
                _updateData();
              });
            },
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
            onChanged: (val) {
              setState(() {
                _updateData();
              });
            },
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
          ChoosePaymentType(
            onItemSelected: (LangItemModel p1) {
              setState(() {
                _selectedPaymentTypes.add(p1.name);
              });
            },
          ),
          if (_selectedPaymentTypes.isNotEmpty)
            ListView.builder(
              itemCount: _selectedPaymentTypes.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedPaymentTypes[index],
                        style: Typographies.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPaymentTypes.removeAt(index);
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
        ],
      ),
    );
  }
}
