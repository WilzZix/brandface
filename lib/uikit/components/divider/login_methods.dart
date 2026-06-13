import 'package:brandface/presentation/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../domain/entities/social_provider.dart';
import '../../tokens/colors.dart';

class LoginMethods extends StatelessWidget {
  const LoginMethods({super.key});

  static final List<({SocialProvider provider, String icon})> _methods = [
    (provider: SocialProvider.google, icon: AppAssets.icGoogle),
    (provider: SocialProvider.apple, icon: AppAssets.icApple),
    (provider: SocialProvider.telegram, icon: AppAssets.icTelegram),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        final wasBusy = previous.maybeWhen(
          socialAuthInProgress: (_) => true,
          orElse: () => false,
        );
        final isBusy = current.maybeWhen(
          socialAuthInProgress: (_) => true,
          orElse: () => false,
        );
        return wasBusy != isBusy;
      },
      builder: (context, state) {
        final inProgressProvider = state.maybeWhen(
          socialAuthInProgress: (provider) => provider,
          orElse: () => null,
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final m in _methods)
              LoginMethodItem(
                iconPath: m.icon,
                loading: inProgressProvider == m.provider,
                disabled: inProgressProvider != null,
                onTap: () => context.read<LoginBloc>().add(
                      LoginEvent.socialLogin(
                        provider: m.provider,
                        context: context,
                      ),
                    ),
              ),
          ],
        );
      },
    );
  }
}

class LoginMethodItem extends StatelessWidget {
  const LoginMethodItem({
    super.key,
    required this.iconPath,
    required this.onTap,
    this.loading = false,
    this.disabled = false,
  });

  final String iconPath;
  final VoidCallback onTap;
  final bool loading;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final content = loading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : SvgPicture.asset(iconPath);

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Opacity(
        opacity: disabled && !loading ? 0.5 : 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: AppColors.borderColor),
          ),
          child: content,
        ),
      ),
    );
  }
}
