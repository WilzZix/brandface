import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/offer/create_offer_params.dart';
import 'package:brandface/domain/entities/profile/catalog/category_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/city_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/region_entity.dart';
import 'package:brandface/domain/usecase/offer/create_offer_use_case.dart';
import 'package:brandface/presentation/home_page/brand/bloc/create_offer/create_offer_state.dart';

class CreateOfferCubit extends Cubit<CreateOfferState> {
  final CreateOfferUseCase _createOfferUseCase;

  CreateOfferCubit({required CreateOfferUseCase createOfferUseCase})
      : _createOfferUseCase = createOfferUseCase,
        super(const CreateOfferState());

  // Form fields
  String title = '';
  List<CategoryItemEntity> selectedNiches = [];
  String? description;

  String? gender;
  int? ageMin;
  int? ageMax;
  RegionEntity? country;
  CityEntity? city;
  int? followersMin;
  int? followersMax;
  String? engagementRate;

  String? duration;
  DateTime? deadline;
  String? visibility;

  void setTitle(String value) {
    title = value;
  }

  void toggleNiche(CategoryItemEntity category) {
    final exists = selectedNiches.any((n) => n.id == category.id);
    if (exists) {
      selectedNiches = selectedNiches.where((n) => n.id != category.id).toList();
    } else {
      selectedNiches = [...selectedNiches, category];
    }
    emit(state.copyWith(status: state.status));
  }

  void removeNiche(int id) {
    selectedNiches = selectedNiches.where((n) => n.id != id).toList();
    emit(state.copyWith(status: state.status));
  }

  void setDescription(String value) {
    description = value;
  }

  void setGender(String? value) {
    gender = value;
    emit(state.copyWith(status: state.status));
  }

  void setAgeRange(int? min, int? max) {
    ageMin = min;
    ageMax = max;
    emit(state.copyWith(status: state.status));
  }

  void setCountry(RegionEntity? value) {
    country = value;
    emit(state.copyWith(status: state.status));
  }

  void setCity(CityEntity? value) {
    city = value;
    emit(state.copyWith(status: state.status));
  }

  void setFollowersMin(int? value) {
    followersMin = value;
    emit(state.copyWith(status: state.status));
  }

  void setFollowersMax(int? value) {
    followersMax = value;
    emit(state.copyWith(status: state.status));
  }

  void setEngagementRate(String? value) {
    engagementRate = value;
    emit(state.copyWith(status: state.status));
  }

  void setDuration(String? value) {
    duration = value;
    emit(state.copyWith(status: state.status));
  }

  void setDeadline(DateTime? value) {
    deadline = value;
    emit(state.copyWith(status: state.status));
  }

  void setVisibility(String? value) {
    visibility = value;
    emit(state.copyWith(status: state.status));
  }

  Future<void> submit() async {
    emit(const CreateOfferState(status: CreateOfferStatus.loading));

    String? deadlineStr;
    if (deadline != null) {
      deadlineStr =
          '${deadline!.year.toString().padLeft(4, '0')}-${deadline!.month.toString().padLeft(2, '0')}-${deadline!.day.toString().padLeft(2, '0')}';
    }

    final params = CreateOfferParams(
      title: title,
      categoryIds: selectedNiches.map((n) => n.id).toList(),
      description: description,
      requiredGender: gender,
      requiredAgeMin: ageMin,
      requiredAgeMax: ageMax,
      requiredRegion: country?.name,
      requiredCity: city?.name,
      requiredFollowersMin: followersMin,
      requiredFollowersMax: followersMax,
      requiredEngagementRate: engagementRate,
      duration: duration,
      deadline: deadlineStr,
      visibility: visibility,
    );

    final result = await _createOfferUseCase.call(params: params);
    result.fold(
      ifLeft: (failure) => emit(
        CreateOfferState(
          status: CreateOfferStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      ifRight: (_) =>
          emit(const CreateOfferState(status: CreateOfferStatus.success)),
    );
  }
}
