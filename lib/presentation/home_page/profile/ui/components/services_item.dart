import 'package:brandface/data/models/profile/catalog/service_type_model.dart';
import 'package:flutter/material.dart';

import '../../../../../uikit/components/ui_components/badge.dart';

class ServicesItem extends StatelessWidget {
  const ServicesItem({super.key, required this.services});

  final List<ServiceTypeData>? services;

  @override
  Widget build(BuildContext context) {
    if (services != null && services!.isEmpty) {
      return SizedBox();
    } else {
      return SizedBox(
        height: 20,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: services!.length,
          itemBuilder: (context, index) {
            return AppBadge(title: services![index].name);
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(width: 8),
        ),
      );
    }
  }
}
