import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/entities/profile/profile_entity.dart';
import 'package:brandface/domain/entities/profile/review_entity.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_detail/ambassador_detail_state.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassador_portfolio/ambassador_portfolio_state.dart';
import 'package:brandface/presentation/home_page/brand/ui/ambassador_portfolio_details_page.dart';
import 'package:brandface/presentation/home_page/brand/ui/send_enquiry_page.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AmbassadorDetailsPage extends StatelessWidget {
  const AmbassadorDetailsPage({super.key, required this.ambassadorId});

  static const String tag = '/ambassador-details';

  final int ambassadorId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmbassadorDetailCubit, AmbassadorDetailState>(
      builder: (context, state) {
        if (state is AmbassadorDetailLoading || state is AmbassadorDetailInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is AmbassadorDetailFailure) {
          return Scaffold(
            backgroundColor: AppColors.lightBg,
            appBar: AppBar(backgroundColor: AppColors.lightBg),
            body: Center(
              child: Text(state.message, style: Typographies.bodyMedium),
            ),
          );
        }
        final detail = (state as AmbassadorDetailLoaded).detail;
        return _DetailsScaffold(detail: detail);
      },
    );
  }
}

class _DetailsScaffold extends StatelessWidget {
  const _DetailsScaffold({required this.detail});

  final AmbassadorDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        appBar: AppBar(
          backgroundColor: AppColors.lightBg,
          scrolledUnderElevation: 0,
          title: Text('Ambassador details', style: Typographies.titleMedium),
          centerTitle: false,
          bottom: TabBar(
            labelStyle: Typographies.labelLarge,
            unselectedLabelStyle: Typographies.bodyMedium,
            indicatorColor: AppColors.primaryDark,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.grey,
            tabs: const [
              Tab(text: 'Information'),
              Tab(text: 'For Brands'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _InformationTab(detail: detail),
            _ForBrandsTab(detail: detail),
          ],
        ),
      ),
    );
  }
}

// ─── TAB 1: INFORMATION ──────────────────────────────────────────────────────

class _InformationTab extends StatelessWidget {
  const _InformationTab({required this.detail});

  final AmbassadorDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroAvatar(avatarUrl: detail.avatarUrl),
          const SizedBox(height: 16),
          _NameRow(detail: detail),
          const SizedBox(height: 6),
          _RatingRow(detail: detail),
          if (detail.contacts.isNotEmpty) ...[
            const SizedBox(height: 16),
            _SectionTitle('Contact details'),
            const SizedBox(height: 8),
            AppContainer(child: _ContactList(contacts: detail.contacts)),
          ],
          if (detail.bio != null && detail.bio!.isNotEmpty) ...[
            const SizedBox(height: 16),
            _SectionTitle('General information'),
            const SizedBox(height: 8),
            AppContainer(
              child: Text(detail.bio!, style: Typographies.bodyMedium),
            ),
          ],
          if (detail.categories.isNotEmpty || detail.services.isNotEmpty) ...[
            const SizedBox(height: 16),
            _SectionTitle('Work'),
            const SizedBox(height: 8),
            if (detail.categories.isNotEmpty) ...[
              Text('Categories', style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
              const SizedBox(height: 6),
              _ChipWrap(items: detail.categories),
              const SizedBox(height: 10),
            ],
            if (detail.services.isNotEmpty) ...[
              Text('Services', style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
              const SizedBox(height: 6),
              _ChipWrap(items: detail.services),
            ],
          ],
          if (detail.audience != null) ...[
            const SizedBox(height: 16),
            _SectionTitle('Audience and followers'),
            const SizedBox(height: 8),
            _AudienceSection(audience: detail.audience!),
          ],
          if (detail.yearsOfExperience != null ||
              detail.partners.isNotEmpty ||
              detail.awards.isNotEmpty) ...[
            const SizedBox(height: 16),
            _SectionTitle('Experience'),
            const SizedBox(height: 8),
            _ExperienceSection(detail: detail),
          ],
          if (detail.reviews.isNotEmpty) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SectionTitle('Reviews'),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    'See all',
                    style: Typographies.bodySmall.copyWith(color: AppColors.primaryDark),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _ReviewsRow(reviews: detail.reviews),
          ],
          if (detail.audience?.socialMediaAccounts != null &&
              detail.audience!.socialMediaAccounts!.isNotEmpty) ...[
            const SizedBox(height: 16),
            _PortfolioTabSection(),
          ],
        ],
      ),
    );
  }
}

