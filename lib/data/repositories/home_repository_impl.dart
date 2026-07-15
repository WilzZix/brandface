import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/home/home_data_source.dart';
import 'package:brandface/data/models/home/home_dashboard_model.dart';
import 'package:brandface/domain/entities/home/home_dashboard_entity.dart';
import 'package:brandface/domain/repository/home_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

final class HomeRepositoryImpl implements IHomeRepository {
  final HomeDataSource _dataSource;

  HomeRepositoryImpl({required HomeDataSource dataSource})
    : _dataSource = dataSource;

  static const Set<String> _activeStatuses = {
    'pending',
    'viewed',
    'shortlisted',
    'accepted',
  };

  @override
  Future<Either<Failure, HomeDashboardEntity>>
  getInfluencerHomeDashboard() {
    return guard(() async {
      final profile = await _dataSource.getMyProfile();

      final unreadCountFuture = _loadOptionalSection<int>(
        request: _dataSource.getUnreadNotificationsCount,
        fallback: 0,
      );
      final conversationsCountFuture = _loadOptionalSection<int>(
        request: _dataSource.getConversationsCount,
        fallback: 0,
      );
      final statusesFuture = _loadOptionalSection<List<String>>(
        request: _dataSource.getMyApplicationStatuses,
        fallback: const <String>[],
      );
      final recommendationsFuture =
          _loadOptionalSection<List<RecommendedHomeOfferModel>>(
            request: _dataSource.getRecommendedOffers,
            fallback: const <RecommendedHomeOfferModel>[],
          );

      final unreadCount = await unreadCountFuture;
      final conversationsCount = await conversationsCountFuture;
      final statuses = await statusesFuture;
      final recommendations = await recommendationsFuture;

      return HomeDashboardModel(
        profile: profile,
        unreadNotificationsCount: unreadCount,
        activeOffersCount: statuses
            .where((status) => _activeStatuses.contains(status))
            .length,
        messagesCount: conversationsCount,
        recommendations: recommendations,
      );
    });
  }

  Future<T> _loadOptionalSection<T>({
    required Future<T> Function() request,
    required T fallback,
  }) async {
    try {
      return await request();
    } on DioException catch (e) {
      if (_isRecoverableOptionalError(e)) {
        return fallback;
      }
      rethrow;
    } catch (_) {
      return fallback;
    }
  }

  bool _isRecoverableOptionalError(DioException e) {
    final statusCode = e.response?.statusCode;

    if (statusCode == null) {
      return true;
    }

    if (statusCode == 403) {
      final data = e.response?.data;
      final detail = data is Map ? data['detail']?.toString() : null;
      if (detail == 'Your profile has not been approved yet.') {
        return true;
      }
    }

    return statusCode >= 500 || statusCode == 404;
  }
}
