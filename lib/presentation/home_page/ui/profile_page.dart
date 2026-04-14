import 'package:brandface/presentation/login/ui/login_page.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/di/app_di.dart';
import '../../../core/i18n/strings.g.dart';
import '../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import '../../../utils/services/app_language_service.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile page', style: Typographies.titleLarge),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profile information', style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Stats', style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reviews', style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Calendar', style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Portfolio', style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Billing', style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Make the profile TOP', style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
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
                  Text('App language', style: Typographies.titleMedium),
                  Spacer(),
                  SvgPicture.asset(AppAssets.icChevronRight),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Term and conditions', style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () => context.go(LoginPage.tag),
              child: Text(
                'Log out',
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
