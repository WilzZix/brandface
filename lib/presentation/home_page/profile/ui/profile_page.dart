import 'package:brandface/presentation/home_page/profile/ui/profile_information_page.dart';
import 'package:brandface/presentation/home_page/profile/ui/reviews.dart';
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
  final List<AppLocale> _langItems = [AppLocale.uz, AppLocale.ru];
  AppLocale _selectedLangId = AppLocale.uz;
  final AppLanguageService _appLanguageService = AppLanguageService(prefs: sl());

  @override
  void initState() {
    super.initState();
    _appLanguageService.getAppLocale().then((locale) {
      if (mounted) setState(() => _selectedLangId = locale);
    });
  }

  String _localeName(AppLocale locale) =>
      locale == AppLocale.uz ? "O'zbek" : 'Русский';

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
                  Text(t.registration.profile_information, style: Typographies.titleMedium),
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
                Text(t.profile.stats, style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(t.profile.calendar, style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(t.profile.portfolio, style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(t.profile.make_profile_top, style: Typographies.titleMedium),
                Spacer(),
                SvgPicture.asset(AppAssets.icChevronRight),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: AppColors.borderColor),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final tempLocale = _selectedLangId;
                AppLocale pickedLocale = tempLocale;

                await BrandfaceBottomSheet.openBottomSheet<String>(
                  context: context,
                  header: t.profile.app_language,
                  onConfirm: () {
                    setState(() => _selectedLangId = pickedLocale);
                    _appLanguageService.setAppLocal(pickedLocale);
                    LocaleSettings.setLocale(pickedLocale);
                    Navigator.of(context).pop();
                  },
                  builder: (bsContext, bottomState) {
                    return Column(
                      children: _langItems.map((item) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            bottomState(() => pickedLocale = item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 14,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _localeName(item),
                                    style: Typographies.labelLarge,
                                  ),
                                  if (item == pickedLocale)
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
                  const Spacer(),
                  Text(
                    _localeName(_selectedLangId),
                    style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
                  ),
                  const SizedBox(width: 8),
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
                Text(t.profile.terms_and_conditions, style: Typographies.titleMedium),
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
