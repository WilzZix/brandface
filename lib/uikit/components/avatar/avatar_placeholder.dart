import 'package:flutter/material.dart';

import '../../tokens/colors.dart';

/// Avatar tanlanmagan / yuklanmagan paytda chiroyli gradient fon + person ikon
/// ko'rsatadi. Doira yoki burchakli kvadrat ko'rinishida ham ishlatiladi.
class AvatarPlaceholder extends StatelessWidget {
  const AvatarPlaceholder({
    super.key,
    this.size = 96,
    this.iconScale = 0.55,
    this.borderRadius,
  }) : shape = borderRadius == null ? BoxShape.circle : BoxShape.rectangle;

  /// Diametr (doira) yoki to'rtburchak tomon o'lchami (px). Cheksiz (Expanded)
  /// kontainerda ishlatish uchun null bo'lishi mumkin emas, lekin parent
  /// SizedBox bilan o'lchovni cheklab qo'yishi mumkin.
  final double size;

  /// Person ikoni avatar diametriga nisbati (0..1).
  final double iconScale;

  /// `null` — yumaloq (BoxShape.circle). Qiymat berilsa to'rtburchak +
  /// border radius. (masalan brand karta 12, ambassador 8.)
  final double? borderRadius;

  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius:
            shape == BoxShape.rectangle && borderRadius != null
                ? BorderRadius.circular(borderRadius!)
                : null,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.28),
            AppColors.lightBg2,
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.person_rounded,
        size: size * iconScale,
        color: AppColors.black.withValues(alpha: 0.55),
      ),
    );
  }
}
