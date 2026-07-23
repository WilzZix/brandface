import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/home_page/brand/ui/widgets/brand_home_primitives.dart';
import 'package:flutter/material.dart';

/// Title, rows and a "Browse all" footer — the shape shared by the Most
/// viewed, VIP, TOP and AI Matching blocks.
///
/// [rows] are already-built [AmbassadorRowCard]s so the two different data
/// sources can each adapt their own entity before handing them over.
class PeopleListSection extends StatelessWidget {
  const PeopleListSection({
    super.key,
    required this.title,
    required this.rows,
    required this.onBrowseAll,
    this.header,
  });

  final String title;
  final List<Widget> rows;
  final VoidCallback onBrowseAll;

  /// Optional control between the title and the rows — the AI Matching block
  /// puts its Influencers/Ambassadors toggle here.
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandSectionTitle(title),
        if (header != null) ...[const SizedBox(height: 16), header!],
        const SizedBox(height: 16),
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) const SizedBox(height: 16),
          rows[i],
        ],
        const SizedBox(height: 24),
        BrowseAllButton(label: t.analytics.browse_all, onTap: onBrowseAll),
      ],
    );
  }
}
