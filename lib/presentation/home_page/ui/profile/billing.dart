import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/components/ui_components/title_description_widget.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Billing extends StatefulWidget {
  const Billing({super.key});

  static const String tag = '/billing';

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Billing"), centerTitle: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildTabSelector(),
          ),
          const SizedBox(height: 30),
          Expanded(child: _buildCurrentContent()),
        ],
      ),
    );
  }

  // Tanlangan indeksga qarab UI qaytaradi
  Widget _buildCurrentContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildPlanSection();
      case 1:
        return _buildMyCardsSection();
      case 2:
        return _buildBillingHistorySection();
      default:
        return _buildPlanSection();
    }
  }

  Widget _buildTabSelector() {
    return Row(
      children: [
        _tabItem("Plan", 0),
        const SizedBox(width: 8),
        _tabItem("My cards", 1),
        const SizedBox(width: 8),
        _tabItem("Billing history", 2),
      ],
    );
  }

  Widget _tabItem(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: isSelected
                ? null
                : Border.all(color: AppColors.borderColor),
          ),
          child: Text(text, style: Typographies.labelMedium),
        ),
      ),
    );
  }

  Widget _buildPlanSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current plan", style: Typographies.titleSmall),
            const SizedBox(height: 12),
            AppContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statusBadge("Minimal"),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  _priceHeader("\$0", "35 000 UZS/month", "Aug 01 2023"),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 20),
                  _checkItem("Browse offers & ambassadors (limited)"),
                  _checkItem("Create 1 Offer / month"),
                  _checkItem("Up to 3 Invites / month"),
                  const SizedBox(height: 20),
                  _payAsYouGoBanner(),
                  const SizedBox(height: 16),
                  _priceRow("Contact unlock:", "\$3 per lead"),
                  _priceRow("Profile / Offer boost:", "\$10 / 7 days"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 2. My Cards Section ---
  Widget _buildMyCardsSection() {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          if (index == 2) {
            // Bu listning oxirgi elementi
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.icAdd),
                    SizedBox(width: 8),
                    Text('Add new card', style: Typographies.labelLarge),
                  ],
                ),
              ),
            );
          }
          return AppContainer(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Visa ending in 7687',
                          style: Typographies.titleMedium,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Expiry 08/2027',
                          style: Typographies.titleSmall.copyWith(
                            color: AppColors.mutedBlack,
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(AppAssets.icVisa),
                  ],
                ),
                SizedBox(height: 12),
                Divider(color: AppColors.borderColor),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Delete',
                      style: Typographies.titleSmall.copyWith(
                        color: AppColors.red,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text('Edit', style: Typographies.titleSmall),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: 8),
        itemCount: 3,
      ),
    );
  }

  // --- 3. Billing History Section ---
  Widget _buildBillingHistorySection() {
    return ListView.separated(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        return AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Invoice #1756391', style: Typographies.titleMedium),
              SizedBox(height: 12),
              Divider(color: AppColors.borderColor),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleDescriptionWidget(
                    title: 'Issue date',
                    descriptionItem: Text(
                      '8 Mar 2025',
                      style: Typographies.bodyMedium,
                    ),
                  ),
                  TitleDescriptionWidget(
                    title: 'Issue date',
                    descriptionItem: Text(
                      '8 Mar 2025',
                      style: Typographies.bodyMedium,
                    ),
                  ),
                  TitleDescriptionWidget(
                    title: 'Receipt',
                    descriptionItem: Row(
                      children: [
                        SvgPicture.asset(AppAssets.icDownload),
                        SizedBox(width: 4),
                        Text(
                          'Download',
                          style: Typographies.labelMedium.copyWith(
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 8),
      itemCount: 12,
    );
  }

  // Yordamchi vidjetlar
  Widget _statusBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: Typographies.bodySmall.copyWith(color: AppColors.white),
      ),
    );
  }

  Widget _priceHeader(String price, String sub, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(price, style: Typographies.titleLarge),
            Text(sub, style: Typographies.bodySmall),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Start date", style: Typographies.bodySmall),
            Text(date, style: Typographies.titleMedium),
          ],
        ),
      ],
    );
  }

  Widget _checkItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppColors.primaryDark,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: Typographies.bodyMedium)),
        ],
      ),
    );
  }

  Widget _payAsYouGoBanner() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(200),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "Pay-as-you-go add-ons (transparent)",
        style: Typographies.titleSmall,
      ),
    );
  }

  Widget _priceRow(String label, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(label, style: Typographies.bodyMedium),
          const SizedBox(width: 4),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
