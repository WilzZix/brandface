import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/components/ui_components/badge.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'notifications/notifications_page.dart';

class BrandHomePage extends StatefulWidget {
  const BrandHomePage({super.key});

  static const String tag = '/brand_home_page';

  @override
  State<BrandHomePage> createState() => _BrandHomePageState();
}

class _BrandHomePageState extends State<BrandHomePage> {
  bool _isOpen = false;

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  scrolledUnderElevation: 0,
                  backgroundColor: AppColors.lightBg,
                  pinned: true,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        'assets/images/im_person_avatar_sample.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(t.brand.title, style: Typographies.titleMedium),
                  actions: [
                    GestureDetector(
                      onTap: () => context.pushNamed(NotificationsPage.tag),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightGreen,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 12,
                          ),
                          child: Stack(
                            children: [
                              SvgPicture.asset(AppAssets.icBell),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
                SliverToBoxAdapter(child: SizedBox(height: 32)),
                SliverToBoxAdapter(
                  child: Text(
                    t.brand.offers_and_applications,
                    style: Typographies.titleLarge,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _BrandStatCard(
                            title: '2',
                            description: t.common.active_offers,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _BrandStatCard(
                            title: '23',
                            description: t.brand.new_applications,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 32)),
                SliverToBoxAdapter(
                  child: Text(t.brand.ai_matching, style: Typographies.titleLarge),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: TabWidget(onChanged: (int p1) {})),
                SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverList.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  // Burchaklarni aylana qilish (screenshotdagi kabi 12-16 atrofida)
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/im_person_avatar_sample.png',
                                    ),
                                    fit: BoxFit
                                        .cover, // To'rtburchakni to'liq to'ldirishi uchun 'cover' afzal
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColors.orange,
                                  ),
                                  child: Text(
                                    t.brand.top_label,
                                    style: Typographies.labelSmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        t.brand.no_active_campaigns_yet,
                                        style: Typographies.titleMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    SvgPicture.asset(AppAssets.icVerified),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.icStar,
                                      color: AppColors.lightBg2,
                                    ),
                                    Text(
                                      '4.34',
                                      style: Typographies.bodySmall.copyWith(
                                        color: AppColors.mutedBlack,
                                      ),
                                    ),
                                    Text('·'),
                                    Text(
                                      '2.4 mln followers',
                                      style: Typographies.bodySmall.copyWith(
                                        color: AppColors.mutedBlack,
                                      ),
                                    ),
                                    Text('·'),
                                    Text(
                                      '3 years exp.',
                                      style: Typographies.bodySmall.copyWith(
                                        color: AppColors.mutedBlack,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    AppBadge(title: 'Business'),
                                    AppBadge(title: 'Finance'),
                                    AppBadge(title: 'Trading'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16 + MediaQuery.of(context).padding.bottom,
                  ),
                ),
              ],
            ),
          ),
          IgnorePointer(
            ignoring: !_isOpen,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _isOpen ? 1.0 : 0.0,
              child: Container(
                color: AppColors.lightBg,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 56 + MediaQuery.of(context).padding.top),
                      Center(child: SvgPicture.asset(AppAssets.icLogo)),
                      SizedBox(height: 24),
                      Center(child: SvgPicture.asset(AppAssets.icOnBoarding)),
                      SizedBox(height: 24),
                      Text(t.common.menu, style: Typographies.headlineSmall),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            t.brand.collaboration_offers,
                            style: Typographies.titleMedium,
                          ),
                          SvgPicture.asset(AppAssets.icChevronRight),
                        ],
                      ),
                      Divider(color: AppColors.borderColor),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.brand.brandfaces, style: Typographies.titleMedium),
                          SvgPicture.asset(AppAssets.icChevronRight),
                        ],
                      ),
                      Divider(color: AppColors.borderColor),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.brand.ambassadors, style: Typographies.titleMedium),
                          SvgPicture.asset(AppAssets.icChevronRight),
                        ],
                      ),
                      Divider(color: AppColors.borderColor),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.brand.influencers, style: Typographies.titleMedium),
                          SvgPicture.asset(AppAssets.icChevronRight),
                        ],
                      ),
                      Divider(color: AppColors.borderColor),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.brand.favourites, style: Typographies.titleMedium),
                          SvgPicture.asset(AppAssets.icChevronRight),
                        ],
                      ),
                      Divider(color: AppColors.borderColor),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.brand.ai_matching, style: Typographies.titleMedium),
                          SvgPicture.asset(AppAssets.icChevronRight),
                        ],
                      ),
                      Divider(color: AppColors.borderColor),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.brand.analytics, style: Typographies.titleMedium),
                          SvgPicture.asset(AppAssets.icChevronRight),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: _toggleMenu,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, anim) => RotationTransition(
            turns: anim,
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: AppColors.black,
              shape: BoxShape.circle,
            ),
            child: _isOpen
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SvgPicture.asset(AppAssets.icClose),
                  )
                : Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SvgPicture.asset(AppAssets.icBars),
                  ),
          ),
        ),
      ),
    );
  }
}

class _BrandStatCard extends StatelessWidget {
  const _BrandStatCard({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Typographies.headlineMedium),
          const SizedBox(height: 8),
          Text(description, style: Typographies.bodyMedium),
        ],
      ),
    );
  }
}

class TabWidget extends StatefulWidget {
  const TabWidget({super.key, required this.onChanged});

  final Function(int) onChanged;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  int _selectedIndex = 0;

  bool _isSelected(int index) {
    return _selectedIndex == index;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              _selectedIndex = 0;
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                color: _isSelected(0) ? AppColors.primary : null,
                border: BoxBorder.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(9999),
              ),
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 6,
                vertical: 16,
              ),
              child: Center(
                child: Text(t.brand.influencer_tab, style: Typographies.labelMedium),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _selectedIndex = 1;
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                color: _isSelected(1) ? AppColors.primary : null,
                border: BoxBorder.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(9999),
              ),
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 6,
                vertical: 16,
              ),
              child: Center(
                child: Text(t.brand.ambassadors_tab, style: Typographies.labelMedium),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
