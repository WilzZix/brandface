import 'package:brandface/presentation/home_page/profile/ui/profile_information_page.dart';
import 'package:brandface/presentation/home_page/profile/ui/calendar_page.dart';
import 'package:brandface/presentation/home_page/profile/ui/portfolio_page.dart';
import 'package:brandface/presentation/home_page/profile/ui/reviews.dart';
import 'package:brandface/presentation/home_page/profile/ui/stats_page.dart';
import 'package:brandface/presentation/home_page/profile/ui/top_profile_page.dart';
import 'package:brandface/presentation/login/ui/login_page.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/di/app_di.dart';
import '../../../../../core/i18n/strings.g.dart';
import '../../../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../../../utils/services/app_language_service.dart';
import 'billing.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const String tag = '/profile_page';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<AppLocale> langItems = [AppLocale.ru, AppLocale.uz];
  AppLocale _selectedLangId = AppLocale.ru;
  final AppLanguageService _appLanguageService = AppLanguageService(
    prefs: sl(),
  );

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.profile.profile_page, style: Typographies.titleLarge),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            GestureDetector(
              onTap: () => context.pushNamed(ProfileInformationPage.tag),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.registration.profile_information,
                    style: Typographies.titleMedium,
                  ),
                  Spacer(),
                  SvgPicture.asset(AppAssets.icChevronRight),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.pushNamed(StatsPage.tag),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(t.profile.stats, style: Typographies.titleMedium),
                  Spacer(),
                  SvgPicture.asset(AppAssets.icChevronRight),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            GestureDetector(
              onTap: () => context.pushNamed(Reviews.tag),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(t.profile.reviews, style: Typographies.titleMedium),
                  Spacer(),
                  SvgPicture.asset(AppAssets.icChevronRight),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.pushNamed(CalendarPage.tag),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(t.profile.calendar, style: Typographies.titleMedium),
                  Spacer(),
                  SvgPicture.asset(AppAssets.icChevronRight),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.pushNamed(PortfolioPage.tag),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(t.profile.portfolio, style: Typographies.titleMedium),
                  Spacer(),
                  SvgPicture.asset(AppAssets.icChevronRight),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.pushNamed(Billing.tag),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(t.profile.billing, style: Typographies.titleMedium),
                  Spacer(),
                  SvgPicture.asset(AppAssets.icChevronRight),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.pushNamed(TopProfilePage.tag),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.profile.make_profile_top,
                    style: Typographies.titleMedium,
                  ),
                  Spacer(),
                  SvgPicture.asset(AppAssets.icChevronRight),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                await BrandfaceBottomSheet.openBottomSheet<String>(
                  context: context,
                  header: t.choose.spoken_language,
                  onConfirm: () {
                    _appLanguageService.setAppLocal(_selectedLangId);
                    context.pop();
                  },
                  builder: (context, bottomState) {
                    return Column(
                      children: langItems.map((item) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            bottomState(() {
                              _selectedLangId = item;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 14,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.name,
                                    style: Typographies.labelLarge,
                                  ),
                                  if (item.countryCode ==
                                      _selectedLangId.countryCode)
                                    SvgPicture.asset(AppAssets.icCheck),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(t.profile.app_language, style: Typographies.titleMedium),
                  Spacer(),
                  SvgPicture.asset(AppAssets.icChevronRight),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.profile.terms_and_conditions,
                  style: Typographies.titleMedium,
                ),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () async {
                final prefs = sl<SharedPreferences>();
                await prefs.clear();
                if (context.mounted) {
                  context.go(LoginPage.tag);
                }
              },
              child: Text(
                t.profile.log_out,
                style: Typographies.titleMedium.copyWith(color: AppColors.red),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
