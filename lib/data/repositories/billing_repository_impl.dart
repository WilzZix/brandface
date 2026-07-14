import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/billing/billing_data_source.dart';
import 'package:brandface/data/models/billing/billing_models.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

final class BillingRepositoryImpl implements IBillingRepository {
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
        _dataSource.getTransactions(),
      ]);

      return Right(
        BillingDashboardModel(
          subscription: results[0] as BillingSubscriptionEntity?,
          plans: results[1] as List<BillingPlanEntity>,
          boostPackages: results[2] as List<BillingBoostPackageEntity>,
          transactions: results[3] as List<BillingTransactionEntity>,
        ),
      );
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<BillingCardEntity>>> getCards() async {
    try {
      final cards = await _dataSource.getCards();
      return Right(cards);
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, CardOtpInitEntity>> initCard(
    InitBillingCardParams params,
  ) async {
    try {
      final result = await _dataSource.initCard(
        InitCardRequest(
          cardNumber: params.cardNumber,
          expiryMonth: params.expiryMonth,
          expiryYear: params.expiryYear,
          cardName: params.cardName,
          phoneNumber: params.phoneNumber,
        ),
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, BillingCardEntity>> confirmCard(
    ConfirmBillingCardParams params,
  ) async {
    try {
      final card = await _dataSource.confirmCard(
        ConfirmCardRequest(
          cardId: params.cardId,
          otp: params.otp,
          cardName: params.cardName,
          isDefault: params.isDefault,
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
        returnUrl: params.returnUrl,
        cardId: params.cardId,
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
        returnUrl: params.returnUrl,
        cardId: params.cardId,
      );
      return Right(subscription);
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, PaylovCheckoutEntity>> getPaylovCheckout(
    PaylovCheckoutParams params,
  ) async {
    try {
      final checkout = await _dataSource.getPaylovCheckout(
        transactionId: params.transactionId,
        returnUrl: params.returnUrl,
      );
      return Right(checkout);
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
