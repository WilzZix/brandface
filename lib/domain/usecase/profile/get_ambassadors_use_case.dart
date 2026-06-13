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
    int? languageId,
    String? gender,
    int? ageFrom,
    int? ageTo,
    bool? isTop,
    bool? isVip,
    int? followersFrom,
    int? followersTo,
    String? availableDate,
    String? currency,
    int? pricePerHourFrom,
    int? pricePerHourTo,
    String? role,
  }) {
    return repository.getAmbassadors(
      ordering: params,
      categoryId: categoryId,
      regionId: regionId,
      languageId: languageId,
      gender: gender,
      ageFrom: ageFrom,
      ageTo: ageTo,
      isTop: isTop,
      isVip: isVip,
      followersFrom: followersFrom,
      followersTo: followersTo,
      availableDate: availableDate,
      currency: currency,
      pricePerHourFrom: pricePerHourFrom,
      pricePerHourTo: pricePerHourTo,
      role: role,
    );
  }
}
