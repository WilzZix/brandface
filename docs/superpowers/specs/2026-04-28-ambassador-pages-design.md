# Ambassador Pages Design

**Date:** 2026-04-28  
**Branch:** TASK-11-brand-home-page-fix  
**Scope:** Filter page, Ambassador details page, read-only Portfolio details page

---

## Overview

Brand role uchun 3 ta yangi sahifa:
1. **AmbassadorsFilterPage** — server-side filter (category, region, gender, rank)
2. **AmbassadorDetailsPage** — ambassador profil detail, Information + Portfolio tabs
3. **AmbassadorPortfolioDetailsPage** — read-only portfolio item ko'rish

Mavjud sahifalar (`AmbassadorsPage`, sort bottom sheet) o'zgartirilmaydi — faqat filter tugmasi va ambassador card tapping qo'shiladi.

---

## API

### List (filter)
`GET /api/profiles/v1/influencers/`

| Query param | Type | Description |
|---|---|---|
| `category_id` | integer | Services/category filter |
| `region_id` | integer | Geography filter |
| `gender` | string | `male` / `female` / `any` |
| `is_top` | boolean | TOP influencers only |
| `is_vip` | boolean | VIP influencers only |
| `ordering` | string | Already supported |
| `search` | string | Already supported |

### Detail
`GET /api/profiles/v1/influencers/{id}/`  
Returns `InfluencerDetail`: id, display_name, avatar_url, bio, region, city, gender, categories, services, languages, years_of_experience, is_verified, is_top, is_vip, average_rating, total_reviews.  
Mavjud `ApiRoutes.profile(String id)` = `profiles/v1/influencers/$id/` — reuse.

### Public Portfolio
`GET /api/portfolio/v1/influencers/{influencer_id}/`  
Mavjud `ApiRoutes.publicPortfolio(int influencerId)` — reuse.  
Returns list of `Portfolio` items (same shape as `PortfolioItemEntity`).

---

## Architecture

### Filter params value object

```dart
// lib/presentation/home_page/brand/ui/ambassadors_filter_page.dart
class AmbassadorsFilterParams {
  final int? categoryId;
  final int? regionId;
  final String? gender;   // 'male' | 'female' | 'any'
  final bool? isTop;
  final bool? isVip;
}
```

### AmbassadorsCubit (update)

`load()` metodi `AmbassadorsFilterParams?` parametr qabul qiladi. Ordering va filter params birgalikda API ga yuboriladi.

```dart
Future<void> load({String? ordering, AmbassadorsFilterParams? filter})
```

`ProfileDataSource.getAmbassadors()` va `ProfileRepositoryImpl.getAmbassadors()` ham shunga mos yangilanadi.

### AmbassadorDetailCubit (new)

`lib/presentation/home_page/brand/bloc/ambassador_detail/`

- State: `AmbassadorDetailState` (initial / loading / loaded(ProfileEntity) / failure)
- Uses: mavjud `getProfile` use case (`IProfileRepository.getProfile`)

### AmbassadorPortfolioCubit (new)

`lib/presentation/home_page/brand/bloc/ambassador_portfolio/`

- State: `AmbassadorPortfolioState` (initial / loading / loaded(List<PortfolioItemEntity>) / failure)
- Uses: `IPortfolioRepository.getPublicPortfolio(int influencerId)` — bu method mavjud emas, qo'shiladi

---

## Pages

### 1. AmbassadorsFilterPage

**Path:** `lib/presentation/home_page/brand/ui/ambassadors_filter_page.dart`  
**Route:** `/ambassador-filter`  
**Args:** `AmbassadorsFilterParams?` (current state, `extra` orqali)

**Structure:**
- `Scaffold` + `AppBar` ("Filter", back button)
- `SingleChildScrollView` with `Column`
- Each filter row: label + dropdown-style selector (bottom sheet based)
- Services → `CategoryCubit` list, select one
- Geography → `RegionCubit` list, select one  
- Gender → static options: Any / Male / Female
- Rank type → static options: Any / TOP / VIP
- Bottom: Row with **Cancel** (clear, pop null) + **Continue** (pop params) buttons

**Catalog cubits** (`CategoryCubit`, `RegionCubit`) are provided via `MultiBlocProvider` in router.

**Result:** `Navigator.pop<AmbassadorsFilterParams?>(context, params)` — null means cleared.

### 2. AmbassadorDetailsPage

**Path:** `lib/presentation/home_page/brand/ui/ambassador_details_page.dart`  
**Route:** `/ambassador-details`  
**Args:** `int ambassadorId` (via `extra`)

