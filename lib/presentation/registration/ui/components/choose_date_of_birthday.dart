import 'package:brandface/core/i18n/strings.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';

class ChooseDateOfBirthday extends StatefulWidget {
  const ChooseDateOfBirthday({
    super.key,
    required this.title,
    required this.label,
    required this.onItemSelected,
    required this.iconPath,
    this.initialValue,
  });

  final String title;
  final String label;
  final String iconPath;
  final DateTime? initialValue;
  final Function(DateTime) onItemSelected;

  @override
  State<ChooseDateOfBirthday> createState() => _ChooseDateOfBirthdayState();
}

class _ChooseDateOfBirthdayState extends State<ChooseDateOfBirthday> {
  String? _selectedLang;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _selectedDate = widget.initialValue;
      _selectedLang = DateFormat('dd.MM.yyyy').format(widget.initialValue!);
    } else {
      _selectedLang = widget.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Typographies.titleSmall),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            await BrandfaceBottomSheet.openBottomSheet<String>(
              context: context,
              builder: (context, bottomState) {
                return SizedBox(
                  height: 92,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    // Faqat sana (kun, oy, yil)
                    initialDateTime: DateTime(2008, 12, 11),
                    onDateTimeChanged: (DateTime newDate) {
                      _selectedDate = newDate;
                      _selectedLang = DateFormat('dd.MM.yyyy').format(newDate);
                    },
                    use24hFormat: true,
                    maximumDate: DateTime(2008, 12, 11),
                    minimumYear: 1926,
                  ),
                );
              },
              header: t.choose.select_date_of_birth,
              onConfirm: () {
                widget.onItemSelected(_selectedDate ?? DateTime.now());
                setState(() {});
                context.pop();
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightBg2,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedLang ?? '', style: Typographies.labelLarge),
                SvgPicture.asset(widget.iconPath),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
