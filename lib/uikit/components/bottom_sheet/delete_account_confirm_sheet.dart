import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/i18n/strings.g.dart';
import '../../tokens/colors.dart';
import '../../typography/typography.dart';
import '../inputs/cred_input_field.dart';
import 'brandface_bottom_sheet.dart';

/// "Type your name to confirm" delete sheet — foydalanuvchi ehtiyotsizlikdan
/// hisobni o'chirib qo'ymasligi uchun bir qadam tasdiq.
class DeleteAccountConfirmSheet {
  const DeleteAccountConfirmSheet._();

  static Future<void> open({
    required BuildContext context,
    required String expectedName,
    required VoidCallback onConfirmed,
  }) {
    final expected = expectedName.trim();

    return BrandfaceBottomSheet.openBottomSheet<void>(
      context: context,
      header: t.profile.delete_account,
      // Tasdiqlash tugma body ichida o'zining qizil "Hisobni o'chirish" sifatida
      // — sheet'ning default yashil "Tasdiqlash" tugmasi kerak emas.
      showConfirmButton: false,
      onConfirm: () {},
      builder: (sheetCtx, setSheetState) {
        return _DeleteConfirmBody(
          expected: expected,
          onConfirmed: () {
            context.pop();
            onConfirmed();
          },
        );
      },
    );
  }
}

class _DeleteConfirmBody extends StatefulWidget {
  const _DeleteConfirmBody({
    required this.expected,
    required this.onConfirmed,
  });

  final String expected;
  final VoidCallback onConfirmed;

  @override
  State<_DeleteConfirmBody> createState() => _DeleteConfirmBodyState();
}

class _DeleteConfirmBodyState extends State<_DeleteConfirmBody> {
  final _controller = TextEditingController();
  bool _showMismatch = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _matches() {
    final expected = widget.expected;
    if (expected.isEmpty) return false;
    return _controller.text.trim().toLowerCase() == expected.toLowerCase();
  }

  void _handleConfirm() {
    if (_matches()) {
      widget.onConfirmed();
    } else if (!_showMismatch) {
      setState(() => _showMismatch = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.profile.delete_account_confirm,
            style: Typographies.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            t.profile.delete_account_type_name(name: widget.expected),
            style: Typographies.labelLarge,
          ),
          const SizedBox(height: 8),
          CredInputField(
            controller: _controller,
            label: t.profile.delete_account_type_name_hint,
            validator: (_) => null,
            onChanged: (_) {
              if (_showMismatch) {
                setState(() => _showMismatch = false);
              }
            },
          ),
          if (_showMismatch) ...[
            const SizedBox(height: 8),
            Text(
              t.profile.delete_account_name_mismatch,
              style: Typographies.labelLarge.copyWith(color: AppColors.red),
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.red,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _handleConfirm,
              child: Text(
                t.profile.delete_account,
                style: Typographies.labelLarge.copyWith(color: AppColors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
