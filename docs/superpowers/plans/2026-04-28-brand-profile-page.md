# Brand Profile Page Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Brand role uchun 2 ta sahifa yaratish: (1) menu sahifasi (Profile page) va (2) profil ma'lumotlari sahifasini real API data bilan ko'rsatish.

**Architecture:** `BrandProfileMenuPage` (yangi) — influencer `ProfilePage` ga o'xshash menu ro'yxati. `BrandProfilePage` (qayta ishlash) — `ProfileInformationCubit` dan real data olib ko'rsatish. `BrandHomePage` avatar bosilganda `BrandProfileMenuPage` ga yo'naltiradi.

**Tech Stack:** Flutter, BLoC/Cubit, go_router, freezed

---

## File Map

| Action | File | Responsibility |
|--------|------|----------------|
| Create | `lib/presentation/home_page/brand/ui/brand_profile_menu_page.dart` | Brand profile menu (Settings list) |
| Modify | `lib/presentation/home_page/brand/ui/brand_profile_page.dart` | Profil ma'lumotlari — real data ko'rsatish |
| Modify | `lib/core/router/app_router.dart` | `BrandProfileMenuPage` uchun route qo'shish |
| Modify | `lib/presentation/home_page/brand/ui/brand_home_page.dart` | Avatar navigatsiyasini yangilash |

---

### Task 1: `BrandProfileMenuPage` yaratish

**Files:**
- Create: `lib/presentation/home_page/brand/ui/brand_profile_menu_page.dart`

- [ ] **Step 1: Faylni yaratish**

```dart
import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/home_page/brand/ui/brand_profile_page.dart';
import 'package:brandface/presentation/home_page/profile/bloc/billing/billing_cubit.dart';
import 'package:brandface/presentation/home_page/profile/ui/billing.dart';
import 'package:brandface/presentation/login/ui/login_page.dart';
import 'package:brandface/uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/services/app_language_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrandProfileMenuPage extends StatefulWidget {
  const BrandProfileMenuPage({super.key});

  static const String tag = '/brand-profile-menu-page';

  @override
  State<BrandProfileMenuPage> createState() => _BrandProfileMenuPageState();
}

class _BrandProfileMenuPageState extends State<BrandProfileMenuPage> {
  final List<AppLocale> _langItems = [AppLocale.uz, AppLocale.ru];
  AppLocale _selectedLocale = AppLocale.uz;
  final AppLanguageService _appLanguageService = AppLanguageService(prefs: sl());

  @override
  void initState() {
    super.initState();
    _appLanguageService.getAppLocale().then((locale) {
      if (mounted) setState(() => _selectedLocale = locale);
    });
  }

  String _localeName(AppLocale locale) =>
      locale == AppLocale.uz ? "O'zbek" : 'Русский';

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
            const Divider(color: AppColors.borderColor),
            _menuItem(
              title: t.profile.billing,
              onTap: () => _openBilling(context, initialTab: 0),
            ),
            const Divider(color: AppColors.borderColor),
            _menuItem(
              title: t.billing.my_cards_tab,
              onTap: () => _openBilling(context, initialTab: 1),
            ),
            const Divider(color: AppColors.borderColor),
            _menuItem(
              title: t.billing.history_tab,
              onTap: () => _openBilling(context, initialTab: 2),
            ),
            const Divider(color: AppColors.borderColor),
            GestureDetector(
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
            const Divider(color: AppColors.borderColor),
            _menuItem(
              title: t.profile.terms_and_conditions,
              onTap: () {},
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                final prefs = sl<SharedPreferences>();
                await prefs.clear();
                if (context.mounted) context.go(LoginPage.tag);
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

  void _openBilling(BuildContext context, {required int initialTab}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<BillingCubit>(
          create: (_) => sl<BillingCubit>()..loadBilling(),
          child: Billing(initialTab: initialTab),
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
```

- [ ] **Step 2: Commit**

```bash
git add lib/presentation/home_page/brand/ui/brand_profile_menu_page.dart
git commit -m "feat: add BrandProfileMenuPage"
```

---

### Task 2: `Billing` ga `initialTab` parametri qo'shish

`BrandProfileMenuPage` Plan/My cards/Billing history ni alohida tabda ochish uchun `Billing` widgetiga `initialTab` parametri kerak.

**Files:**
- Modify: `lib/presentation/home_page/profile/ui/billing.dart`

- [ ] **Step 1: `Billing` ga `initialTab` qo'shish**

`Billing` class definition va `_BillingState` ni quyidagicha o'zgartirish:

