import 'package:brandface/data/models/profile/catalog/language_model.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({super.key, required this.langIds});

  final List<LanguageData>? langIds;

  @override
  Widget build(BuildContext context) {
    return Text(
      langIds!.map((e) => e.name).join(', '),
      style: Typographies.bodyMedium,
    );
  }
}
