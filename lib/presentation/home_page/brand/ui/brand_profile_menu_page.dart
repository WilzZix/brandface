import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/home_page/brand/ui/brand_profile_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/brand_plan_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/brand_my_cards_page.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/my_cards/cards_cubit.dart';
import 'package:brandface/presentation/home_page/profile/ui/billing.dart';
import 'package:brandface/uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/services/app_language_service.dart';
import 'package:brandface/utils/services/auth_logout_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BrandProfileMenuPage extends StatefulWidget {
  const BrandProfileMenuPage({super.key});

  static const String tag = '/brand-profile-menu-page';

  @override
  State<BrandProfileMenuPage> createState() => _BrandProfileMenuPageState();
}

class _BrandProfileMenuPageState extends State<BrandProfileMenuPage> {
  final List<AppLocale> _langItems = [AppLocale.en, AppLocale.uz, AppLocale.ru];
  AppLocale _selectedLocale = AppLocale.uz;
  final AppLanguageService _appLanguageService = AppLanguageService(prefs: sl());

  @override
  void initState() {
    super.initState();
    _appLanguageService.getAppLocale().then((locale) {
      if (mounted) setState(() => _selectedLocale = locale);
    });
  }

  String _localeName(AppLocale locale) => switch (locale) {
        AppLocale.uz => "O'zbek",
        AppLocale.ru => 'Русский',
        AppLocale.en => 'English',
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.profile.profile_page, style: Typographies.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _menuItem(
              title: t.registration.profile_information,
              onTap: () => context.pushNamed(BrandProfilePage.tag),
            ),
            Divider(color: AppColors.borderColor),
            _menuItem(
              title: t.billing.plan_tab,
              onTap: () => context.pushNamed(BrandPlanPage.tag),
            ),
            Divider(color: AppColors.borderColor),
            _menuItem(
              title: t.billing.my_cards_tab,
              onTap: () => context.pushNamed(BrandMyCardsPage.tag),
            ),
            Divider(color: AppColors.borderColor),
            _menuItem(
              title: t.billing.history_tab,
              onTap: () => _openBilling(context, historyOnly: true),
            ),
            Divider(color: AppColors.borderColor),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _showLanguagePicker(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(t.profile.app_language, style: Typographies.titleMedium),
                    Row(
                      children: [
                        Text(
                          _localeName(_selectedLocale),
                          style: Typographies.bodyMedium
                              .copyWith(color: AppColors.mutedBlack),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(AppAssets.icChevronRight),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: AppColors.borderColor),
            _menuItem(
              title: t.profile.terms_and_conditions,
              onTap: () {},
            ),
            const Spacer(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                await sl<AuthLogoutService>().logout(context);
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

  Widget _menuItem({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Typographies.titleMedium),
            SvgPicture.asset(AppAssets.icChevronRight),
          ],
        ),
      ),
    );
  }

  void _openBilling(
    BuildContext context, {
    int initialTab = 0,
    bool historyOnly = false,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<BillingCubit>()..loadBilling()),
            BlocProvider(create: (_) => sl<CardsCubit>()..loadCards()),
          ],
          child: Billing(initialTab: initialTab, historyOnly: historyOnly),
        ),
      ),
    );
  }

  Future<void> _showLanguagePicker(BuildContext context) async {
    AppLocale pickedLocale = _selectedLocale;

    await BrandfaceBottomSheet.openBottomSheet<String>(
      context: context,
      header: t.profile.app_language,
      onConfirm: () {
        setState(() => _selectedLocale = pickedLocale);
        _appLanguageService.setAppLocal(pickedLocale);
        LocaleSettings.setLocale(pickedLocale);
        Navigator.of(context).pop();
      },
      builder: (bsContext, bottomState) {
        return Column(
          children: _langItems.map((item) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => bottomState(() => pickedLocale = item),
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
                      Text(_localeName(item), style: Typographies.labelLarge),
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
  }
}
