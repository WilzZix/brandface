import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/inputs/from_to_input_field.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/inputs/cred_input_field.dart';
import '../../../../uikit/typography/typography.dart';
import 'ambassador_experience_page_view.dart';
import 'choose_currency.dart';
import 'choose_payment_type.dart';
import 'choose_spoken_language.dart';

class BrandfacePricingPageView extends StatefulWidget {
  const BrandfacePricingPageView({
    super.key,
    required this.onChanged,
    this.initialParam,
  });

  final Function(FillInfluencerProfileParam) onChanged;
  final FillInfluencerProfileParam? initialParam;

  @override
  State<BrandfacePricingPageView> createState() =>
      _BrandfacePricingPageViewState();
}

class _BrandfacePricingPageViewState extends State<BrandfacePricingPageView>
    with AutomaticKeepAliveClientMixin<BrandfacePricingPageView> {
  late FillInfluencerProfileParam _param;
  final TextEditingController _hourlyRateFrom = TextEditingController();
  final TextEditingController _hourlyRateTo = TextEditingController();
  final TextEditingController _paymentByProjectController =
      TextEditingController();
  final List<String> _selectedPaymentTypes = [];
  String? _selectedCurrency;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialParam;
    _param = initial ?? FillInfluencerProfileParam();
    final pricing = initial?.pricing;
    _hourlyRateFrom.text = pricing?.hourlyRateMinUzs ?? pricing?.hourlyRateMinUsd ?? '';
    _hourlyRateTo.text = pricing?.hourlyRateMaxUzs ?? pricing?.hourlyRateMaxUsd ?? '';
    _paymentByProjectController.text = pricing?.campaignFee ?? '';
    _selectedCurrency = pricing?.campaignFeeCurrency;
    _selectedPaymentTypes.addAll(pricing?.paymentTypes ?? []);
    _hourlyRateFrom.addListener(_updateData);
    _hourlyRateTo.addListener(_updateData);
    _paymentByProjectController.addListener(_updateData);
  }

  @override
  void dispose() {
    _hourlyRateFrom.removeListener(_updateData);
    _hourlyRateTo.removeListener(_updateData);
    _paymentByProjectController.removeListener(_updateData);
    _hourlyRateFrom.dispose();
    _hourlyRateTo.dispose();
    _paymentByProjectController.dispose();
    super.dispose();
  }

  void _updateData() {
    _param = _param.copyWith(
      pricing: Pricing(
        exclusivityAvailable: _param.pricing?.exclusivityAvailable,
        worksOnNetModel: _param.pricing?.worksOnNetModel,
        eventAppearanceFee: _param.pricing?.eventAppearanceFee,
        campaignFee: _paymentByProjectController.text.isNotEmpty
            ? _paymentByProjectController.text
            : null,
        campaignFeeCurrency: _selectedCurrency,
        hourlyRateMinUzs: _hourlyRateFrom.text.isNotEmpty ? _hourlyRateFrom.text : null,
        hourlyRateMaxUzs: _hourlyRateTo.text.isNotEmpty ? _hourlyRateTo.text : null,
        hourlyRateMinUsd: _hourlyRateFrom.text.isNotEmpty ? _hourlyRateFrom.text : null,
        hourlyRateMaxUsd: _hourlyRateTo.text.isNotEmpty ? _hourlyRateTo.text : null,
        paymentTypes: _selectedPaymentTypes.isNotEmpty ? List.from(_selectedPaymentTypes) : null,
        monthlyExclusivityFee: _param.pricing?.monthlyExclusivityFee,
      ),
    );
    widget.onChanged(_param);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(t.registration.exclusivity_availability, style: Typographies.bodyMedium),
          const SizedBox(height: 8),
          YesNoWidget(
            onItemTaped: (value) {
              _param = _param.copyWith(
                pricing: (_param.pricing ?? Pricing()).copyWith(
                  exclusivityAvailable: value,
                ),
              );
              _updateData();
            },
          ),
          const SizedBox(height: 24),
          Text(t.registration.pricing_options, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseOptionWidget(
            title: t.optional_items.willing_to_work_kpi,
            onChanged: (val) {
              _param = _param.copyWith(
                pricing: (_param.pricing ?? Pricing()).copyWith(
                  worksOnNetModel: val,
                ),
              );
              _updateData();
            },
          ),
          ChooseOptionWidget(
            title: t.optional_items.event_appearance_fee,
            onChanged: (val) {
              _param = _param.copyWith(
                pricing: (_param.pricing ?? Pricing()).copyWith(
                  eventAppearanceFee: val ? '1' : null,
                ),
              );
              _updateData();
            },
          ),
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
            initialValue: _selectedCurrency,
            onItemSelected: (LangItemModel p1) {
              _selectedCurrency = p1.name.toUpperCase();
              _updateData();
            },
          ),
          SizedBox(height: 16),
          FromToInputField(
            onChanged: () => setState(() => _updateData()),
            controllerFrom: _hourlyRateFrom,
            controllerTo: _hourlyRateTo,
            labelFrom: t.registration.min,
            labelTo: t.registration.max,
            title: t.registration.write_hourly_rate,
          ),
          SizedBox(height: 16),
          Text(t.registration.payment_types, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChoosePaymentType(
            initialSelected: _selectedPaymentTypes,
            onChanged: (selected) {
              setState(() {
                _selectedPaymentTypes
                  ..clear()
                  ..addAll(selected);
              });
              _updateData();
            },
          ),
        ],
      ),
    );
  }
}
