import 'package:brandface/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_spoken_language.dart';

class _Currency {
  final int id;
  final String code;
  final String name;
  final String symbol;

  const _Currency({
    required this.id,
    required this.code,
    required this.name,
    required this.symbol,
  });
}

class ChooseCurrency extends StatefulWidget {
  const ChooseCurrency({
    super.key,
    required this.onItemSelected,
    this.initialValue,
  });

  final Function(LangItemModel) onItemSelected;
  final String? initialValue;

  @override
  State<ChooseCurrency> createState() => _ChooseCurrencyState();
}

class _ChooseCurrencyState extends State<ChooseCurrency> {
  static const List<_Currency> _currencies = [
    _Currency(id: 0, code: 'UZS', name: 'Uzbekistani som', symbol: "so'm"),
    _Currency(id: 1, code: 'USD', name: 'US Dollar', symbol: r'$'),
  ];

  _Currency? _selected;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialValue;
    if (initial != null) {
      for (final c in _currencies) {
        if (c.code.toLowerCase() == initial.toLowerCase()) {
          _selected = c;
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selected;
    return GestureDetector(
      onTap: () async {
        var pending = _selected;
        await BrandfaceBottomSheet.openBottomSheet<String>(
          context: context,
          header: t.choose.select_currency,
          onConfirm: () {
            if (pending != null) {
              final picked = pending!;
              widget.onItemSelected(
                LangItemModel(name: picked.code, id: picked.id),
              );
              setState(() => _selected = picked);
            }
            context.pop();
          },
          builder: (context, bottomState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: _currencies.map((currency) {
                return _CurrencyTile(
                  currency: currency,
                  isSelected: currency.id == pending?.id,
                  onTap: () => bottomState(() => pending = currency),
                );
              }).toList(),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.lightBg2,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            if (selected != null) ...[
              _CurrencyBadge(symbol: selected.symbol),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${selected.code} · ${selected.name}',
                  style: Typographies.labelLarge.copyWith(
                    color: AppColors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ] else
              Expanded(
                child: Text(
                  t.common.select,
                  style: Typographies.labelLarge.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
            SvgPicture.asset(AppAssets.icArrowDown),
          ],
        ),
      ),
    );
  }
}

class _CurrencyTile extends StatelessWidget {
  const _CurrencyTile({
    required this.currency,
    required this.isSelected,
    required this.onTap,
  });

  final _Currency currency;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              _CurrencyBadge(symbol: currency.symbol),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currency.code,
                      style: Typographies.labelLarge.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      currency.name,
                      style: Typographies.bodySmall.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected) SvgPicture.asset(AppAssets.icCheck),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrencyBadge extends StatelessWidget {
  const _CurrencyBadge({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Text(
        symbol,
        style: Typographies.labelMedium.copyWith(color: AppColors.black),
      ),
    );
  }
}
