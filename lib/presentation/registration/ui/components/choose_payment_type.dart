import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/i18n/strings.g.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_spoken_language.dart';

class ChoosePaymentType extends StatefulWidget {
  const ChoosePaymentType({
    super.key,
    required this.onChanged,
    this.initialSelected = const [],
  });

  final ValueChanged<List<String>> onChanged;
  final List<String> initialSelected;

  @override
  State<ChoosePaymentType> createState() => _ChoosePaymentTypeState();
}

class _ChoosePaymentTypeState extends State<ChoosePaymentType> {
  static final List<LangItemModel> _options = [
    LangItemModel(name: 'Cash', id: 0),
    LangItemModel(name: 'Bank transfer', id: 1),
  ];

  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List<String>.from(widget.initialSelected);
  }

  @override
  void didUpdateWidget(covariant ChoosePaymentType oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_listEquals(oldWidget.initialSelected, widget.initialSelected)) {
      _selected = List<String>.from(widget.initialSelected);
    }
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  String get _label => _selected.isEmpty ? t.common.select : _selected.join(', ');

  Future<void> _openSheet() async {
    final draft = List<String>.from(_selected);

    await BrandfaceBottomSheet.openBottomSheet<void>(
      context: context,
      header: t.choose.select_payment_type,
      onConfirm: () {
        setState(() => _selected = draft);
        widget.onChanged(List<String>.from(_selected));
        Navigator.of(context).pop();
      },
      builder: (bsContext, bottomState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _options.map((item) {
            return ChooseLangItem(
              title: item.name,
              isSelected: draft.contains(item.name),
              onTap: () {
                bottomState(() {
                  if (draft.contains(item.name)) {
                    draft.remove(item.name);
                  } else {
                    draft.add(item.name);
                  }
                });
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openSheet,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.lightBg2,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _label,
                style: Typographies.labelLarge.copyWith(
                  color: _selected.isEmpty ? AppColors.grey : AppColors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SvgPicture.asset(AppAssets.icArrowDown),
          ],
        ),
      ),
    );
  }
}
