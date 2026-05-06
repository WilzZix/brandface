import 'package:flutter/material.dart';

import '../../uikit/tokens/colors.dart';

enum AppSnackBarType { info, error, success }

extension AppSnackBarX on BuildContext {
  void showAppSnackBar(
    String message, {
    AppSnackBarType type = AppSnackBarType.info,
    Duration duration = const Duration(seconds: 4),
  }) {
    final messenger = ScaffoldMessenger.of(this);
    final Color? bg = switch (type) {
      AppSnackBarType.error => AppColors.red,
      AppSnackBarType.success => AppColors.primaryDark,
      AppSnackBarType.info => null,
    };
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: bg,
          duration: duration,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
