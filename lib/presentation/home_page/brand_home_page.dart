import 'package:brandface/core/constants/app_assets.dart';
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
                  title: Text('Brand', style: Typographies.titleMedium),
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
                    'My campaigns',
                    style: Typographies.titleLarge,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: _BrandStatCard(
                          title: '0',
                          description: 'Active campaigns',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _BrandStatCard(
                          title: '0',
                          description: 'Influencers hired',
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 32)),
                SliverToBoxAdapter(
                  child: Text(
                    'Recent activity',
                    style: Typographies.titleLarge,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverList.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightBg3,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Campaign title here',
                            style: Typographies.titleMedium,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'No active campaigns yet',
                            style: Typographies.bodySmall.copyWith(
                              color: AppColors.grey,
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
                      SizedBox(
                        height: 56 + MediaQuery.of(context).padding.top,
                      ),
                      Center(child: SvgPicture.asset(AppAssets.icLogo)),
                      SizedBox(height: 24),
                      Text('Menu', style: Typographies.headlineSmall),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Campaigns', style: Typographies.titleMedium),
                          SvgPicture.asset(AppAssets.icChevronRight),
                        ],
                      ),
                      Divider(color: AppColors.borderColor),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Find influencers', style: Typographies.titleMedium),
                          SvgPicture.asset(AppAssets.icChevronRight),
                        ],
                      ),
                      Divider(color: AppColors.borderColor),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Messages', style: Typographies.titleMedium),
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
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Typographies.headlineMedium),
          Text(description, style: Typographies.bodyMedium),
        ],
      ),
    );
  }
}
