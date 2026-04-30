import 'package:flutter/material.dart';

import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';

class ProfileSectionReadOnlyBanner extends StatelessWidget {
  const ProfileSectionReadOnlyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBg2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_outline, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Bu bo\'limni faqat profile approved bo\'lgandan keyin tahrir qila olasiz.',
              style: Typographies.bodySmall.copyWith(color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
