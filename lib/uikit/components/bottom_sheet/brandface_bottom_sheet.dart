import 'dart:ui';

import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';

class BrandfaceBottomSheet {
  static Future<T?> openBottomSheet<T>({
    required BuildContext context,
    required Widget content,
  }) async {
    return await showModalBottomSheet(
      context: context,

      builder: (_) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1 ,sigmaY: 1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  height: 4,
                  width: 108,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.mutedBlack,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
                  child: content,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
