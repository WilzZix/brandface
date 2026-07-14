import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:dart_either/dart_either.dart';

import '../../repository/registration_repository.dart';

enum MyProfileSection { general, audience, pricing }

final class UpdateMyProfileSectionParam {
  final MyProfileSection section;
  final Map<String, dynamic> payload;

  UpdateMyProfileSectionParam({required this.section, required this.payload});
}

final class UpdateMyProfileSectionUseCase {
  final IRegistrationRepository repository;

  UpdateMyProfileSectionUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required UpdateMyProfileSectionParam params,
  }) async {
    final url = switch (params.section) {
      .general => ApiRoutes.myProfileGeneral,
      .audience => ApiRoutes.myProfileAudience,
      .pricing => ApiRoutes.myProfilePricing,
    };
    return await repository.updateMyProfileSection(
      url: url,
      payload: params.payload,
    );
  }
}
