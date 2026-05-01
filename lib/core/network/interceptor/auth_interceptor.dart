import 'dart:async';

import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/core/navigation/app_navigator_key.dart';
import 'package:brandface/presentation/login/ui/login_page.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/services/app_auth_local_service.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final IAuthLocalService _authLocalService;
  Future<String?>? _refreshFuture;
  bool _isShowingUnauthorizedSheet = false;

  AuthInterceptor(this._dio, this._authLocalService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _authLocalService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return super.onError(err, handler);
    }

    final skipDialog =
        err.requestOptions.extra['skipUnauthorizedDialog'] == true;

    // Refresh token request o'zi 401 bersa — cheksiz loop oldini olish
    if (err.requestOptions.path.contains('refresh-token')) {
      if (!skipDialog) await _showUnauthorizedAndLogout();
      return handler.next(err);
    }

    try {
      final newAccess = await _refreshAccessToken();
      if (newAccess == null) {
        if (!skipDialog) await _showUnauthorizedAndLogout();
        return handler.next(err);
      }

      // So'rovni yangi token bilan qayta yuborish
      final opts = err.requestOptions;
      opts.headers['Authorization'] = 'Bearer $newAccess';
      final response = await _dio.fetch(opts);
      return handler.resolve(response);
    } catch (_) {
      if (!skipDialog) await _showUnauthorizedAndLogout();
      return handler.next(err);
    }
  }

  Future<String?> _refreshAccessToken() {
    // Bir vaqtda bir nechta 401 kelsa bitta refresh qilish
    _refreshFuture ??= _doRefresh().whenComplete(() => _refreshFuture = null);
    return _refreshFuture!;
  }

  Future<String?> _doRefresh() async {
    final refreshToken = _authLocalService.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return null;

    final response = await _dio.post(
      ApiRoutes.refreshToken,
      data: {'refresh': refreshToken},
      options: Options(headers: {}), // Authorization header'siz
    );

    final body = response.data;
    // API returns { "message": "...", "data": { "access": "...", "refresh": "..." } }
    // but some versions return { "access": "..." } at root — handle both
    final payload = (body is Map && body['data'] is Map)
        ? Map<String, dynamic>.from(body['data'] as Map)
        : (body is Map ? Map<String, dynamic>.from(body) : <String, dynamic>{});

    final newAccess = payload['access'] as String?;
    if (newAccess == null || newAccess.isEmpty) return null;

    await _authLocalService.saveTokens(
      accessToken: newAccess,
      refreshToken: payload['refresh'] as String? ?? refreshToken,
    );
    return newAccess;
  }

  Future<void> _showUnauthorizedAndLogout() async {
    if (_isShowingUnauthorizedSheet) return;
    _isShowingUnauthorizedSheet = true;

    await _authLocalService.clearCache();

    final context = appNavigatorKey.currentContext;
    if (context == null || !context.mounted) {
      _isShowingUnauthorizedSheet = false;
      return;
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      builder: (_) => const _UnauthorizedBottomSheet(),
    );

    _isShowingUnauthorizedSheet = false;

    final navContext = appNavigatorKey.currentContext;
    if (navContext != null && navContext.mounted) {
      navContext.go(LoginPage.tag);
    }
  }
}

class _UnauthorizedBottomSheet extends StatelessWidget {
  const _UnauthorizedBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        24 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 108,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SizedBox(height: 24),
          Text(t.errors.session_expired, style: Typographies.titleMedium),
          SizedBox(height: 8),
          Text(
            t.errors.redirect_to_login,
            style: Typographies.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.black,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                t.common.ok,
                style: Typographies.labelLarge.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
