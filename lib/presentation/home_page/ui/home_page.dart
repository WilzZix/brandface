import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/presentation/home_page/ui/profile_page.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'notifications_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String tag = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  leading: GestureDetector(
                    onTap: () => context.pushNamed(ProfilePage.tag),
                    child: Padding(
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
                  ),
                  title: Text(
                    "Yo'ldoshev Usmon",
                    style: Typographies.titleMedium,
                  ),
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
                    'Offers and messages',
                    style: Typographies.titleLarge,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: HomePageContainer(
                          title: '2',
                          description: 'Active offers',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: HomePageContainer(
                          title: '23',
                          description: 'Messages',
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 32)),
                SliverToBoxAdapter(
                  child: Text(
                    'Recommended for You',
                    style: Typographies.titleLarge,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverList.separated(
                  itemCount: 12,
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
                            'Offer title here',
                            style: Typographies.titleMedium,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                            style: Typographies.bodySmall,
                          ),
                          SizedBox(height: 12),
                          Divider(color: AppColors.borderColor),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deadline',
                                    style: Typographies.titleSmall.copyWith(
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '12.10.2026',
                                    style: Typographies.bodyMedium,
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deadline',
                                    style: Typographies.titleSmall.copyWith(
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  SizedBox(
                                    height: 24,
                                    child: ListView.separated(
                                      itemCount: 2,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.lightBg2,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Text(
                                            'Cars',
                                            style: Typographies.labelMedium,
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                            return SizedBox(width: 8);
                                          },
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              SvgPicture.asset(AppAssets.icChevronRight),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 16);
                  },
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
                      Text('Menu', style: Typographies.headlineSmall),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Offers from brands',
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
                          Text(
                            'Recommended for You',
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

class HomePageContainer extends StatefulWidget {
  const HomePageContainer({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  State<HomePageContainer> createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {
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
          Text(widget.title, style: Typographies.headlineMedium),
          Text(widget.description, style: Typographies.bodyMedium),
        ],
      ),
    );
  }
}
