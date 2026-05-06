import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/ui/components/ambassador_experience_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/inputs/cred_input_field.dart';
import '../../../../uikit/components/inputs/from_to_input_field.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_currency.dart';
import 'choose_payment_type.dart';
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
  FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final TextEditingController _hourlyRateFrom = TextEditingController();
  final TextEditingController _hourlyRateTo = TextEditingController();
  final TextEditingController _paymentByProjectController =
      TextEditingController();
  final List<String> _selectedPaymentTypes = [];
  String? _selectedCurrency;

  @override
  void initState() {
    super.initState();
    _hourlyRateFrom.addListener(_onTextChanged);
    _hourlyRateTo.addListener(_onTextChanged);
    _paymentByProjectController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _hourlyRateFrom.removeListener(_onTextChanged);
    _hourlyRateTo.removeListener(_onTextChanged);
    _paymentByProjectController.removeListener(_onTextChanged);
    _hourlyRateFrom.dispose();
    _hourlyRateTo.dispose();
    _paymentByProjectController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    _updateData();
  }

  void _updateData() {
    _param = _param.copyWith(
      pricing: Pricing(
        availableForLongTerm: _param.pricing?.availableForLongTerm,
        kpiBasedModel: _param.pricing?.kpiBasedModel,
        availableForOfflineEvents: _param.pricing?.availableForOfflineEvents,
        campaignFee: _paymentByProjectController.text.isNotEmpty
            ? _paymentByProjectController.text
            : null,
        campaignFeeCurrency: _selectedCurrency,
        hourlyRateMinUzs: _hourlyRateFrom.text.isNotEmpty ? _hourlyRateFrom.text : null,
        hourlyRateMaxUzs: _hourlyRateTo.text.isNotEmpty ? _hourlyRateTo.text : null,
        hourlyRateMinUsd: _hourlyRateFrom.text.isNotEmpty ? _hourlyRateFrom.text : null,
        hourlyRateMaxUsd: _hourlyRateTo.text.isNotEmpty ? _hourlyRateTo.text : null,
        paymentTypes: _selectedPaymentTypes.isNotEmpty ? List.from(_selectedPaymentTypes) : null,
      ),
    );
    widget.onChanged(_param);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.registration.available_for_long_term_contract,
            style: Typographies.titleMedium,
          ),
          const SizedBox(height: 8),
          YesNoWidget(
            onItemTaped: (value) {
              _param = _param.copyWith(
                pricing: (_param.pricing ?? Pricing()).copyWith(
                  availableForLongTerm: value,
                ),
              );
              _updateData();
            },
          ),
          const SizedBox(height: 16),
          Text(t.registration.kpi_based_model, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseOptionWidget(
            title: t.optional_items.willing_to_work_kpi,
            onChanged: (val) {
              _param = _param.copyWith(
                pricing: (_param.pricing ?? Pricing()).copyWith(
                  kpiBasedModel: val,
                ),
              );
              _updateData();
            },
          ),
          const SizedBox(height: 16),
          Text(t.registration.available_for_offline_events, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          YesNoWidget(
            onItemTaped: (value) {
              _param = _param.copyWith(
                pricing: (_param.pricing ?? Pricing()).copyWith(
                  availableForOfflineEvents: value,
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
            onItemSelected: (LangItemModel p1) {
              _selectedCurrency = p1.name.toUpperCase();
              _updateData();
            },
          ),
          SizedBox(height: 16),
          FromToInputField(
            onChanged: () => _updateData(),
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
