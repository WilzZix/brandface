import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          CircleAvatar(radius: 50, backgroundColor: Colors.white),
          const SizedBox(height: 16),
          Container(width: 150, height: 20, color: Colors.white),
          const SizedBox(height: 8),
          Container(width: 100, height: 15, color: Colors.white),
        ],
      ),
    );
  }
}
