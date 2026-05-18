import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:brandface/presentation/home_page/brand/ui/sms_otp_page.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_state.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddPaymentMethodPage extends StatefulWidget {
  const AddPaymentMethodPage({super.key, this.editCard});

  static const String tag = '/add-payment-method';

  /// If non-null, we are editing an existing card
  final BillingCardEntity? editCard;

  @override
  State<AddPaymentMethodPage> createState() => _AddPaymentMethodPageState();
}

class _AddPaymentMethodPageState extends State<AddPaymentMethodPage> {
  final _holderCtrl = TextEditingController();
  final _numberCtrl = TextEditingController();
  final _expireCtrl = TextEditingController();
  final _ccvCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Uzbekistan local card BIN prefixes — CVV is NOT required for these.
  // Includes pure national cards (Uzcard 8600, Humo 9860) and known
  // co-badge BINs issued by Uzbekistan banks.
  static const _uzcardPrefixes = <String>[
    '8600', // Uzcard (national)
    '5614', // Uzcard co-badge Mastercard
    '5440', // some Uzbek bank Mastercard co-badge
    '5286', // some Uzbek bank Mastercard co-badge
    '5106', // some Uzbek bank Mastercard co-badge
  ];
  static const _humoPrefixes = <String>[
    '9860', // Humo (national)
    '9869', // Humo variant
  ];

  String _detectCardType(String raw) {
    final digits = raw.replaceAll(' ', '');
    if (digits.isEmpty) return 'unknown';
    if (digits.length >= 4) {
      final prefix4 = digits.substring(0, 4);
      if (_uzcardPrefixes.contains(prefix4)) return 'uzcard';
      if (_humoPrefixes.contains(prefix4)) return 'humo';
    }
    final first = digits[0];
    if (first == '4') return 'visa';
    if (first == '5') return 'mastercard';
    if (first == '3') return 'amex';
    if (first == '6') return 'discover';
    return 'unknown';
  }

  bool _isLocal(String cardType) =>
      cardType == 'uzcard' || cardType == 'humo';

  @override
  void dispose() {
    _holderCtrl.dispose();
    _numberCtrl.dispose();
    _expireCtrl.dispose();
    _ccvCtrl.dispose();
    super.dispose();
  }

  void _onConfirm() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // Navigate to SMS confirmation; on success submit to API
    context.pushNamed(SmsOtpPage.tag, extra: SmsOtpArgs(
      onSuccess: _submitCard,
    ));
  }

  void _submitCard() {
    final expParts = _expireCtrl.text.split('/');
    final month = int.tryParse(expParts.isNotEmpty ? expParts[0] : '0') ?? 0;
    final year = int.tryParse(expParts.length > 1 ? expParts[1] : '0') ?? 0;
    final fullYear = year < 100 ? 2000 + year : year;

    final cardType = _detectCardType(_numberCtrl.text);

    final lastFour = _numberCtrl.text
        .replaceAll(' ', '')
        .padLeft(4, '0')
        .substring((_numberCtrl.text.replaceAll(' ', '').length - 4)
            .clamp(0, _numberCtrl.text.replaceAll(' ', '').length));

    context.read<BillingCubit>().addCard(
          AddBillingCardParams(
            cardType: cardType,
            lastFour: lastFour,
            expiryMonth: month,
            expiryYear: fullYear,
            isDefault: true,
            gatewayToken: _generateToken(),
          ),
        );
    // Go back to My Cards after submit
    if (context.canPop()) context.pop();
  }

  String _generateToken() =>
      'tok_${DateTime.now().millisecondsSinceEpoch}_${_numberCtrl.text.replaceAll(' ', '').hashCode.abs()}';

  @override
  Widget build(BuildContext context) {
    return BlocListener<BillingCubit, BillingState>(
      listenWhen: (p, c) => p.isMutating && !c.isMutating,
      listener: (context, state) {
        if (state.failure == null && context.canPop()) {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        appBar: AppBar(
          backgroundColor: AppColors.lightBg,
          scrolledUnderElevation: 0,
          title: Text(
            widget.editCard != null ? 'Edit card' : 'Add new payment method',
            style: Typographies.titleMedium,
          ),
          centerTitle: false,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              // ── Card holder ───────────────────────────────────────────
              _FieldLabel('Card holder'),
              const SizedBox(height: 8),
              _InputField(
                controller: _holderCtrl,
                hint: 'Write card holder name',
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 20),

              // ── Card number ───────────────────────────────────────────
              _FieldLabel('Card number'),
              const SizedBox(height: 8),
              _InputField(
                controller: _numberCtrl,
                hint: 'Write card number',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _CardNumberFormatter(),
                ],
                validator: (v) {
                  final digits = (v ?? '').replaceAll(' ', '');
                  if (digits.length != 16) return 'Enter valid card number';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // ── Expire date + CCV ─────────────────────────────────────
              // Uzcard (8600...) / Humo (9860...) and known Uzbek co-badge
              // BINs hide CCV — local cards don't require it.
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _numberCtrl,
                builder: (context, value, _) {
                  final isLocal = _isLocal(_detectCardType(value.text));
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _FieldLabel('Expire date'),
                            const SizedBox(height: 8),
                            _InputField(
                              controller: _expireCtrl,
                              hint: 'MM/YY',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                _ExpireDateFormatter(),
                              ],
                              validator: (v) {
                                if (v == null || v.length < 5) {
                                  return 'MM/YY';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      if (!isLocal) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _FieldLabel('CCV'),
                              const SizedBox(height: 8),
                              _InputField(
                                controller: _ccvCtrl,
                                hint: 'CCV',
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(4),
                                ],
                                validator: (v) {
                                  if (v == null || v.length < 3) return 'Invalid';
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),

              const SizedBox(height: 40),

              // ── Buttons ───────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.lightBg3,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        alignment: Alignment.center,
                        child: Text('Cancel', style: Typographies.labelLarge),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: _onConfirm,
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        alignment: Alignment.center,
                        child: Text('Confirm', style: Typographies.labelLarge),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared field widgets
// ─────────────────────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: Typographies.titleSmall);
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.inputFormatters,
    this.validator,
  });
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      validator: validator,
      style: Typographies.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Typographies.bodyMedium.copyWith(color: AppColors.grey),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.red),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Text input formatters
// ─────────────────────────────────────────────────────────────────────────────

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(' ', '');
    if (digits.length > 16) return oldValue;
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _ExpireDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll('/', '');
    if (digits.length > 4) return oldValue;
    String formatted = digits;
    if (digits.length >= 3) {
      formatted = '${digits.substring(0, 2)}/${digits.substring(2)}';
    }
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

