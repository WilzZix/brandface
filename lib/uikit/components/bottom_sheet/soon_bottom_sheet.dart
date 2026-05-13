import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/i18n/strings.g.dart';
import '../../tokens/colors.dart';
import '../../typography/typography.dart';
import '../buttons/buttons.dart';

class SoonBottomSheet {
  static Future<void> open({
    required BuildContext context,
    required String providerName,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      builder: (sheetContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: .5, sigmaY: .5),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 108,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.mutedBlack,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Icon(Icons.hourglass_top_rounded, size: 56),
                const SizedBox(height: 16),
                Text(
                  t.login.soon_title,
                  textAlign: TextAlign.center,
                  style: Typographies.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  t.login.soon_message(provider: providerName),
                  textAlign: TextAlign.center,
                  style: Typographies.bodySmall,
                ),
                const SizedBox(height: 24),
                AppButtons.primary(
                  title: t.common.ok,
                  onTap: () => Navigator.pop(sheetContext),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        );
      },
    );
  }
}
