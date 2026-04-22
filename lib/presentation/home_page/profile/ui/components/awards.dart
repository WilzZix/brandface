import 'package:flutter/material.dart';

class Awards extends StatelessWidget {
  const Awards({super.key, this.awards});

  final List<String>? awards;

  @override
  Widget build(BuildContext context) {
    if (awards == null || awards!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sarlavha
        const Text(
          'Awards',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8), // Sarlavha va ro'yxat orasidagi masofa
        // Ro'yxat elementlari
        ...awards!.map(
          (award) => Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            // Elementlar orasidagi masofa
            child: Text(
              award,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
