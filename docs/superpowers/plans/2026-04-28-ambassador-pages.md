# Ambassador Pages Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Brand role uchun Filter page, Ambassador details page va read-only Portfolio details page yaratish — server-side filtering va to'liq ambassador profil ko'rinishi bilan.

**Architecture:** `AmbassadorsFilterParams` value object orqali filter holati saqlanadi; `AmbassadorDetailEntity` (yangi) `InfluencerDetail` API response ni map qiladi; `AmbassadorPortfolioCubit` mavjud `publicPortfolio` endpointidan foydalanadi. Barcha yangi sahifalar mavjud `AppColors`/`Typographies` design token laridan foydalanadi.

**Tech Stack:** Flutter, flutter_bloc (Cubit), go_router, get_it, dart_either, dio

---

## File Map

**New files:**
- `lib/domain/entities/profile/ambassador_detail_entity.dart` — `InfluencerDetail` API uchun entity
- `lib/data/models/profile/ambassador_detail_model.dart` — JSON → entity
- `lib/domain/usecase/profile/get_ambassador_detail_use_case.dart` — use case
- `lib/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_cubit.dart`
- `lib/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_state.dart`
- `lib/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_cubit.dart`
- `lib/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_state.dart`
- `lib/presentation/home_page/brand/ui/ambassadors_filter_page.dart`
- `lib/presentation/home_page/brand/ui/ambassador_details_page.dart`
- `lib/presentation/home_page/brand/ui/ambassador_portfolio_details_page.dart`

**Modified files:**
- `lib/domain/repository/profile_repository.dart` — `getAmbassadorDetail` + filter params
- `lib/data/data_source/network_data_source/profile/profile_data_source.dart` — same
- `lib/data/repositories/profile_repository_impl.dart` — same
- `lib/domain/repository/portfolio_repository.dart` — `getPublicPortfolio`
- `lib/data/data_source/network_data_source/portfolio/portfolio_data_source.dart` — same
- `lib/data/repositories/portfolio_repository_impl.dart` — same
- `lib/presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart` — filter params
- `lib/presentation/home_page/brand/ui/ambassadors_page.dart` — filter + card tap
- `lib/core/router/app_router.dart` — 3 yangi route
- `lib/core/di/app_di.dart` — 2 yangi cubit register

---

## Task 1: AmbassadorDetailEntity va Model

**Files:**
- Create: `lib/domain/entities/profile/ambassador_detail_entity.dart`
- Create: `lib/data/models/profile/ambassador_detail_model.dart`

- [ ] **Step 1: Entity yaratish**

`lib/domain/entities/profile/ambassador_detail_entity.dart`:

```dart
import 'package:equatable/equatable.dart';

class AmbassadorDetailEntity extends Equatable {
  final int id;
  final String? displayName;
  final String? avatarUrl;
  final String? bio;
  final String? regionName;
  final String? cityName;
  final String? gender;
  final List<String> categories;
  final List<String> services;
  final List<String> languages;
  final int? yearsOfExperience;
  final bool isVerified;
  final bool isTop;
  final bool isVip;
  final double? averageRating;
  final int totalReviews;

  const AmbassadorDetailEntity({
    required this.id,
    this.displayName,
    this.avatarUrl,
    this.bio,
    this.regionName,
    this.cityName,
    this.gender,
    required this.categories,
    required this.services,
    required this.languages,
    this.yearsOfExperience,
    required this.isVerified,
    required this.isTop,
    required this.isVip,
    required this.averageRating,
    required this.totalReviews,
  });

  @override
  List<Object?> get props => [
        id, displayName, avatarUrl, bio, regionName, cityName,
        gender, categories, services, languages, yearsOfExperience,
        isVerified, isTop, isVip, averageRating, totalReviews,
      ];
}
```

- [ ] **Step 2: Model yaratish**

`lib/data/models/profile/ambassador_detail_model.dart`:

```dart
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';

class AmbassadorDetailModel extends AmbassadorDetailEntity {
  const AmbassadorDetailModel({
    required super.id,
    super.displayName,
    super.avatarUrl,
    super.bio,
    super.regionName,
    super.cityName,
    super.gender,
    required super.categories,
    required super.services,
    required super.languages,
    super.yearsOfExperience,
    required super.isVerified,
    required super.isTop,
    required super.isVip,
    required super.averageRating,
    required super.totalReviews,
  });

  factory AmbassadorDetailModel.fromJson(Map<String, dynamic> json) {
    List<String> _names(dynamic raw) {
      if (raw is! List) return const [];
      return raw
          .map((e) => e is Map ? e['name']?.toString() ?? '' : e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList(growable: false);
    }

    double? rating;
    final rawRating = json['average_rating'];
    if (rawRating != null) {
      rating = rawRating is double
          ? rawRating
          : double.tryParse(rawRating.toString());
    }

    return AmbassadorDetailModel(
      id: json['id'] as int,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
      regionName: (json['region'] is Map)
          ? json['region']['name'] as String?
          : null,
      cityName: (json['city'] is Map)
          ? json['city']['name'] as String?
          : null,
      gender: json['gender'] as String?,
      categories: _names(json['categories']),
      services: _names(json['services']),
      languages: _names(json['languages']),
      yearsOfExperience: json['years_of_experience'] as int?,
      isVerified: json['is_verified'] as bool? ?? false,
      isTop: json['is_top'] as bool? ?? false,
      isVip: json['is_vip'] as bool? ?? false,
      averageRating: rating,
      totalReviews: json['total_reviews'] as int? ?? 0,
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add lib/domain/entities/profile/ambassador_detail_entity.dart lib/data/models/profile/ambassador_detail_model.dart
git commit -m "feat: add AmbassadorDetailEntity and AmbassadorDetailModel"
```

