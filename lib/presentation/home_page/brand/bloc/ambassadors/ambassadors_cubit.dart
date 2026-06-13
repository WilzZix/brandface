import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/profile/ambassador_entity.dart';
import 'package:brandface/domain/usecase/profile/get_ambassadors_use_case.dart';
import 'ambassadors_state.dart';

class AmbassadorsFilterParams {
  final int? categoryId;
  final int? regionId;
  final int? languageId;
  final String? gender;
  final int? ageFrom;
  final int? ageTo;
  final bool? isTop;
  final bool? isVip;
  final int? followersFrom;
  final int? followersTo;
  final String? availableDate; // YYYY-MM-DD
  final String? currency; // 'UZS' | 'USD'
  final int? pricePerHourFrom;
  final int? pricePerHourTo;

  const AmbassadorsFilterParams({
    this.categoryId,
    this.regionId,
    this.languageId,
    this.gender,
    this.ageFrom,
    this.ageTo,
    this.isTop,
    this.isVip,
    this.followersFrom,
    this.followersTo,
    this.availableDate,
    this.currency,
    this.pricePerHourFrom,
    this.pricePerHourTo,
  });

  bool get isEmpty =>
      categoryId == null &&
      regionId == null &&
      languageId == null &&
      (gender == null || gender == 'any') &&
      ageFrom == null &&
      ageTo == null &&
      isTop != true &&
      isVip != true &&
      followersFrom == null &&
      followersTo == null &&
      availableDate == null &&
      currency == null &&
      pricePerHourFrom == null &&
      pricePerHourTo == null;
}

class AmbassadorsCubit extends Cubit<AmbassadorsState> {
  final GetAmbassadorsUseCase _useCase;
  List<AmbassadorEntity> _allAmbassadors = [];
  String? _role;

  AmbassadorsCubit({required GetAmbassadorsUseCase getAmbassadorsUseCase})
      : _useCase = getAmbassadorsUseCase,
        super(AmbassadorsInitial());

  void setRole(String? role) => _role = role;

  Future<void> load({
    String? ordering,
    AmbassadorsFilterParams? filter,
    String? role,
  }) async {
    if (role != null) _role = role;
    emit(AmbassadorsLoading());
    final result = await _useCase.call(
      params: ordering,
      categoryId: filter?.categoryId,
      regionId: filter?.regionId,
      languageId: filter?.languageId,
      gender: filter?.gender,
      ageFrom: filter?.ageFrom,
      ageTo: filter?.ageTo,
      isTop: filter?.isTop,
      isVip: filter?.isVip,
      followersFrom: filter?.followersFrom,
      followersTo: filter?.followersTo,
      availableDate: filter?.availableDate,
      currency: filter?.currency,
      pricePerHourFrom: filter?.pricePerHourFrom,
      pricePerHourTo: filter?.pricePerHourTo,
      role: _role,
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
