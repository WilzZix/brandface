import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';

import '../../../core/i18n/strings.g.dart';
import '../../typography/typography.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 70, child: Divider(color: AppColors.borderColor)),
        SizedBox(width: 18),
        Text(t.login.login_methods, style: Typographies.titleSmall),
        SizedBox(width: 18),
        SizedBox(width: 70, child: Divider(color: AppColors.borderColor)),
      ],
    );
  }
}