---

## Task 2: Data layer — getAmbassadorDetail

**Files:**
- Modify: `lib/domain/repository/profile_repository.dart`
- Modify: `lib/data/data_source/network_data_source/profile/profile_data_source.dart`
- Modify: `lib/data/repositories/profile_repository_impl.dart`

- [ ] **Step 1: IProfileRepository ga method qo'shish**

`lib/domain/repository/profile_repository.dart` ga import va method qo'shish:

Import qo'shish (fayl boshiga):
```dart
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
```

Abstract class ichiga qo'shish (mavjud `getAmbassadors` dan keyin):
```dart
Future<Either<Failure, AmbassadorDetailEntity>> getAmbassadorDetail({
  required int ambassadorId,
});

Future<Either<Failure, List<AmbassadorEntity>>> getAmbassadors({
  String? ordering,
  int? categoryId,
  int? regionId,
  String? gender,
  bool? isTop,
  bool? isVip,
});
```

Eslatma: mavjud `getAmbassadors` signaturasini ham yangilash kerak (filter params qo'shish).

- [ ] **Step 2: ProfileDataSource abstract + impl yangilash**

`lib/data/data_source/network_data_source/profile/profile_data_source.dart`:

Abstract class ichiga qo'shish:
```dart
import 'package:brandface/data/models/profile/ambassador_detail_model.dart';
```

```dart
Future<AmbassadorDetailModel> getAmbassadorDetail({required int ambassadorId});

// getAmbassadors signature yangilash:
Future<List<AmbassadorModel>> getAmbassadors({
  String? ordering,
  int? categoryId,
  int? regionId,
  String? gender,
  bool? isTop,
  bool? isVip,
});
```

`ProfileDataSourceImpl` da `getAmbassadorDetail` implement qilish:
```dart
@override
Future<AmbassadorDetailModel> getAmbassadorDetail({required int ambassadorId}) async {
  final response = await _dioClient.get(ApiRoutes.profile(ambassadorId.toString()));
  final payload = response.data;
  final data = payload is Map && payload['data'] is Map
      ? Map<String, dynamic>.from(payload['data'] as Map)
      : Map<String, dynamic>.from(payload as Map);
  return AmbassadorDetailModel.fromJson(data);
}
```

`getAmbassadors` methodini yangilash (filter params qo'shish):
```dart
@override
Future<List<AmbassadorModel>> getAmbassadors({
  String? ordering,
  int? categoryId,
  int? regionId,
  String? gender,
  bool? isTop,
  bool? isVip,
}) async {
  final queryParams = <String, dynamic>{};
  if (ordering != null) queryParams['ordering'] = ordering;
  if (categoryId != null) queryParams['category_id'] = categoryId;
  if (regionId != null) queryParams['region_id'] = regionId;
  if (gender != null && gender != 'any') queryParams['gender'] = gender;
  if (isTop == true) queryParams['is_top'] = true;
  if (isVip == true) queryParams['is_vip'] = true;

  final response = await _dioClient.get(
    ApiRoutes.ambassadors,
    queryParameters: queryParams.isEmpty ? null : queryParams,
  );
  final payload = response.data;
  List<dynamic> list;
  if (payload is List) {
    list = payload;
  } else if (payload is Map) {
    final inner = payload['results'] ?? payload['data'];
    list = inner is List ? inner : [];
  } else {
    list = [];
  }
  return list.map((item) {
    final map = item is Map<String, dynamic>
        ? item
        : Map<String, dynamic>.from(item as Map);
    return AmbassadorModel.fromJson(map);
  }).toList();
}
```

- [ ] **Step 3: ProfileRepositoryImpl yangilash**

`lib/data/repositories/profile_repository_impl.dart` ichida:

Import qo'shish:
```dart
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
```

`getAmbassadorDetail` implement qilish:
```dart
@override
Future<Either<Failure, AmbassadorDetailEntity>> getAmbassadorDetail({
  required int ambassadorId,
}) async {
  try {
    final detail = await _dataSource.getAmbassadorDetail(ambassadorId: ambassadorId);
    return Right(detail);
  } on DioException catch (e) {
    return Left(ServerFailure(
      e.response?.data?['detail'] ?? e.message ?? 'Serverda xatolik',
      statusCode: e.response?.statusCode,
    ));
  } catch (e) {
    return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
  }
}
```

`getAmbassadors` methodini yangilash (signature + impl):
```dart
@override
Future<Either<Failure, List<AmbassadorEntity>>> getAmbassadors({
  String? ordering,
  int? categoryId,
  int? regionId,
  String? gender,
  bool? isTop,
  bool? isVip,
}) async {
  try {
    final items = await _dataSource.getAmbassadors(
      ordering: ordering,
      categoryId: categoryId,
      regionId: regionId,
      gender: gender,
      isTop: isTop,
      isVip: isVip,
    );
    return Right(items);
  } on DioException catch (e) {
    return Left(ServerFailure(
      e.response?.data?['detail'] ?? e.message ?? 'Serverda xatolik',
      statusCode: e.response?.statusCode,
    ));
  } catch (e) {
    return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
  }
}
```

- [ ] **Step 4: Commit**

```bash
git add lib/domain/repository/profile_repository.dart \
        lib/data/data_source/network_data_source/profile/profile_data_source.dart \
        lib/data/repositories/profile_repository_impl.dart
git commit -m "feat: add getAmbassadorDetail + filter params to getAmbassadors"
```

---

## Task 3: Data layer — getPublicPortfolio

**Files:**
- Modify: `lib/domain/repository/portfolio_repository.dart`
- Modify: `lib/data/data_source/network_data_source/portfolio/portfolio_data_source.dart`
- Modify: `lib/data/repositories/portfolio_repository_impl.dart`

- [ ] **Step 1: IPortfolioRepository ga method qo'shish**

`lib/domain/repository/portfolio_repository.dart` da abstract class ichiga qo'shish:
```dart
Future<Either<Failure, List<PortfolioItemEntity>>> getPublicPortfolio({
  required int influencerId,
});
```

- [ ] **Step 2: PortfolioDataSource yangilash**

`lib/data/data_source/network_data_source/portfolio/portfolio_data_source.dart` da abstract class ichiga qo'shish:
```dart
Future<List<PortfolioModel>> getPublicPortfolio({required int influencerId});
```

`PortfolioDataSourceImpl` da implement qilish:
```dart
@override
Future<List<PortfolioModel>> getPublicPortfolio({required int influencerId}) async {
  final result = await _dioClient.get(ApiRoutes.publicPortfolio(influencerId));
  final payload = result.data;
  final list = payload is List
      ? payload
      : payload is Map && payload['data'] is List
          ? payload['data'] as List
          : const [];
  return list
      .map((item) => PortfolioModel.fromJson(Map<String, dynamic>.from(item as Map)))
      .toList(growable: false);
}
```

- [ ] **Step 3: PortfolioRepositoryImpl yangilash**

`lib/data/repositories/portfolio_repository_impl.dart` da implement qilish:
```dart
@override
Future<Either<Failure, List<PortfolioItemEntity>>> getPublicPortfolio({
  required int influencerId,
}) async {
  try {
    final items = await _dataSource.getPublicPortfolio(influencerId: influencerId);
    return Right(items);
  } on DioException catch (e) {
    return Left(ServerFailure(
      e.response?.data?['detail'] ?? e.message ?? 'Serverda xatolik',
      statusCode: e.response?.statusCode,
    ));
  } catch (e) {
    return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
  }
}
```

- [ ] **Step 4: Commit**

```bash
git add lib/domain/repository/portfolio_repository.dart \
        lib/data/data_source/network_data_source/portfolio/portfolio_data_source.dart \
        lib/data/repositories/portfolio_repository_impl.dart
git commit -m "feat: add getPublicPortfolio to portfolio data layer"
```

---

## Task 4: GetAmbassadorDetailUseCase

**Files:**
- Create: `lib/domain/usecase/profile/get_ambassador_detail_use_case.dart`

- [ ] **Step 1: Use case yaratish**

```dart
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

class GetAmbassadorDetailUseCase
    implements UseCase<AmbassadorDetailEntity, int> {
  final IProfileRepository repository;

  GetAmbassadorDetailUseCase({required this.repository});

  @override
  Future<Either<Failure, AmbassadorDetailEntity>> call({
    required int params,
  }) {
    return repository.getAmbassadorDetail(ambassadorId: params);
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/domain/usecase/profile/get_ambassador_detail_use_case.dart
git commit -m "feat: add GetAmbassadorDetailUseCase"
```

---

## Task 5: AmbassadorDetailCubit

**Files:**
- Create: `lib/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_state.dart`
- Create: `lib/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_cubit.dart`

- [ ] **Step 1: State yaratish**

`lib/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_state.dart`:

```dart
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';

abstract class AmbassadorDetailState {}

class AmbassadorDetailInitial extends AmbassadorDetailState {}

class AmbassadorDetailLoading extends AmbassadorDetailState {}

class AmbassadorDetailLoaded extends AmbassadorDetailState {
  final AmbassadorDetailEntity detail;
  AmbassadorDetailLoaded(this.detail);
}

class AmbassadorDetailFailure extends AmbassadorDetailState {
  final String message;
  AmbassadorDetailFailure(this.message);
}
```

- [ ] **Step 2: Cubit yaratish**

`lib/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_cubit.dart`:

```dart
import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/profile/get_ambassador_detail_use_case.dart';
import 'ambassador_detail_state.dart';

class AmbassadorDetailCubit extends Cubit<AmbassadorDetailState> {
  final GetAmbassadorDetailUseCase _useCase;

  AmbassadorDetailCubit({required GetAmbassadorDetailUseCase useCase})
      : _useCase = useCase,
        super(AmbassadorDetailInitial());

  Future<void> load(int ambassadorId) async {
    emit(AmbassadorDetailLoading());
    final result = await _useCase.call(params: ambassadorId);
    result.fold(
      ifLeft: (f) => emit(AmbassadorDetailFailure(f.message)),
      ifRight: (detail) => emit(AmbassadorDetailLoaded(detail)),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add lib/presentation/home_page/brand/bloc/ambassador_detail/
git commit -m "feat: add AmbassadorDetailCubit"
```

---

## Task 6: AmbassadorPortfolioCubit

**Files:**
- Create: `lib/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_state.dart`
- Create: `lib/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_cubit.dart`

- [ ] **Step 1: State yaratish**

`lib/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_state.dart`:

```dart
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';

abstract class AmbassadorPortfolioState {}

class AmbassadorPortfolioInitial extends AmbassadorPortfolioState {}

class AmbassadorPortfolioLoading extends AmbassadorPortfolioState {}

class AmbassadorPortfolioLoaded extends AmbassadorPortfolioState {
  final List<PortfolioItemEntity> items;
  AmbassadorPortfolioLoaded(this.items);
}

class AmbassadorPortfolioFailure extends AmbassadorPortfolioState {
  final String message;
  AmbassadorPortfolioFailure(this.message);
}
```

- [ ] **Step 2: Cubit yaratish**

`lib/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_cubit.dart`:

```dart
import 'package:bloc/bloc.dart';
import 'package:brandface/domain/repository/portfolio_repository.dart';
import 'ambassador_portfolio_state.dart';

class AmbassadorPortfolioCubit extends Cubit<AmbassadorPortfolioState> {
  final IPortfolioRepository _repository;

  AmbassadorPortfolioCubit({required IPortfolioRepository portfolioRepository})
      : _repository = portfolioRepository,
        super(AmbassadorPortfolioInitial());

  Future<void> load(int influencerId) async {
    emit(AmbassadorPortfolioLoading());
    final result = await _repository.getPublicPortfolio(influencerId: influencerId);
    result.fold(
      ifLeft: (f) => emit(AmbassadorPortfolioFailure(f.message)),
      ifRight: (items) => emit(AmbassadorPortfolioLoaded(items)),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add lib/presentation/home_page/brand/bloc/ambassador_portfolio/
git commit -m "feat: add AmbassadorPortfolioCubit"
```

---

## Task 7: AmbassadorsCubit filter params yangilash

**Files:**
- Modify: `lib/presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart`

- [ ] **Step 1: AmbassadorsFilterParams value object qo'shish va cubit yangilash**

`lib/presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart` ni to'liq fayl mazmunini quyidagicha yangilash:

```dart
import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/profile/ambassador_entity.dart';
import 'package:brandface/domain/usecase/profile/get_ambassadors_use_case.dart';
import 'ambassadors_state.dart';

class AmbassadorsFilterParams {
  final int? categoryId;
  final int? regionId;
  final String? gender;
  final bool? isTop;
  final bool? isVip;

  const AmbassadorsFilterParams({
    this.categoryId,
    this.regionId,
    this.gender,
    this.isTop,
    this.isVip,
  });

  bool get isEmpty =>
      categoryId == null &&
      regionId == null &&
      (gender == null || gender == 'any') &&
      isTop != true &&
      isVip != true;

  AmbassadorsFilterParams copyWith({
    int? categoryId,
    int? regionId,
    String? gender,
    bool? isTop,
    bool? isVip,
  }) {
    return AmbassadorsFilterParams(
      categoryId: categoryId ?? this.categoryId,
      regionId: regionId ?? this.regionId,
      gender: gender ?? this.gender,
      isTop: isTop ?? this.isTop,
      isVip: isVip ?? this.isVip,
    );
  }
}

class AmbassadorsCubit extends Cubit<AmbassadorsState> {
  final GetAmbassadorsUseCase _useCase;
  List<AmbassadorEntity> _allAmbassadors = [];

  AmbassadorsCubit({required GetAmbassadorsUseCase getAmbassadorsUseCase})
      : _useCase = getAmbassadorsUseCase,
        super(AmbassadorsInitial());

  Future<void> load({
    String? ordering,
    AmbassadorsFilterParams? filter,
  }) async {
    emit(AmbassadorsLoading());
    final result = await _useCase.call(
      params: ordering,
      categoryId: filter?.categoryId,
      regionId: filter?.regionId,
      gender: filter?.gender,
      isTop: filter?.isTop,
      isVip: filter?.isVip,
    );
    result.fold(
      ifLeft: (f) => emit(AmbassadorsFailure(f.message)),
      ifRight: (data) {
        _allAmbassadors = data;
        emit(AmbassadorsLoaded(data));
      },
    );
  }

  void search(String query) {
    if (state is! AmbassadorsLoaded) return;
    if (query.trim().isEmpty) {
      emit(AmbassadorsLoaded(_allAmbassadors));
      return;
    }
    final q = query.toLowerCase();
    final filtered = _allAmbassadors
        .where(
          (a) =>
              (a.displayName?.toLowerCase().contains(q) ?? false) ||
              a.categories.any((c) => c.toLowerCase().contains(q)),
        )
        .toList();
    emit(AmbassadorsLoaded(filtered));
  }
}
```

- [ ] **Step 2: GetAmbassadorsUseCase yangilash**

`lib/domain/usecase/profile/get_ambassadors_use_case.dart` ni to'liq yangilash:

```dart
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/ambassador_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:dart_either/dart_either.dart';

class GetAmbassadorsUseCase {
  final IProfileRepository repository;

  GetAmbassadorsUseCase({required this.repository});

  Future<Either<Failure, List<AmbassadorEntity>>> call({
    String? params,
    int? categoryId,
    int? regionId,
    String? gender,
    bool? isTop,
    bool? isVip,
  }) {
    return repository.getAmbassadors(
      ordering: params,
      categoryId: categoryId,
      regionId: regionId,
      gender: gender,
      isTop: isTop,
      isVip: isVip,
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add lib/presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart \
        lib/domain/usecase/profile/get_ambassadors_use_case.dart
git commit -m "feat: add AmbassadorsFilterParams and filter support to AmbassadorsCubit"
```

---

## Task 8: DI — yangi cubit va use case ro'yxatga olish

**Files:**
- Modify: `lib/core/di/app_di.dart`

- [ ] **Step 1: Import qo'shish**

`lib/core/di/app_di.dart` ning import qismiga qo'shish:

```dart
import 'package:brandface/domain/usecase/profile/get_ambassador_detail_use_case.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_cubit.dart';
```

- [ ] **Step 2: Use case va cubitlarni register qilish**

`init()` metodida, mavjud `sl.registerLazySingleton(() => GetAmbassadorsUseCase(repository: sl()));` qatoridan keyin qo'shish:

```dart
sl.registerLazySingleton(
  () => GetAmbassadorDetailUseCase(repository: sl()),
);
```

`sl.registerFactory(() => AmbassadorsCubit(getAmbassadorsUseCase: sl()));` qatoridan keyin qo'shish:

```dart
sl.registerFactory(
  () => AmbassadorDetailCubit(useCase: sl()),
);
sl.registerFactory(
  () => AmbassadorPortfolioCubit(portfolioRepository: sl()),
);
```

- [ ] **Step 3: Compile tekshirish**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze --no-fatal-infos 2>&1 | head -30
```

- [ ] **Step 4: Commit**

```bash
git add lib/core/di/app_di.dart
git commit -m "feat: register AmbassadorDetailCubit and AmbassadorPortfolioCubit in DI"
```

---

## Task 9: AmbassadorsFilterPage

**Files:**
- Create: `lib/presentation/home_page/brand/ui/ambassadors_filter_page.dart`

- [ ] **Step 1: Filter page yaratish**

```dart
import 'package:brandface/presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/region/region_cubit.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmbassadorsFilterPage extends StatefulWidget {
  const AmbassadorsFilterPage({super.key, this.initial});

  static const String tag = '/ambassador-filter';

  final AmbassadorsFilterParams? initial;

  @override
  State<AmbassadorsFilterPage> createState() => _AmbassadorsFilterPageState();
}

class _AmbassadorsFilterPageState extends State<AmbassadorsFilterPage> {
  int? _categoryId;
  String? _categoryName;
  int? _regionId;
  String? _regionName;
  String _gender = 'any';
  String _rankType = 'any';

  @override
  void initState() {
    super.initState();
    final p = widget.initial;
    if (p != null) {
      _categoryId = p.categoryId;
      _regionId = p.regionId;
      _gender = p.gender ?? 'any';
      if (p.isTop == true) _rankType = 'top';
      if (p.isVip == true) _rankType = 'vip';
    }
  }

  AmbassadorsFilterParams _buildParams() {
    return AmbassadorsFilterParams(
      categoryId: _categoryId,
      regionId: _regionId,
      gender: _gender == 'any' ? null : _gender,
      isTop: _rankType == 'top' ? true : null,
      isVip: _rankType == 'vip' ? true : null,
    );
  }

  void _clear() {
    setState(() {
      _categoryId = null;
      _categoryName = null;
      _regionId = null;
      _regionName = null;
      _gender = 'any';
      _rankType = 'any';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        backgroundColor: AppColors.lightBg,
        scrolledUnderElevation: 0,
        title: Text('Filter', style: Typographies.titleMedium),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FilterSection(
              label: 'Services',
              value: _categoryName ?? 'Select',
              onTap: () => _pickCategory(context),
            ),
            const SizedBox(height: 12),
            _FilterSection(
              label: 'Geography',
              value: _regionName ?? 'Select',
              onTap: () => _pickRegion(context),
            ),
            const SizedBox(height: 12),
            _SegmentedFilterSection(
              label: 'Gender',
              options: const ['any', 'male', 'female'],
              labels: const ['Any', 'Male', 'Female'],
              selected: _gender,
              onChanged: (v) => setState(() => _gender = v),
            ),
            const SizedBox(height: 12),
            _SegmentedFilterSection(
              label: 'Rank type',
              options: const ['any', 'top', 'vip'],
              labels: const ['Any', 'TOP', 'VIP'],
              selected: _rankType,
              onChanged: (v) => setState(() => _rankType = v),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _clear,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.borderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text('Cancel', style: Typographies.labelLarge),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(_buildParams()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Continue',
                      style: Typographies.labelLarge.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickCategory(BuildContext context) async {
    final state = context.read<CategoryCubit>().state;
    final items = state.maybeWhen(
      categoryLoaded: (data) => data,
      orElse: () => <dynamic>[],
    );
    if (items.isEmpty) return;
    final result = await showModalBottomSheet<({int id, String name})>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _PickerSheet(
        title: 'Services',
        items: items.map((e) => (id: e.id as int, name: e.name as String)).toList(),
      ),
    );
    if (result != null) {
      setState(() {
        _categoryId = result.id;
        _categoryName = result.name;
      });
    }
  }

  Future<void> _pickRegion(BuildContext context) async {
    final state = context.read<RegionCubit>().state;
    final items = state.maybeWhen(
      regionsLoaded: (data) => data,
      orElse: () => <dynamic>[],
    );
    if (items.isEmpty) return;
    final result = await showModalBottomSheet<({int id, String name})>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _PickerSheet(
        title: 'Geography',
        items: items.map((e) => (id: e.id as int, name: e.name as String)).toList(),
      ),
    );
    if (result != null) {
      setState(() {
        _regionId = result.id;
        _regionName = result.name;
      });
    }
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Typographies.labelMedium.copyWith(color: AppColors.mutedBlack)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.lightBg3,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value,
                    style: Typographies.bodyMedium.copyWith(
                      color: value == 'Select' ? AppColors.grey : AppColors.black,
                    )),
                Icon(Icons.keyboard_arrow_down, color: AppColors.grey, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SegmentedFilterSection extends StatelessWidget {
  const _SegmentedFilterSection({
    required this.label,
    required this.options,
    required this.labels,
    required this.selected,
    required this.onChanged,
  });

  final String label;
  final List<String> options;
  final List<String> labels;
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Typographies.labelMedium.copyWith(color: AppColors.mutedBlack)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightBg3,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            children: List.generate(options.length, (i) {
              final isSelected = selected == options[i];
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(options[i]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      labels[i],
                      style: Typographies.labelMedium.copyWith(
                        color: isSelected ? AppColors.black : AppColors.mutedBlack,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _PickerSheet extends StatelessWidget {
  const _PickerSheet({required this.title, required this.items});

  final String title;
  final List<({int id, String name})> items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(title, style: Typographies.titleMedium),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(items[i].name, style: Typographies.bodyMedium),
                onTap: () => Navigator.of(context).pop(items[i]),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/presentation/home_page/brand/ui/ambassadors_filter_page.dart
git commit -m "feat: add AmbassadorsFilterPage"
```

---

## Task 10: AmbassadorPortfolioDetailsPage

**Files:**
- Create: `lib/presentation/home_page/brand/ui/ambassador_portfolio_details_page.dart`

- [ ] **Step 1: Read-only portfolio details page yaratish**

```dart
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class AmbassadorPortfolioDetailsPage extends StatelessWidget {
  const AmbassadorPortfolioDetailsPage({super.key, required this.item});

  static const String tag = '/ambassador-portfolio-details';

  final PortfolioItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.lightBg,
        titleSpacing: 4,
        title: Text('Portfolio details', style: Typographies.titleLarge),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            16, 16, 16,
            MediaQuery.of(context).padding.bottom + 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: Typographies.titleLarge.copyWith(fontSize: 28, height: 1.15),
              ),
              const SizedBox(height: 16),
              _HeroImage(imageUrl: item.heroImageUrl),
              const SizedBox(height: 16),
              Text('Information', style: Typographies.titleSmall),
              const SizedBox(height: 8),
              AppContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description',
                        style: Typographies.titleSmall.copyWith(
                            color: AppColors.mutedBlack)),
                    const SizedBox(height: 8),
                    Text(
                      item.description.isEmpty ? 'No description' : item.description,
                      style: Typographies.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('Links', style: Typographies.titleSmall),
              const SizedBox(height: 8),
              AppContainer(
                child: item.links.isEmpty
                    ? Text('No links added.',
                        style: Typographies.bodyMedium.copyWith(
                            color: AppColors.mutedBlack))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: item.links
                            .map((link) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(link,
                                      style: Typographies.bodyMedium.copyWith(
                                          decoration: TextDecoration.underline)),
                                ))
                            .toList(),
                      ),
              ),
              const SizedBox(height: 16),
              Text('Portfolio images', style: Typographies.titleSmall),
              const SizedBox(height: 8),
              AppContainer(
                child: SizedBox(
                  height: 157,
                  child: item.images.isEmpty
                      ? Center(
                          child: Text('No images added.',
                              style: Typographies.bodyMedium.copyWith(
                                  color: AppColors.mutedBlack)))
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: item.images.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (_, i) =>
                              _GalleryImage(imageUrl: item.images[i].imageUrl),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        width: double.infinity, height: 180,
        decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.image_outlined, color: AppColors.grey, size: 32),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        width: double.infinity, height: 180,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: 180,
          color: AppColors.borderColor,
          alignment: Alignment.center,
          child: Icon(Icons.image_outlined, color: AppColors.grey, size: 32),
        ),
      ),
    );
  }
}

class _GalleryImage extends StatelessWidget {
  const _GalleryImage({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl, width: 157, height: 157,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 157, height: 157,
          color: AppColors.borderColor,
          alignment: Alignment.center,
          child: Icon(Icons.image_outlined, color: AppColors.grey),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/presentation/home_page/brand/ui/ambassador_portfolio_details_page.dart
git commit -m "feat: add AmbassadorPortfolioDetailsPage (read-only)"
```

---

## Task 11: AmbassadorDetailsPage

**Files:**
- Create: `lib/presentation/home_page/brand/ui/ambassador_details_page.dart`

- [ ] **Step 1: Details page yaratish**

```dart
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_state.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_state.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassador_portfolio_details_page.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AmbassadorDetailsPage extends StatelessWidget {
  const AmbassadorDetailsPage({super.key, required this.ambassadorId});

  static const String tag = '/ambassador-details';

  final int ambassadorId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmbassadorDetailCubit, AmbassadorDetailState>(
      builder: (context, state) {
        if (state is AmbassadorDetailLoading || state is AmbassadorDetailInitial) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (state is AmbassadorDetailFailure) {
          return Scaffold(
            backgroundColor: AppColors.lightBg,
            appBar: AppBar(backgroundColor: AppColors.lightBg),
            body: Center(
              child: Text(state.message, style: Typographies.bodyMedium),
            ),
          );
        }
        final detail = (state as AmbassadorDetailLoaded).detail;
        return _DetailsScaffold(detail: detail);
      },
    );
  }
}

class _DetailsScaffold extends StatelessWidget {
  const _DetailsScaffold({required this.detail});
  final AmbassadorDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        appBar: AppBar(
          backgroundColor: AppColors.lightBg,
          scrolledUnderElevation: 0,
          title: Text('Ambassador details', style: Typographies.titleMedium),
          centerTitle: false,
          bottom: TabBar(
            labelStyle: Typographies.labelLarge,
            unselectedLabelStyle: Typographies.bodyMedium,
            indicatorColor: AppColors.primaryDark,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.grey,
            tabs: const [
              Tab(text: 'Information'),
              Tab(text: 'Portfolio'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _InformationTab(detail: detail),
            _PortfolioTab(ambassadorId: detail.id),
          ],
        ),
      ),
    );
  }
}

class _InformationTab extends StatelessWidget {
  const _InformationTab({required this.detail});
  final AmbassadorDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        16, 16, 16,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroAvatar(avatarUrl: detail.avatarUrl),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  detail.displayName ?? '—',
                  style: Typographies.titleLarge,
                ),
              ),
              if (detail.isVerified) ...[
                const SizedBox(width: 6),
                Icon(Icons.check_circle, color: AppColors.primaryDark, size: 22),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.star_rounded,
                  color: detail.averageRating != null
                      ? AppColors.orange
                      : AppColors.grey,
                  size: 16),
              const SizedBox(width: 4),
              Text(
                detail.averageRating != null
                    ? detail.averageRating!.toStringAsFixed(2)
                    : '—',
                style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
              ),
              const SizedBox(width: 8),
              Text(
                '${detail.totalReviews} reviews',
                style: Typographies.bodySmall.copyWith(color: AppColors.grey),
              ),
            ],
          ),
          if (detail.bio != null && detail.bio!.isNotEmpty) ...[
            const SizedBox(height: 16),
            AppContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bio',
                      style: Typographies.titleSmall.copyWith(
                          color: AppColors.mutedBlack)),
                  const SizedBox(height: 8),
                  Text(detail.bio!, style: Typographies.bodyMedium),
                ],
              ),
            ),
          ],
          if (detail.categories.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Categories', style: Typographies.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6, runSpacing: 6,
              children: detail.categories
                  .map((c) => _Chip(label: c))
                  .toList(),
            ),
          ],
          if (detail.services.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Services', style: Typographies.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6, runSpacing: 6,
              children: detail.services
                  .map((s) => _Chip(label: s))
                  .toList(),
            ),
          ],
          if (detail.languages.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Languages', style: Typographies.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6, runSpacing: 6,
              children: detail.languages
                  .map((l) => _Chip(label: l))
                  .toList(),
            ),
          ],
          if (detail.regionName != null || detail.cityName != null) ...[
            const SizedBox(height: 16),
            AppContainer(
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      color: AppColors.grey, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    [detail.cityName, detail.regionName]
                        .whereType<String>()
                        .join(', '),
                    style: Typographies.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PortfolioTab extends StatelessWidget {
  const _PortfolioTab({required this.ambassadorId});
  final int ambassadorId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmbassadorPortfolioCubit, AmbassadorPortfolioState>(
      builder: (context, state) {
        if (state is AmbassadorPortfolioLoading ||
            state is AmbassadorPortfolioInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AmbassadorPortfolioFailure) {
          return Center(
            child: Text(state.message, style: Typographies.bodyMedium),
          );
        }
        if (state is AmbassadorPortfolioLoaded) {
          if (state.items.isEmpty) {
            return Center(
              child: Text('No portfolio items.',
                  style: Typographies.bodyMedium.copyWith(color: AppColors.grey)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            itemCount: state.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _PortfolioCard(
              item: state.items[index],
              onTap: () => context.pushNamed(
                AmbassadorPortfolioDetailsPage.tag,
                extra: state.items[index],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.item, required this.onTap});
  final PortfolioItemEntity item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightBg3,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.thumbnailUrl.isNotEmpty)
              Image.network(
                item.thumbnailUrl,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 160,
                  color: AppColors.borderColor,
                  alignment: Alignment.center,
                  child: Icon(Icons.image_outlined, color: AppColors.grey),
                ),
              )
            else
              Container(
                height: 160,
                color: AppColors.borderColor,
                alignment: Alignment.center,
                child: Icon(Icons.image_outlined, color: AppColors.grey, size: 32),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(item.name, style: Typographies.titleSmall),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroAvatar extends StatelessWidget {
  const _HeroAvatar({required this.avatarUrl});
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl == null || avatarUrl!.isEmpty) {
      return Container(
        width: double.infinity, height: 200,
        decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.person, color: AppColors.grey, size: 64),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        avatarUrl!,
        width: double.infinity, height: 200,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: 200,
          color: AppColors.borderColor,
          alignment: Alignment.center,
          child: Icon(Icons.person, color: AppColors.grey, size: 64),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: Typographies.bodySmall),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/presentation/home_page/brand/ui/ambassador_details_page.dart
git commit -m "feat: add AmbassadorDetailsPage with Information and Portfolio tabs"
```

---

## Task 12: Router — 3 ta yangi route

**Files:**
- Modify: `lib/core/router/app_router.dart`

- [ ] **Step 1: Import qo'shish**

`app_router.dart` ga import lar qo'shish:

```dart
import '../../presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_cubit.dart';
import '../../presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_cubit.dart';
import '../../presentation/home_page/brand/ui/ambassadors_filter_page.dart';
import '../../presentation/home_page/brand/ui/ambassador_details_page.dart';
import '../../presentation/home_page/brand/ui/ambassador_portfolio_details_page.dart';
import '../../presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart';
import '../../domain/entities/profile/portfolio_entity.dart';
import '../../presentation/registration/bloc/catalog/category/category_cubit.dart';
import '../../presentation/registration/bloc/catalog/region/region_cubit.dart';
```

- [ ] **Step 2: Route lar qo'shish**

`routes` listiga, `AmbassadorsPage` route dan keyin qo'shish:

```dart
GoRoute(
  path: AmbassadorsFilterPage.tag,
  name: AmbassadorsFilterPage.tag,
  builder: (_, state) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<CategoryCubit>()..getCategory()),
      BlocProvider(create: (_) => sl<RegionCubit>()..getCategories()),
    ],
    child: AmbassadorsFilterPage(
      initial: state.extra as AmbassadorsFilterParams?,
    ),
  ),
),
GoRoute(
  path: AmbassadorDetailsPage.tag,
  name: AmbassadorDetailsPage.tag,
  builder: (_, state) {
    final ambassadorId = state.extra as int;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AmbassadorDetailCubit>()..load(ambassadorId),
        ),
        BlocProvider(
          create: (_) => sl<AmbassadorPortfolioCubit>()..load(ambassadorId),
        ),
      ],
      child: AmbassadorDetailsPage(ambassadorId: ambassadorId),
    );
  },
),
GoRoute(
  path: AmbassadorPortfolioDetailsPage.tag,
  name: AmbassadorPortfolioDetailsPage.tag,
  builder: (_, state) => AmbassadorPortfolioDetailsPage(
    item: state.extra as PortfolioItemEntity,
  ),
),
```

- [ ] **Step 3: Commit**

```bash
git add lib/core/router/app_router.dart
git commit -m "feat: add ambassador filter, details, portfolio-details routes"
```

---

## Task 13: AmbassadorsPage — filter + card tap

**Files:**
- Modify: `lib/presentation/home_page/brand/ui/ambassadors_page.dart`

- [ ] **Step 1: Import qo'shish**

`ambassadors_page.dart` ga import qo'shish:

```dart
import 'package:brandface/presentation/home_page/brand/ui/ambassadors_filter_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassador_details_page.dart';
import 'package:go_router/go_router.dart';
```

- [ ] **Step 2: State ga filter field qo'shish**

`_AmbassadorsPageState` ichiga field qo'shish:

```dart
AmbassadorsFilterParams? _filterParams;
```

- [ ] **Step 3: Filter button ni bog'lash**

Mavjud filter button (`icFilter` li Container) ni `GestureDetector` bilan o'rash:

```dart
GestureDetector(
  onTap: _showFilterPage,
  child: Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: _filterParams != null && !_filterParams!.isEmpty
          ? AppColors.lightGreen
          : AppColors.lightBg3,
      borderRadius: BorderRadius.circular(999),
    ),
    child: Center(child: SvgPicture.asset(AppAssets.icFilter)),
  ),
),
```

- [ ] **Step 4: `_showFilterPage` metod qo'shish**

```dart
Future<void> _showFilterPage() async {
  final cubit = context.read<AmbassadorsCubit>();
  final result = await context.pushNamed<AmbassadorsFilterParams?>(
    AmbassadorsFilterPage.tag,
    extra: _filterParams,
  );
  if (!mounted) return;
  setState(() => _filterParams = result);
  cubit.load(ordering: _sortToOrdering(), filter: result);
}
```

- [ ] **Step 5: `_AmbassadorCard` ga onTap qo'shish**

`_AmbassadorsPageState.build` ichidagi `_AmbassadorCard` widget ni `GestureDetector` bilan o'rash:

```dart
GestureDetector(
  onTap: () => context.pushNamed(
    AmbassadorDetailsPage.tag,
    extra: state.ambassadors[index].id,
  ),
  child: _AmbassadorCard(ambassador: state.ambassadors[index]),
),
```

- [ ] **Step 6: Compile tekshirish**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze --no-fatal-infos 2>&1 | head -40
```

- [ ] **Step 7: Commit**

```bash
git add lib/presentation/home_page/brand/ui/ambassadors_page.dart
git commit -m "feat: wire filter button and card tap in AmbassadorsPage"
```

---

## Task 14: Final compile va smoke test

- [ ] **Step 1: Full analyze**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze --no-fatal-infos 2>&1
```

Expected: `No issues found!` yoki faqat info level xabarlar.

- [ ] **Step 2: Build check**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter build apk --debug 2>&1 | tail -20
```

Expected: `Built build/app/outputs/flutter-apk/app-debug.apk`

- [ ] **Step 3: Final commit (agar kerak)**

```bash
git add -A && git commit -m "feat: ambassador filter, details, and portfolio pages complete"
```
