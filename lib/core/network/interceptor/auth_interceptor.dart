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
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _handleUnauthorized();
    }
    super.onError(err, handler);
  }

  Future<void> _handleUnauthorized() async {
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
      builder: (_) => _UnauthorizedBottomSheet(),
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
