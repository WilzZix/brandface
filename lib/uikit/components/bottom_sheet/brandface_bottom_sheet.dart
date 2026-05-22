import 'dart:ui';

import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class BrandfaceBottomSheet {
  static Future<T?> openBottomSheet<T>({
    required BuildContext context,
    required String header,
    required Widget Function(BuildContext context, StateSetter setInternalState)
    builder,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, bottomState) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: .5, sigmaY: .5),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        height: 4,
                        width: 108,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.mutedBlack,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(header, style: Typographies.titleMedium),
                    ),
                    SizedBox(height: 16),
                    Flexible(
                      child: SingleChildScrollView(
                        child: builder(context, bottomState),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AppButtons.primary(
                        title: t.common.confirm,
                        onTap: onConfirm,
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        if (onCancel != null) {
                          onCancel();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsetsGeometry.only(bottom: 24),
                        child: Center(
                          child: Text(t.common.cancel, style: Typographies.labelLarge),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Future openFailureBottomSheet({
    required BuildContext context,
    required String message,
  }) async {
    return await showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: .5, sigmaY: .5),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 96, width: 96, child: Icon(Icons.error)),
                SizedBox(height: 24),
                Text(message, style: Typographies.titleMedium),
                SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        );
      },
    );
  }
}
