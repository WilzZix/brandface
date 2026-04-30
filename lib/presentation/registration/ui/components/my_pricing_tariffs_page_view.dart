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
import 'profile_section_readonly_banner.dart';

class MyPricingTariffsPageView extends StatefulWidget {
  const MyPricingTariffsPageView({
    super.key,
    required this.initialParam,
    required this.onChanged,
    this.readOnly = false,
  });

  final FillInfluencerProfileParam initialParam;
  final Function(FillInfluencerProfileParam) onChanged;
  final bool readOnly;

  @override
  State<MyPricingTariffsPageView> createState() =>
      _MyPricingTariffsPageViewState();
}

class _MyPricingTariffsPageViewState extends State<MyPricingTariffsPageView>
    with AutomaticKeepAliveClientMixin<MyPricingTariffsPageView> {
  late FillInfluencerProfileParam _param;
  late List<String> _selectedPaymentTypes;
  String? _selectedCurrency;
  final TextEditingController _hourlyRateFrom = TextEditingController();
  final TextEditingController _hourlyRateTo = TextEditingController();
  final TextEditingController _paymentByProjectController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    final pricing = widget.initialParam.pricing;
    _param = widget.initialParam.copyWith(
      pricing: pricing ?? Pricing(),
    );
    _selectedPaymentTypes = List<String>.from(pricing?.paymentTypes ?? []);
    _selectedCurrency = pricing?.campaignFeeCurrency;
    _hourlyRateFrom.text = pricing?.hourlyRateMinUsd ?? '';
    _hourlyRateTo.text = pricing?.hourlyRateMaxUsd ?? '';
    _paymentByProjectController.text = pricing?.campaignFee ?? '';
  }

  void _updateData() {
    final current = _param.pricing ?? Pricing();
    _param = _param.copyWith(
      pricing: current.copyWith(
        hourlyRateMinUsd: _hourlyRateFrom.text,
        hourlyRateMinUzs: _hourlyRateFrom.text,
        hourlyRateMaxUsd: _hourlyRateTo.text,
        hourlyRateMaxUzs: _hourlyRateTo.text,
        paymentTypes: _selectedPaymentTypes,
        campaignFee: _paymentByProjectController.text,
        campaignFeeCurrency: _selectedCurrency,
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
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.readOnly) const ProfileSectionReadOnlyBanner(),
          IgnorePointer(
            ignoring: widget.readOnly,
            child: Opacity(
              opacity: widget.readOnly ? 0.6 : 1.0,
              child: _buildForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(t.registration.currency, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseCurrency(
            initialValue: _selectedCurrency,
            onItemSelected: (LangItemModel p1) {
              _selectedCurrency = p1.name;
              _updateData();
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
              if (_selectedPaymentTypes.contains(p1.name)) return;
              setState(() {
                _selectedPaymentTypes.add(p1.name);
              });
              _updateData();
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
                          _updateData();
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
    );
  }
}
