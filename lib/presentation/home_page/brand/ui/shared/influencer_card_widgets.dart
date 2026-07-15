import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/components/avatar/avatar_placeholder.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

/// Green pill toggle — "Influencers" | "Ambassadors"
class InfluencerToggle extends StatelessWidget {
  const InfluencerToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          _ToggleTab(
            label: t.brand.influencers,
            active: selected == 0,
            onTap: () => onChanged(0),
          ),
          _ToggleTab(
            label: t.brand.ambassadors,
            active: selected == 1,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}

class _ToggleTab extends StatelessWidget {
  const _ToggleTab({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: active
                ? Typographies.labelLarge
                : Typographies.bodyMedium
                    .copyWith(color: AppColors.mutedBlack),
          ),
        ),
      ),
    );
  }
}

/// 80×80 avatar with optional TOP badge
class InfluencerAvatar extends StatelessWidget {
  const InfluencerAvatar({super.key, required this.url, required this.isTop});

  final String url;
  final bool isTop;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: url.isNotEmpty
              ? Image.network(
                  url,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, st) => _placeholder(),
                )
              : _placeholder(),
        ),
        if (isTop)
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: const BoxDecoration(
                color: Color(0xFFFF8C00),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(2),
                  topRight: Radius.circular(4),
                ),
              ),
              child: Text(
                t.brand.top_label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _placeholder() =>
      const AvatarPlaceholder(size: 80, borderRadius: 12);
}

/// Small outline chip for categories
class InfluencerChip extends StatelessWidget {
  const InfluencerChip({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: Typographies.bodySmall),
    );
  }
}