```dart
class Billing extends StatefulWidget {
  const Billing({super.key, this.initialTab = 0});

  static const String tag = '/billing';

  final int initialTab;

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
  }
  // qolgan kod o'zgarishsiz qoladi
```

- [ ] **Step 2: Commit**

```bash
git add lib/presentation/home_page/profile/ui/billing.dart
git commit -m "feat: add initialTab param to Billing widget"
```

---

### Task 3: `BrandProfilePage` ni real data bilan qayta ishlash

Hozir sahifa barcha qiymatlarni `'—'` ko'rsatadi. `ProfileInformationCubit` allaqachon routerda berilgan — faqat `BlocBuilder` bilan ulash kerak. App language va logout bu sahifadan olib tashlanadi.

**Files:**
- Modify: `lib/presentation/home_page/brand/ui/brand_profile_page.dart`

- [ ] **Step 1: Faylni to'liq qayta yozish**

```dart
import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/profile/influencer_profile_information_entity.dart';
import 'package:brandface/domain/entities/registration/registration_entity.dart';
import 'package:brandface/presentation/home_page/profile/bloc/profile_information/profile_information_cubit.dart';
import 'package:brandface/presentation/registration/ui/fill_profile_information_page.dart';
import 'package:brandface/uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/components/ui_components/badge.dart';
import 'package:brandface/uikit/components/ui_components/title_description_widget.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BrandProfilePage extends StatelessWidget {
  const BrandProfilePage({super.key});

  static const String tag = '/brand-profile-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.brand.brand_profile),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              final profileService = sl<ProfileService>();
              context.pushNamed(
                FillProfileInformationPage.tag,
                extra: RegistrationEntity(
                  role: profileService.getRole() ?? 'brand',
                  profileId: profileService.getProfileId() ?? 0,
                  isEditMode: true,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SvgPicture.asset(AppAssets.icPen),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ProfileInformationCubit, ProfileInformationState>(
        listener: (context, state) {
          state.maybeWhen(
            failure: (failure) {
              BrandfaceBottomSheet.openFailureBottomSheet(
                context: context,
                message: failure.localized,
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            infoLoaded: (data) => _BrandProfileBody(data: data),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _BrandProfileBody extends StatelessWidget {
  const _BrandProfileBody({required this.data});

  final InfluencerProfileInformationEntity data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderSection(data: data),
          const SizedBox(height: 16),
          Text(t.profile.general_info, style: Typographies.titleSmall),
          const SizedBox(height: 8),
          AppContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleDescriptionWidget(
                  title: t.registration.region,
                  descriptionItem: Text(
                    data.region?.name ?? '—',
                    style: Typographies.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                TitleDescriptionWidget(
                  title: t.registration.city,
                  descriptionItem: Text(
                    data.city?.name ?? '—',
                    style: Typographies.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                TitleDescriptionWidget(
                  title: t.registration.sphere,
                  descriptionItem: Text('—', style: Typographies.bodyMedium),
                ),
                const SizedBox(height: 16),
                TitleDescriptionWidget(
                  title: t.registration.profile_information,
                  descriptionItem: Text(
                    data.bio ?? '—',
                    style: Typographies.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                TitleDescriptionWidget(
                  title: t.brand.website,
                  descriptionItem: Text('—', style: Typographies.bodyMedium),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(t.registration.contact_details, style: Typographies.titleSmall),
          const SizedBox(height: 8),
          AppContainer(
            child: _ContactDetailsWidget(contacts: data.contacts),
          ),
          const SizedBox(height: 16),
          Text(t.registration.categories, style: Typographies.titleSmall),
          const SizedBox(height: 8),
          AppContainer(
            child: _CategoriesWidget(categories: data.categories),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({required this.data});

  final InfluencerProfileInformationEntity data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AvatarWidget(avatarUrl: data.avatarUrl),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.displayName ?? t.brand.title,
                style: Typographies.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                t.registration.brand,
                style: Typographies.bodySmall.copyWith(
                  color: AppColors.mutedBlack,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget({this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          '${ApiRoutes.mediaBaseUrl}$avatarUrl',
          width: 72,
          height: 72,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(),
        ),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/im_person_avatar_sample.png',
          width: 72,
          height: 72,
          fit: BoxFit.cover,
        ),
      );
}

class _ContactDetailsWidget extends StatelessWidget {
  const _ContactDetailsWidget({this.contacts});

  final List<ContactEntity>? contacts;

  @override
  Widget build(BuildContext context) {
    if (contacts == null || contacts!.isEmpty) {
      return Text(t.common.no_contact_details, style: Typographies.bodyMedium);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contacts!.map((c) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TitleDescriptionWidget(
            title: _contactLabel(c.type),
            descriptionItem: Text(
              c.value ?? '—',
              style: Typographies.bodyMedium,
            ),
          ),
        );
      }).toList(),
    );
  }

  String _contactLabel(String? type) {
    switch (type?.toLowerCase()) {
      case 'phone':
        return t.contact.phone;
      case 'telegram':
        return t.contact.telegram;
      case 'instagram':
        return t.contact.instagram;
      default:
        return type ?? '';
    }
  }
}

class _CategoriesWidget extends StatelessWidget {
  const _CategoriesWidget({this.categories});

  final List<dynamic>? categories;

  @override
  Widget build(BuildContext context) {
    if (categories == null || categories!.isEmpty) {
      return Text('—', style: Typographies.bodyMedium);
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories!.map((c) {
        final name = (c is CategoryData) ? (c.name ?? '') : c.toString();
        return AppBadge(title: name);
      }).toList(),
    );
  }
}
```

