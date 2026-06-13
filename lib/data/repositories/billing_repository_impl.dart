import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/billing/billing_data_source.dart';
import 'package:brandface/data/models/billing/billing_models.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class BillingRepositoryImpl implements IBillingRepository {
  final BillingDataSource _dataSource;

  BillingRepositoryImpl({required BillingDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, BillingDashboardEntity>> getBillingDashboard() async {
    try {
      final results = await Future.wait([
        _dataSource.getMySubscription(),
        _dataSource.getPlans(),
        _dataSource.getBoostPackages(),
        _dataSource.getCards(),
        _dataSource.getTransactions(),
      ]);

      return Right(
        BillingDashboardModel(
          subscription: results[0] as BillingSubscriptionEntity?,
          plans: results[1] as List<BillingPlanEntity>,
          boostPackages: results[2] as List<BillingBoostPackageEntity>,
          cards: results[3] as List<BillingCardEntity>,
          transactions: results[4] as List<BillingTransactionEntity>,
        ),
      );
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, BillingCardEntity>> addCard(
    AddBillingCardParams params,
  ) async {
    try {
      final card = await _dataSource.addCard(
        AddBillingCardRequest(
          cardType: params.cardType,
          name: params.name,
          expiryMonth: params.expiryMonth,
          expiryYear: params.expiryYear,
          isDefault: params.isDefault,
          gatewayToken: params.gatewayToken,
        ),
      );
      return Right(card);
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, BillingCardEntity>> setDefaultCard(int cardId) async {
    try {
      final card = await _dataSource.setDefaultCard(cardId);
      return Right(card);
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCard(int cardId) async {
    try {
      await _dataSource.deleteCard(cardId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, BillingSubscriptionEntity>>
  cancelSubscription() async {
    try {
      final subscription = await _dataSource.cancelSubscription();
      return Right(subscription);
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, BillingTransactionEntity>> boostProfile(
    BoostProfileParams params,
  ) async {
    try {
      final transaction = await _dataSource.boostProfile(
        packageId: params.packageId,
        paymentMethod: params.paymentMethod,
      );
      return Right(transaction);
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, BillingSubscriptionEntity>> subscribeToPlan(
    SubscribeBillingPlanParams params,
  ) async {
    try {
      final subscription = await _dataSource.subscribeToPlan(
        planId: params.planId,
        paymentMethod: params.paymentMethod,
        cardId: params.cardId,
      );
      return Right(subscription);
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  ServerFailure _mapFailure(DioException e) {
    final responseData = e.response?.data;
    String message = e.message ?? 'Serverda xatolik yuz berdi';

    if (responseData is Map && responseData['message'] != null) {
      message = responseData['message'].toString();
    } else if (responseData is Map && responseData['detail'] != null) {
      message = responseData['detail'].toString();
    }

    return ServerFailure(
      message,
      statusCode: e.response?.statusCode,
      errorData: responseData,
    );
  }
}
