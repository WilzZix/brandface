import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/billing/billing_data_source.dart';
import 'package:brandface/data/models/billing/billing_models.dart';
import 'package:brandface/domain/entities/billing/billing_entities.dart';
import 'package:brandface/domain/repository/billing_repository.dart';
import 'package:dart_either/dart_either.dart';

final class BillingRepositoryImpl implements IBillingRepository {
  final BillingDataSource _dataSource;

  BillingRepositoryImpl({required BillingDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<Either<Failure, BillingDashboardEntity>> getBillingDashboard() {
    return guard(() async {
      final results = await Future.wait([
        _dataSource.getMySubscription(),
        _dataSource.getPlans(),
        _dataSource.getBoostPackages(),
        _dataSource.getTransactions(),
      ]);

      return BillingDashboardModel(
        subscription: results[0] as BillingSubscriptionEntity?,
        plans: results[1] as List<BillingPlanEntity>,
        boostPackages: results[2] as List<BillingBoostPackageEntity>,
        transactions: results[3] as List<BillingTransactionEntity>,
      );
    });
  }

  @override
  Future<Either<Failure, List<BillingCardEntity>>> getCards() {
    return guard(() => _dataSource.getCards());
  }

  @override
  Future<Either<Failure, CardOtpInitEntity>> initCard(
    InitBillingCardParams params,
  ) {
    return guard(
      () => _dataSource.initCard(
        InitCardRequest(
          cardNumber: params.cardNumber,
          expiryMonth: params.expiryMonth,
          expiryYear: params.expiryYear,
          cardName: params.cardName,
          phoneNumber: params.phoneNumber,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, BillingCardEntity>> confirmCard(
    ConfirmBillingCardParams params,
  ) {
    return guard(
      () => _dataSource.confirmCard(
        ConfirmCardRequest(
          cardId: params.cardId,
          otp: params.otp,
          cardName: params.cardName,
          isDefault: params.isDefault,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, BillingCardEntity>> setDefaultCard(int cardId) {
    return guard(() => _dataSource.setDefaultCard(cardId));
  }

  @override
  Future<Either<Failure, void>> deleteCard(int cardId) {
    return guard(() => _dataSource.deleteCard(cardId));
  }

  @override
  Future<Either<Failure, BillingSubscriptionEntity>> cancelSubscription() {
    return guard(() => _dataSource.cancelSubscription());
  }

  @override
  Future<Either<Failure, BillingTransactionEntity>> boostProfile(
    BoostProfileParams params,
  ) {
    return guard(
      () => _dataSource.boostProfile(
        packageId: params.packageId,
        paymentMethod: params.paymentMethod,
        returnUrl: params.returnUrl,
        cardId: params.cardId,
      ),
    );
  }

  @override
  Future<Either<Failure, BillingSubscriptionEntity>> subscribeToPlan(
    SubscribeBillingPlanParams params,
  ) {
    return guard(
      () => _dataSource.subscribeToPlan(
        planId: params.planId,
        paymentMethod: params.paymentMethod,
        returnUrl: params.returnUrl,
        cardId: params.cardId,
      ),
    );
  }

  @override
  Future<Either<Failure, PaylovCheckoutEntity>> getPaylovCheckout(
    PaylovCheckoutParams params,
  ) {
    return guard(
      () => _dataSource.getPaylovCheckout(
        transactionId: params.transactionId,
        returnUrl: params.returnUrl,
      ),
    );
  }
}
