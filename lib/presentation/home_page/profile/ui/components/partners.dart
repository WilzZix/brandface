import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class Partners extends StatelessWidget {
  const Partners({super.key, this.partners});

  final List<String>? partners;

  @override
  Widget build(BuildContext context) {
    return Text(
      partners!.map((e) => e.toUpperCase()).join(', '),
      style: Typographies.bodyMedium,
    );
  }
}
