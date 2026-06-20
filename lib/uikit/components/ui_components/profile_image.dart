import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    this.imageUrl,
    this.size = 40,
    this.borderRadius = 8,
  });

  final String? imageUrl;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final raw = imageUrl?.trim();

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: size,
        height: size,
        child: raw == null || raw.isEmpty
            ? const _ProfileImageFallback()
            : _NetworkProfileImage(imageUrl: _absoluteUrl(raw)),
      ),
    );
  }

  static String _absoluteUrl(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) return url;
    if (url.startsWith('/')) return '${ApiRoutes.mediaBaseUrl}$url';
    return '${ApiRoutes.mediaBaseUrl}/$url';
  }
}

class _NetworkProfileImage extends StatelessWidget {
  const _NetworkProfileImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        fit: BoxFit.cover,
        placeholderBuilder: (_) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => const _ProfileImageFallback(),
    );
  }
}

class _ProfileImageFallback extends StatelessWidget {
  const _ProfileImageFallback();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dimension = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : constraints.maxHeight;
        final iconSize = dimension.isFinite ? dimension * 0.55 : 28.0;
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withValues(alpha: 0.28),
                AppColors.lightBg2,
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.person_rounded,
              size: iconSize,
              color: AppColors.black.withValues(alpha: 0.55),
            ),
          ),
        );
      },
    );
  }
}
