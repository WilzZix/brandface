import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Ilovangizning umumiy ranglariga moslash uchun grey ranglardan foydalanamiz
    const baseColor = Color(0xFFE0E0E0);
    const highlightColor = Color(0xFFF5F5F5);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header: Rasm va Ism
            Row(
              children: [
                const CircleAvatar(radius: 35, backgroundColor: Colors.white),
                const SizedBox(width: 16),
                Container(width: 120, height: 20, decoration: _boxDecoration()),
              ],
            ),
            const SizedBox(height: 24),

            // 2. General info Section
            _buildSectionTitle('General info'),
            _buildContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabelAndField(width: 100), // Full name
                  _buildLabelAndField(width: 80),  // Spoken languages
                  _buildLabelAndField(width: 140), // Date of birth
                  _buildLabelAndField(width: 60),  // Gender

                  // Contact details qismi
                  _buildLabelAndField(width: 180),
                  _buildLabelAndField(width: 150),

                  _buildLabelAndField(width: 40, isLast: true), // Bio
                ],
              ),
            ),

            // 3. Categories Section
            _buildSectionTitle('Categories'),
            _buildContainer(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildChipShimmer(70),
                  _buildChipShimmer(90),
                ],
              ),
            ),

            // 4. Services Section
            _buildSectionTitle('Services'),
            _buildContainer(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildChipShimmer(110),
                  _buildChipShimmer(80),
                ],
              ),
            ),

            // 5. Audience Section
            _buildSectionTitle('Audience and followers'),
            _buildContainer(height: 60, child: const SizedBox.expand()),
          ],
        ),
      ),
    );
  }

  // --- Yordamchi metodlar (Kod takrorlanishini kamaytirish uchun) ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Container(
        width: 100,
        height: 14,
        decoration: _boxDecoration(),
      ),
    );
  }

  Widget _buildContainer({required Widget child, double? height}) {
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Skrinshotdagi yumaloq burchaklar
      ),
      child: child,
    );
  }

  Widget _buildLabelAndField({required double width, bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 60, height: 10, decoration: _boxDecoration()), // Label
          const SizedBox(height: 8),
          Container(width: width, height: 14, decoration: _boxDecoration()), // Value
        ],
      ),
    );
  }

  Widget _buildChipShimmer(double width) {
    return Container(
      width: width,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
    );
  }
}