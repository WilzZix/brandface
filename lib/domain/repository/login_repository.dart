import 'package:brandface/domain/entities/login_entity.dart';
import 'package:dart_either/dart_either.dart';

import '../../core/error/failures.dart';

abstract class ILoginRepository {
  Future<Either<Failures, OtpEntity>> login({required String phone});
}
