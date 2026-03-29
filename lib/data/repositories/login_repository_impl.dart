import 'package:brandface/data/data_source/network_data_source/network_data_source.dart';
import 'package:brandface/domain/entities/login_entity.dart';
import 'package:brandface/domain/repository/login_repository.dart';
import 'package:dart_either/dart_either.dart';

import 'package:dio/dio.dart';

import '../../core/error/failures.dart';

class LoginRepositoryImpl implements ILoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, OtpEntity>> login({required String phone}) async {
    try {
      // 1. Data Source-dan Model-ni olamiz
      final otpModel = await remoteDataSource.login(phone: phone);

      // 2. Model-ni Entity-ga o'giramiz (Model Entity-dan extend olgan bo'lsa kifoya)
      // Agar Model va Entity maydonlari farq qilsa: otpModel.toEntity() metodini ishlating
      return Right(otpModel.toEntity());
    } on DioException catch (e) {
      // 3. Tarmoq xatolarini Failure-ga o'giramiz
      return Left(ServerFailure(e.message ?? 'Serverda kutilmagan xatolik'));
    } catch (e) {
      // 4. Boshqa kutilmagan xatolar
      return Left(ServerFailure('Tizimda xatolik yuz berdi: ${e.toString()}'));
    }
  }
}