class _NameRow extends StatelessWidget {
  const _NameRow({required this.detail});
  final AmbassadorDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            detail.displayName ?? '—',
            style: Typographies.titleLarge,
          ),
        ),
        if (detail.isVerified) ...[
          const SizedBox(width: 6),
          Icon(Icons.check_circle, color: AppColors.primaryDark, size: 22),
        ],
        if (detail.isTop) ...[
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('TOP', style: Typographies.labelSmall.copyWith(color: Colors.white)),
          ),
        ],
        if (detail.isVip) ...[
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('VIP', style: Typographies.labelSmall.copyWith(color: Colors.white)),
          ),
        ],
      ],
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({required this.detail});
  final AmbassadorDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          color: detail.averageRating != null ? AppColors.orange : AppColors.grey,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          detail.averageRating != null
              ? detail.averageRating!.toStringAsFixed(2)
              : '—',
          style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
        ),
        const SizedBox(width: 8),
        Text(
          '${detail.totalReviews} reviews',
          style: Typographies.bodySmall.copyWith(color: AppColors.grey),
        ),
      ],
    );
  }
}

class _ContactList extends StatelessWidget {
  const _ContactList({required this.contacts});
  final List<ContactEntity> contacts;

  IconData _iconFor(String? type) {
    switch (type?.toLowerCase()) {
      case 'phone':
        return Icons.phone_outlined;
      case 'instagram':
        return Icons.camera_alt_outlined;
      case 'telegram':
        return Icons.telegram;
      case 'linkedin':
        return Icons.link;
      case 'youtube':
        return Icons.play_circle_outline;
      case 'tiktok':
        return Icons.music_note_outlined;
      default:
        return Icons.link;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contacts.map((c) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Icon(_iconFor(c.type), color: AppColors.grey, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  c.value ?? '—',
                  style: Typographies.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _AudienceSection extends StatelessWidget {
  const _AudienceSection({required this.audience});
  final AudienceEntity audience;

  String _formatFollowers(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    final hasDemographics = audience.malePercent != null ||
        audience.femalePercent != null ||
        audience.menAgeFrom != null ||
        audience.womenAgeFrom != null;
    final hasGeo = audience.geography != null && audience.geography!.isNotEmpty;
    final hasFollowers = audience.totalFollowers != null;
    final hasAccounts = audience.socialMediaAccounts != null &&
        audience.socialMediaAccounts!.isNotEmpty;

    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasDemographics) ...[
            Text('Demographics', style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (audience.malePercent != null)
                  _DemoChip(
                    label: '${audience.malePercent}% male'
                        '${audience.menAgeFrom != null && audience.menAgeTo != null ? ', age ${audience.menAgeFrom}–${audience.menAgeTo}' : ''}',
                    icon: Icons.male,
                  ),
                if (audience.femalePercent != null)
                  _DemoChip(
                    label: '${audience.femalePercent}% female'
                        '${audience.womenAgeFrom != null && audience.womenAgeTo != null ? ', age ${audience.womenAgeFrom}–${audience.womenAgeTo}' : ''}',
                    icon: Icons.female,
                  ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          if (hasGeo) ...[
            Text('Geography', style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 6),
            Text(audience.geography!.join(', '), style: Typographies.bodyMedium),
            const SizedBox(height: 12),
          ],
          if (hasFollowers) ...[
            Text('Total number of followers', style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 4),
            Text(
              _formatFollowers(audience.totalFollowers!),
              style: Typographies.titleSmall,
            ),
            const SizedBox(height: 12),
          ],
          if (hasAccounts) ...[
            Text('Accounts', style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 8),
            ...audience.socialMediaAccounts!.map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(Icons.alternate_email, size: 14, color: AppColors.grey),
                      const SizedBox(width: 4),
                      Text(a.username, style: Typographies.bodyMedium),
                      const Spacer(),
                      Text(a.platform, style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }
}

class _DemoChip extends StatelessWidget {
  const _DemoChip({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.mutedBlack),
          const SizedBox(width: 4),
          Text(label, style: Typographies.bodySmall),
        ],
      ),
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection({required this.detail});
  final AmbassadorDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (detail.yearsOfExperience != null) ...[
            _InfoRow(
              label: 'Years of experience',
              value: '${detail.yearsOfExperience} years',
            ),
            const SizedBox(height: 12),
          ],
          if (detail.partners.isNotEmpty) ...[
            Text('List of partners', style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 6),
            ...detail.partners.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        margin: const EdgeInsets.only(right: 8, top: 1),
                        decoration: BoxDecoration(
                          color: AppColors.mutedBlack,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(p, style: Typographies.bodyMedium),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
          ],
          if (detail.awards.isNotEmpty) ...[
            Text('Projects', style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 6),
            ...detail.awards.map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(Icons.emoji_events_outlined, size: 16, color: AppColors.orange),
                      const SizedBox(width: 6),
                      Expanded(child: Text(a.title, style: Typographies.bodyMedium)),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
        Text(value, style: Typographies.bodyMedium),
      ],
    );
  }
}

class _ReviewsRow extends StatelessWidget {
  const _ReviewsRow({required this.reviews});
  final List<ReviewEntity> reviews;

  @override
  Widget build(BuildContext context) {
    final shown = reviews.take(4).toList();
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: shown.length,
        separatorBuilder: (c, i) => const SizedBox(width: 12),
        itemBuilder: (_, i) => _ReviewCard(review: shown[i]),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final ReviewEntity review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ...List.generate(
                5,
                (i) => Icon(
                  i < review.rating ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: AppColors.orange,
                  size: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            review.text.isEmpty ? 'No comment' : review.text,
            style: Typographies.bodySmall,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            review.reviewerName,
            style: Typographies.bodySmall.copyWith(
              color: AppColors.mutedBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PortfolioTabSection extends StatelessWidget {
  const _PortfolioTabSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmbassadorPortfolioCubit, AmbassadorPortfolioState>(
      builder: (context, state) {
        if (state is AmbassadorPortfolioLoaded && state.items.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle('Portfolio'),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.items.length > 3 ? 3 : state.items.length,
                separatorBuilder: (c, i) => const SizedBox(height: 12),
                itemBuilder: (context, index) => _PortfolioCard(
                  item: state.items[index],
                  onTap: () => context.pushNamed(
                    AmbassadorPortfolioDetailsPage.tag,
                    extra: state.items[index],
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// ─── TAB 2: FOR BRANDS ───────────────────────────────────────────────────────

class _ForBrandsTab extends StatelessWidget {
  const _ForBrandsTab({required this.detail});

  final AmbassadorDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle('Pricing / Tariffs'),
                const SizedBox(height: 8),
                _PricingSection(pricing: detail.pricing),
                if (detail.availableDates.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _SectionTitle('Available dates'),
                  const SizedBox(height: 8),
                  _AvailableDatesSection(dates: detail.availableDates),
                ],
                // Portfolio tab in For Brands if not in information
                const SizedBox(height: 16),
                _SectionTitle('Portfolio'),
                const SizedBox(height: 8),
                _PortfolioForBrandsSection(),
              ],
            ),
          ),
        ),
        _BottomButtons(ambassadorId: detail.id),
      ],
    );
  }
}

class _PricingSection extends StatelessWidget {
  const _PricingSection({required this.pricing});
  final PricingEntity? pricing;

  @override
  Widget build(BuildContext context) {
    final p = pricing;
    if (p == null) {
      return AppContainer(
        child: Text(
          'No pricing information available.',
          style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
        ),
      );
    }

    final rows = <Widget>[];

    void addRow(String label, String? value) {
      if (value == null || value.isEmpty || value == 'null') return;
      rows.add(Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            Text(value, style: Typographies.bodyMedium),
          ],
        ),
      ));
    }

    void addBoolRow(String label, bool? value) {
      if (value == null) return;
      addRow(label, value ? 'Yes' : 'No');
    }

    if (p.hourlyRateMinUzs != null || p.hourlyRateMaxUzs != null) {
      final min = p.hourlyRateMinUzs ?? '—';
      final max = p.hourlyRateMaxUzs ?? '—';
      addRow('Hourly rate (UZS)', '$min – $max');
    }
    if (p.hourlyRateMinUsd != null || p.hourlyRateMaxUsd != null) {
      final min = p.hourlyRateMinUsd ?? '—';
      final max = p.hourlyRateMaxUsd ?? '—';
      addRow('Hourly rate (USD)', '\$$min – \$$max');
    }
    if (p.dailyRateMinUzs != null || p.dailyRateMaxUzs != null) {
      final min = p.dailyRateMinUzs ?? '—';
      final max = p.dailyRateMaxUzs ?? '—';
      addRow('Daily rate (UZS)', '$min – $max');
    }
    if (p.campaignFee != null) {
      final currency = p.campaignFeeCurrency ?? '';
      addRow('Campaign fee', '${p.campaignFee} $currency'.trim());
    }
    addRow('Event appearance fee', p.eventAppearanceFee);
    addRow('Monthly exclusivity fee', p.monthlyExclusivityFee);
    if (p.monthlyContentCapacity != null) {
      addRow('Monthly content capacity', '${p.monthlyContentCapacity} posts');
    }
    addBoolRow('Accepts barter', p.acceptsBarter);
    addBoolRow('Available for long term', p.availableForLongTerm);
    addBoolRow('Available for offline events', p.availableForOfflineEvents);
    addBoolRow('KPI-based model', p.kpiBasedModel);
    addBoolRow('Exclusivity available', p.exclusivityAvailable);

    if (rows.isEmpty) {
      return AppContainer(
        child: Text(
          'No pricing information available.',
          style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
        ),
      );
    }

    return AppContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows));
  }
}

class _AvailableDatesSection extends StatelessWidget {
  const _AvailableDatesSection({required this.dates});
  final List<AvailableDateItem> dates;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dates.map((d) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.grey),
                  const SizedBox(width: 8),
                  Text(
                    '${d.dateFrom}  –  ${d.dateTo}',
                    style: Typographies.bodyMedium,
                  ),
                  if (d.note != null && d.note!.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        d.note!,
                        style: Typographies.bodySmall.copyWith(color: AppColors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            )).toList(),
      ),
    );
  }
}

class _PortfolioForBrandsSection extends StatelessWidget {
  const _PortfolioForBrandsSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmbassadorPortfolioCubit, AmbassadorPortfolioState>(
      builder: (context, state) {
        if (state is AmbassadorPortfolioLoading || state is AmbassadorPortfolioInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AmbassadorPortfolioLoaded) {
          if (state.items.isEmpty) {
            return AppContainer(
              child: Text(
                'No portfolio items.',
                style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
              ),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.items.length,
            separatorBuilder: (c, i) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _PortfolioCard(
              item: state.items[index],
              onTap: () => context.pushNamed(
                AmbassadorPortfolioDetailsPage.tag,
                extra: state.items[index],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _BottomButtons extends StatelessWidget {
  const _BottomButtons({required this.ambassadorId});
  final int ambassadorId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                context.showAppSnackBar('Coming soon');
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.borderColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text('Add to Contact Base', style: Typographies.labelLarge),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => context.pushNamed(
                SendEnquiryPage.tag,
                extra: SendEnquiryArguments(otherUserId: ambassadorId),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Send Enquiry',
                style: Typographies.labelLarge.copyWith(color: AppColors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── SHARED WIDGETS ──────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Typographies.titleSmall);
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: items.map((item) => _Chip(label: item)).toList(),
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.item, required this.onTap});

  final PortfolioItemEntity item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightBg3,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.thumbnailUrl.isNotEmpty)
              Image.network(
                item.thumbnailUrl,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, st) => Container(
                  height: 160,
                  color: AppColors.borderColor,
                  alignment: Alignment.center,
                  child: Icon(Icons.image_outlined, color: AppColors.grey),
                ),
              )
            else
              Container(
                height: 160,
                color: AppColors.borderColor,
                alignment: Alignment.center,
                child: Icon(Icons.image_outlined, color: AppColors.grey, size: 32),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(item.name, style: Typographies.titleSmall),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroAvatar extends StatelessWidget {
  const _HeroAvatar({required this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl == null || avatarUrl!.isEmpty) {
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.person, color: AppColors.grey, size: 64),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        avatarUrl!,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (ctx, err, st) => Container(
          height: 200,
          color: AppColors.borderColor,
          alignment: Alignment.center,
          child: Icon(Icons.person, color: AppColors.grey, size: 64),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: Typographies.bodySmall),
    );
  }
}
