import 'package:flutter/material.dart';

import '../../tokens/colors.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({super.key, required this.child});

  final Widget child;

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.lightBg3,
      ),
      child: widget.child,
    );
  }
}
