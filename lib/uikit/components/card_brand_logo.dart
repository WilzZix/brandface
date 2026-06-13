import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders the brand logo for a payment card.
///
/// Accepts both the backend `card_type` values (visa / mastercard / click)
/// and the locally-detected brands (uzcard / humo) shown live on the add-card
/// form. Backend stores all Uzbek local cards as `click`, so saved cards fall
/// back to the Click logo.
class CardBrandLogo extends StatelessWidget {
  const CardBrandLogo({super.key, required this.brand, this.height = 24});

  final String brand;
  final double height;

  @override
  Widget build(BuildContext context) {
    switch (brand.trim().toLowerCase()) {
      case 'visa':
        return SvgPicture.asset(AppAssets.icVisa, height: height);
      case 'mastercard':
        return _MastercardLogo(height: height);
      case 'uzcard':
        return _Wordmark(
          text: 'uzcard',
          height: height,
          background: const Color(0xFF1AA9A0),
          gradientTo: const Color(0xFF31C7AE),
        );
      case 'humo':
        return _Wordmark(
          text: 'humo',
          height: height,
          background: const Color(0xFFF26522),
          gradientTo: const Color(0xFFF7941D),
        );
      case 'click':
        return _Wordmark(
          text: 'click',
          height: height,
          background: const Color(0xFF00AEEF),
          gradientTo: const Color(0xFF0072BC),
        );
      default:
        return Icon(
          Icons.credit_card_rounded,
          size: height + 4,
          color: AppColors.mutedBlack,
        );
    }
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({
    required this.text,
    required this.height,
    required this.background,
    required this.gradientTo,
  });

  final String text;
  final double height;
  final Color background;
  final Color gradientTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: height * 0.45),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [background, gradientTo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(height * 0.28),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: height * 0.55,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _MastercardLogo extends StatelessWidget {
  const _MastercardLogo({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final circle = height;
    return SizedBox(
      width: circle * 1.55,
      height: circle,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: circle,
              height: circle,
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: circle,
              height: circle,
              decoration: BoxDecoration(
                color: const Color(0xFFF79E1B).withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