> **Eslatma:** `CategoryData` import — `package:brandface/data/models/profile/catalog/category_model.dart` dan.

- [ ] **Step 2: Kerakli importlarni tekshirish va qo'shish**

Fayl tepasiga qo'shish:
```dart
import 'package:brandface/data/models/profile/catalog/category_model.dart';
```

- [ ] **Step 3: Commit**

```bash
git add lib/presentation/home_page/brand/ui/brand_profile_page.dart
git commit -m "refactor: BrandProfilePage — real data from cubit, remove app language/logout"
```

---

### Task 4: Router — yangi sahifani ro'yxatga olish

**Files:**
- Modify: `lib/core/router/app_router.dart`

- [ ] **Step 1: Import qo'shish**

`app_router.dart` faylida mavjud importlar orasiga qo'shish:
```dart
import '../../presentation/home_page/brand/ui/brand_profile_menu_page.dart';
```

- [ ] **Step 2: Route qo'shish**

`BrandProfilePage` route dan keyin qo'shish:

```dart
GoRoute(
  path: BrandProfileMenuPage.tag,
  name: BrandProfileMenuPage.tag,
  builder: (_, _) => const BrandProfileMenuPage(),
),
```

- [ ] **Step 3: Commit**

```bash
git add lib/core/router/app_router.dart
git commit -m "feat: add BrandProfileMenuPage route"
```

---

### Task 5: `BrandHomePage` navigatsiyasini yangilash

Avatar bosilganda to'g'ridan `BrandProfilePage` emas, `BrandProfileMenuPage` ga o'tish kerak.

**Files:**
- Modify: `lib/presentation/home_page/brand/ui/brand_home_page.dart`

- [ ] **Step 1: Import yangilash**

`brand_home_page.dart` da:
```dart
// Eski:
import 'package:brandface/presentation/home_page/brand/ui/brand_profile_page.dart';

// Yangi:
import 'package:brandface/presentation/home_page/brand/ui/brand_profile_menu_page.dart';
```

- [ ] **Step 2: onTap navigatsiyasini yangilash**

`SliverAppBar` dagi `leading` GestureDetector-da:
```dart
// Eski:
onTap: () => context.pushNamed(BrandProfilePage.tag),

// Yangi:
onTap: () => context.pushNamed(BrandProfileMenuPage.tag),
```

- [ ] **Step 3: Commit**

```bash
git add lib/presentation/home_page/brand/ui/brand_home_page.dart
git commit -m "fix: BrandHomePage navigates to BrandProfileMenuPage"
```

---

### Task 6: Yakuniy tekshiruv

- [ ] **Step 1: Loyihani build qilish**

```bash
flutter build apk --debug 2>&1 | tail -20
```

Expected: `BUILD SUCCESSFUL`

- [ ] **Step 2: Qo'lda test qilish**

1. Brand akkaunt bilan login
2. Home page → avatar tap → `BrandProfileMenuPage` ochilishi
3. "Profile information" tap → `BrandProfilePage` → real data ko'rsatishi
4. "Plan" tap → `Billing` Plan tabida ochilishi
5. "My cards" tap → `Billing` My cards tabida ochilishi
6. "Billing history" tap → `Billing` History tabida ochilishi
7. "App language" tap → til tanlash bottom sheet
8. "Log out" tap → login sahifaga qaytish
