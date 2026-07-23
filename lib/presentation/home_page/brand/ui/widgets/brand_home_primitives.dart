import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

/// Section heading on the brand home page ("Brand Activity Summary", …).
class BrandSectionTitle extends StatelessWidget {
  const BrandSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) =>
      Text(title, style: Typographies.titleLarge);
}

/// A single "value over label" tile — the repeating unit of every stat grid in
/// the design.
class BrandStatTile extends StatelessWidget {
  const BrandStatTile({
    super.key,
    required this.value,
    required this.label,
    this.onTap,
    this.valueStyle,
    this.valueMaxLines = 1,
  });

  final String value;
  final String label;
  final VoidCallback? onTap;

  /// Defaults to the design's large counter style. Tiles whose value is a
  /// sentence rather than a number (age group, country mix) pass a smaller one.
  final TextStyle? valueStyle;
  final int valueMaxLines;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.lightBg3,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: valueStyle ?? Typographies.titleLarge,
              maxLines: valueMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Typographies.bodySmall.copyWith(
                color: AppColors.mutedBlack,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Lays [tiles] out two per row. Rows are intrinsically sized rather than a
/// fixed aspect ratio, so a label that wraps to two lines grows its row
/// instead of being clipped.
class BrandStatGrid extends StatelessWidget {
  const BrandStatGrid({super.key, required this.tiles, this.spacing = 8});

  final List<Widget> tiles;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < tiles.length; i += 2) {
      final left = tiles[i];
      final right = i + 1 < tiles.length ? tiles[i + 1] : null;
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: left),
              SizedBox(width: spacing),
              Expanded(child: right ?? const SizedBox.shrink()),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) SizedBox(height: spacing),
          rows[i],
        ],
      ],
    );
  }
}

/// Full-width outlined pill closing each people block.
class BrowseAllButton extends StatelessWidget {
  const BrowseAllButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Center(child: Text(label, style: Typographies.labelLarge)),
      ),
    );
  }
}

/// Bordered pill used for the period and PDF controls in Offer Performance.
class BrandPillButton extends StatelessWidget {
  const BrandPillButton({
    super.key,
    required this.label,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String label;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 8)],
            // Flexible, not a bare Text: translated labels are much longer
            // than the English ones and would otherwise overflow the pill.
            Flexible(
              child: Text(
                label,
                style: Typographies.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 8), trailing!],
          ],
        ),
      ),
    );
  }
}

/// Placeholder shown while a home-page block is still loading, so the page
/// keeps its shape instead of jumping when data lands.
class BrandBlockSkeleton extends StatelessWidget {
  const BrandBlockSkeleton({super.key, this.height = 96});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
