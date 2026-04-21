import 'package:brandface/data/models/profile/catalog/category_model.dart';

import 'package:flutter/material.dart';

import '../../../../../uikit/components/ui_components/badge.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.categories});

  final List<CategoryData>? categories;

  @override
  Widget build(BuildContext context) {
    if (categories != null && categories!.isEmpty) {
      return SizedBox();
    } else {
      return SizedBox(
        height: 20,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories!.length,
          itemBuilder: (context, index) {
            return AppBadge(title: categories![index].name!);
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(width: 8),
        ),
      );
    }
  }
}
