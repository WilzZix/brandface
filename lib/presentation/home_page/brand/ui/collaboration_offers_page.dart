import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/offer/offer_summary_entity.dart';
import 'package:brandface/presentation/home_page/brand/bloc/collaboration_offers_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/collaboration_offers_state.dart';
import 'package:brandface/presentation/home_page/brand/ui/brand_offer_detail_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/create_offer_page.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_assets.dart';

class CollaborationOffersPage extends StatefulWidget {
  const CollaborationOffersPage({super.key});

  static String tag = '/collaboration_offers_page';

  @override
  State<CollaborationOffersPage> createState() =>
      _CollaborationOffersPageState();
}

enum _SortOption { views, applications }

class _CollaborationOffersPageState extends State<CollaborationOffersPage> {
  bool _isActiveTab = true;
  _SortOption _sortOption = _SortOption.views;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showSortSheet() async {
    final selected = await showModalBottomSheet<_SortOption>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _SortBottomSheet(current: _sortOption),
    );
    if (selected != null && selected != _sortOption) {
      setState(() => _sortOption = selected);
    }
  }

  void _switchTab(bool isActive) {
    if (_isActiveTab == isActive) return;
    setState(() => _isActiveTab = isActive);
    _searchController.clear();
    if (isActive) {
      context.read<CollaborationOffersCubit>().loadActive();
    } else {
      context.read<CollaborationOffersCubit>().loadArchived();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.brand.collaboration_offers),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () async {
              await context.push(CreateOfferPage.tag);
              if (context.mounted) {
                context.read<CollaborationOffersCubit>().loadActive();
              }
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: SvgPicture.asset(AppAssets.icAdd),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.lightBg2,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (q) =>
                          context.read<CollaborationOffersCubit>().search(q),
                      decoration: InputDecoration(
                        hintText: t.brand.search,
                        hintStyle: Typographies.bodyMedium.copyWith(
                          color: AppColors.grey,
                        ),
                        prefixIcon: Icon(Icons.search, color: AppColors.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _showSortSheet,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(child: SvgPicture.asset(AppAssets.icSort)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                BlocBuilder<CollaborationOffersCubit, CollaborationOffersState>(
                  builder: (context, state) {
                    int activeCount = 0;
                    int archivedCount = 0;
                    if (state is CollaborationOffersLoaded) {
                      if (_isActiveTab) {
                        activeCount = state.offers.length;
                      } else {
                        archivedCount = state.offers.length;
                      }
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: _TabButton(
                            label: '${t.brand.actives} ($activeCount)',
                            isSelected: _isActiveTab,
                            onTap: () => _switchTab(true),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _TabButton(
                            label: '${t.brand.archived} ($archivedCount)',
                            isSelected: !_isActiveTab,
                            onTap: () => _switchTab(false),
                          ),
                        ),
                      ],
                    );
                  },
                ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child:
                BlocBuilder<CollaborationOffersCubit, CollaborationOffersState>(
                  builder: (context, state) {
                    if (state is CollaborationOffersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is CollaborationOffersFailure) {
                      return Center(
                        child: Text(
                          state.message,
                          style: Typographies.bodyMedium.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      );
                    }
                    if (state is CollaborationOffersLoaded) {
                      if (state.offers.isEmpty) {
                        return Center(
                          child: Text(
                            _isActiveTab
                                ? t.brand.no_active_campaigns_yet
                                : t.brand.archived,
                            style: Typographies.bodyMedium.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                        );
                      }
                      final sorted = [...state.offers]..sort(
                          _sortOption == _SortOption.views
                              ? (a, b) => b.viewsCount.compareTo(a.viewsCount)
                              : (a, b) => b.applicationsCount.compareTo(a.applicationsCount),
                        );
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: sorted.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => context.push(
                            BrandOfferDetailPage.tag,
                            extra: sorted[index].id,
                          ),
                          child: _OfferCard(offer: sorted[index]),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.lightBg3,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Center(
          child: Text(
            label,
            style: Typographies.labelMedium.copyWith(
              color: isSelected ? AppColors.black : AppColors.mutedBlack,
            ),
          ),
        ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.offer});

  final OfferSummaryEntity offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.title,
                  style: Typographies.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _StatColumn(
                      label: t.brand.views,
                      value: _formatCount(offer.viewsCount),
                    ),
                    const SizedBox(width: 24),
                    _StatColumn(
                      label: t.brand.applications,
                      value: _formatCount(offer.applicationsCount),
                      highlight: offer.applicationsCount > 0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: AppColors.mutedBlack),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }
}

class _SortBottomSheet extends StatelessWidget {
  const _SortBottomSheet({required this.current});

  final _SortOption current;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Sort by', style: Typographies.titleMedium),
            const SizedBox(height: 8),
            _SortTile(
              label: 'Sort by views',
              selected: current == _SortOption.views,
              onTap: () => Navigator.of(context).pop(_SortOption.views),
            ),
            _SortTile(
              label: 'Sort by applications',
              selected: current == _SortOption.applications,
              onTap: () => Navigator.of(context).pop(_SortOption.applications),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _SortTile extends StatelessWidget {
  const _SortTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Typographies.bodyMedium),
            if (selected) Icon(Icons.check, color: AppColors.primaryDark, size: 20),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Typographies.titleSmall.copyWith(
            color: highlight ? AppColors.primaryDark : AppColors.black,
          ),
        ),
      ],
    );
  }
}