**Structure:**
- `Scaffold` + `AppBar` ("Ambassador details")
- `BlocBuilder<AmbassadorDetailCubit>`:
  - Loading: `CircularProgressIndicator`
  - Failure: error message
  - Loaded:
    - Hero avatar (full-width, 200px height, `ClipRRect`)
    - Name row: display_name + verified icon + rating star
    - `DefaultTabController(length: 2)`
    - `TabBar`: **Information** | **Portfolio**
    - `TabBarView`:
      - `_InformationTab` — bio, categories chips, services, languages, region/city
      - `_PortfolioTab` — `BlocBuilder<AmbassadorPortfolioCubit>`, grid/list of portfolio cards

**Portfolio card** in tab: cover image + name, onTap → `/ambassador-portfolio-details`

### 3. AmbassadorPortfolioDetailsPage

**Path:** `lib/presentation/home_page/brand/ui/ambassador_portfolio_details_page.dart`  
**Route:** `/ambassador-portfolio-details`  
**Args:** `PortfolioItemEntity` (via `extra`)

No API call — data passed as argument (already loaded in portfolio tab).

**Structure:** (same layout as existing `PortfolioDetailsPage` minus edit button)
- `AppBar` ("Portfolio details", no actions)
- Portfolio name (title)
- Hero image
- Information section: Description
- Links section
- Portfolio images (horizontal scroll)

---

## Router changes

`app_router.dart` ga 3 ta route qo'shiladi:

```dart
GoRoute(
  path: AmbassadorsFilterPage.tag,  // '/ambassador-filter'
  builder: (_, state) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<CategoryCubit>()..getCategory()),
      BlocProvider(create: (_) => sl<RegionCubit>()..getRegions()),
    ],
    child: AmbassadorsFilterPage(
      initial: state.extra as AmbassadorsFilterParams?,
    ),
  ),
),
GoRoute(
  path: AmbassadorDetailsPage.tag,  // '/ambassador-details'
  builder: (_, state) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<AmbassadorDetailCubit>()
        ..load(state.extra as int)),
      BlocProvider(create: (_) => sl<AmbassadorPortfolioCubit>()
        ..load(state.extra as int)),
    ],
    child: AmbassadorDetailsPage(ambassadorId: state.extra as int),
  ),
),
GoRoute(
  path: AmbassadorPortfolioDetailsPage.tag,  // '/ambassador-portfolio-details'
  builder: (_, state) => AmbassadorPortfolioDetailsPage(
    item: state.extra as PortfolioItemEntity,
  ),
),
```

## AmbassadorsPage changes

1. Filter button onTap: `context.pushNamed(AmbassadorsFilterPage.tag, extra: _currentFilter)`, await result, call `cubit.load(filter: result)`
2. `_AmbassadorCard` onTap: `context.pushNamed(AmbassadorDetailsPage.tag, extra: ambassador.id)`

## Data layer changes

### IPortfolioRepository
```dart
Future<Either<Failure, List<PortfolioItemEntity>>> getPublicPortfolio({
  required int influencerId,
});
```

### PortfolioDataSource
```dart
Future<List<PortfolioItemModel>> getPublicPortfolio({required int influencerId});
```
Uses existing `ApiRoutes.publicPortfolio(influencerId)`.

### IProfileRepository / ProfileDataSource
`getAmbassadors` signature updated:
```dart
Future<Either<Failure, List<AmbassadorEntity>>> getAmbassadors({
  String? ordering,
  int? categoryId,
  int? regionId,
  String? gender,
  bool? isTop,
  bool? isVip,
});
```

### DI (app_di.dart)
`AmbassadorDetailCubit` va `AmbassadorPortfolioCubit` registered.

---

## File list

**New files:**
- `lib/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_cubit.dart`
- `lib/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_state.dart`
- `lib/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_cubit.dart`
- `lib/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_state.dart`
- `lib/presentation/home_page/brand/ui/ambassadors_filter_page.dart`
- `lib/presentation/home_page/brand/ui/ambassador_details_page.dart`
- `lib/presentation/home_page/brand/ui/ambassador_portfolio_details_page.dart`

**Modified files:**
- `lib/presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart`
- `lib/presentation/home_page/brand/ui/ambassadors_page.dart`
- `lib/domain/repository/portfolio_repository.dart`
- `lib/data/repositories/portfolio_repository_impl.dart`
- `lib/data/data_source/network_data_source/portfolio/portfolio_data_source.dart`
- `lib/domain/repository/profile_repository.dart`
- `lib/data/repositories/profile_repository_impl.dart`
- `lib/data/data_source/network_data_source/profile/profile_data_source.dart`
- `lib/core/router/app_router.dart`
- `lib/core/di/app_di.dart`
