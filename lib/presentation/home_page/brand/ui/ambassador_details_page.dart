import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/entities/profile/profile_entity.dart';
import 'package:brandface/domain/entities/profile/review_entity.dart';
import 'package:brandface/domain/repository/favourites_repository.dart';
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
          title: Text(t.ambassador.ambassador_details, style: Typographies.titleMedium),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NameRow(detail: detail),
                  const SizedBox(height: 12),
                  _TabPills(),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _InformationTab(detail: detail),
            _PortfolioTab(),
          ],
        ),
        bottomNavigationBar: _BottomButtons(ambassadorId: detail.id),
      ),
    );
  }
}

class _TabPills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        final selected = controller.index;
        return Row(
          children: [
            Expanded(child: _PillTab(label: t.ambassador.information, isActive: selected == 0, onTap: () => controller.animateTo(0))),
            const SizedBox(width: 8),
            Expanded(child: _PillTab(label: t.profile.portfolio, isActive: selected == 1, onTap: () => controller.animateTo(1))),
          ],
        );
      },
    );
  }
}

class _PillTab extends StatelessWidget {
  const _PillTab({required this.label, required this.isActive, required this.onTap});
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.lightBg,
          border: Border.all(color: isActive ? AppColors.primary : AppColors.borderColor),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: Typographies.labelLarge.copyWith(
            color: isActive ? AppColors.black : AppColors.mutedBlack,
          ),
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(t.profile.general_info),
          const SizedBox(height: 8),
          AppContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (detail.contacts.isNotEmpty) ...[
                  Text(t.registration.contact_details,
                      style: Typographies.titleSmall.copyWith(color: AppColors.mutedBlack)),
                  const SizedBox(height: 8),
                  _ContactList(contacts: detail.contacts),
                  const SizedBox(height: 12),
                ],
                if (detail.bio != null && detail.bio!.trim().isNotEmpty) ...[
                  Text(t.registration.profile_information,
                      style: Typographies.titleSmall.copyWith(color: AppColors.mutedBlack)),
                  const SizedBox(height: 4),
                  Text(detail.bio!, style: Typographies.bodyMedium),
                ],
                if (detail.contacts.isEmpty &&
                    (detail.bio == null || detail.bio!.trim().isEmpty))
                  Text(t.ambassador.no_information_provided,
                      style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack)),
              ],
            ),
          ),
          if (detail.categories.isNotEmpty) ...[
            const SizedBox(height: 16),
            _SectionTitle(t.ambassador.niche),
            const SizedBox(height: 8),
            AppContainer(child: _ChipWrap(items: detail.categories)),
          ],
          if (detail.services.isNotEmpty) ...[
            const SizedBox(height: 16),
            _SectionTitle(t.registration.services),
            const SizedBox(height: 8),
            AppContainer(child: _ChipWrap(items: detail.services)),
          ],
          if (detail.audience != null) ...[
            const SizedBox(height: 16),
            _SectionTitle(t.profile.audience_and_followers),
            const SizedBox(height: 8),
            _AudienceSection(audience: detail.audience!),
          ],
          if (detail.yearsOfExperience != null ||
              detail.partners.isNotEmpty ||
              detail.awards.isNotEmpty) ...[
            const SizedBox(height: 16),
            _SectionTitle(t.profile.experience),
            const SizedBox(height: 8),
            _ExperienceSection(detail: detail),
          ],
          if (detail.reviews.isNotEmpty) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SectionTitle(t.reviews.title),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    t.notifications.read_all,
                    style: Typographies.bodySmall.copyWith(color: AppColors.primaryDark),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _ReviewsRow(reviews: detail.reviews),
          ],
          const SizedBox(height: 16),
          _SectionTitle(t.profile.pricing_tariffs),
          const SizedBox(height: 8),
          _PricingSection(pricing: detail.pricing),
          if (detail.availableDates.isNotEmpty) ...[
            const SizedBox(height: 16),
            _SectionTitle(t.ambassador.available_dates),
            const SizedBox(height: 8),
            _AvailableDatesSection(dates: detail.availableDates),
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
        if (detail.isVerified) ...[
          Icon(Icons.check_circle, color: AppColors.primaryDark, size: 22),
          const SizedBox(width: 6),
        ],
        Expanded(
          child: Text(
            detail.displayName ?? '—',
            style: Typographies.titleLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (detail.isTop) ...[
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(t.brand.top_label, style: Typographies.labelSmall.copyWith(color: Colors.white)),
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
            child: Text(t.brand.vip_label, style: Typographies.labelSmall.copyWith(color: Colors.white)),
          ),
        ],
        const SizedBox(width: 8),
        Icon(
          Icons.star_rounded,
          color: detail.averageRating != null ? AppColors.orange : AppColors.grey,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          detail.averageRating != null ? detail.averageRating!.toStringAsFixed(2) : '—',
          style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
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

  String _labelFor(String? type) {
    switch (type?.toLowerCase()) {
      case 'phone':
        return t.contact.phone;
      case 'instagram':
        return t.contact.instagram;
      case 'telegram':
        return t.contact.telegram;
      case 'linkedin':
        return 'LinkedIn';
      case 'youtube':
        return 'YouTube';
      case 'tiktok':
        return 'TikTok';
      default:
        return type ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contacts.map((c) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: [
              Icon(_iconFor(c.type), color: AppColors.grey, size: 16),
              const SizedBox(width: 8),
              Text('${_labelFor(c.type)}: ',
                  style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
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
    final hasEngagement = audience.engagementRate != null &&
        audience.engagementRate!.isNotEmpty;
    final hasAccounts = audience.socialMediaAccounts != null &&
        audience.socialMediaAccounts!.isNotEmpty;

    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasDemographics) ...[
            if (audience.malePercent != null)
              _DemoRow(
                label: t.registration.male,
                value: '${audience.malePercent}%'
                    '${audience.menAgeFrom != null && audience.menAgeTo != null ? t.ambassador.age_range_suffix(from: audience.menAgeFrom!, to: audience.menAgeTo!) : ''}',
              ),
            if (audience.femalePercent != null) ...[
              const SizedBox(height: 6),
              _DemoRow(
                label: t.registration.female,
                value: '${audience.femalePercent}%'
                    '${audience.womenAgeFrom != null && audience.womenAgeTo != null ? t.ambassador.age_range_suffix(from: audience.womenAgeFrom!, to: audience.womenAgeTo!) : ''}',
              ),
            ],
            const SizedBox(height: 10),
          ],
          if (hasGeo) ...[
            Text(t.registration.geography,
                style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 4),
            Text(audience.geography!.join(', '), style: Typographies.bodyMedium),
            const SizedBox(height: 10),
          ],
          if (hasEngagement) ...[
            Text(t.ambassador.engagement_level,
                style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 4),
            Text(audience.engagementRate!, style: Typographies.bodyMedium),
            const SizedBox(height: 10),
          ],
          if (hasFollowers) ...[
            Text(t.ambassador.total_number_of_followers,
                style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 4),
            Text(_formatFollowers(audience.totalFollowers!),
                style: Typographies.titleSmall),
            const SizedBox(height: 10),
          ],
          if (hasAccounts) ...[
            ...audience.socialMediaAccounts!.map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Text('${a.platform}: ',
                          style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
                      Expanded(
                        child: Text(a.username, style: Typographies.bodyMedium),
                      ),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }
}

class _DemoRow extends StatelessWidget {
  const _DemoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label: ',
            style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
        Expanded(child: Text(value, style: Typographies.bodyMedium)),
      ],
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
            Text(t.registration.years_of_experience,
                style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 4),
            Text(t.ambassador.years_value(years: detail.yearsOfExperience!), style: Typographies.bodyMedium),
            const SizedBox(height: 12),
          ],
          if (detail.partners.isNotEmpty) ...[
            Text(t.ambassador.list_of_partners,
                style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 4),
            ...detail.partners.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(p, style: Typographies.bodyMedium),
                )),
            const SizedBox(height: 12),
          ],
          if (detail.awards.isNotEmpty) ...[
            Text(t.profile.awards,
                style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            const SizedBox(height: 4),
            ...detail.awards.map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    children: [
                      Icon(Icons.emoji_events_outlined,
                          size: 16, color: AppColors.orange),
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
            review.text.isEmpty ? t.ambassador.no_comment : review.text,
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

// ─── TAB 2: PORTFOLIO ────────────────────────────────────────────────────────

class _PortfolioTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmbassadorPortfolioCubit, AmbassadorPortfolioState>(
      builder: (context, state) {
        if (state is AmbassadorPortfolioLoading ||
            state is AmbassadorPortfolioInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AmbassadorPortfolioLoaded) {
          if (state.items.isEmpty) {
            return Center(
              child: Text(
                t.ambassador.no_portfolio_items,
                style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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

// ─── PRICING / DATES ─────────────────────────────────────────────────────────

class _PricingSection extends StatelessWidget {
  const _PricingSection({required this.pricing});
  final PricingEntity? pricing;

  @override
  Widget build(BuildContext context) {
    final p = pricing;
    if (p == null) {
      return AppContainer(
        child: Text(
          t.ambassador.no_pricing_info,
          style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
        ),
      );
    }

    final rows = <Widget>[];

    void addRow(String label, String? value) {
      if (value == null || value.isEmpty || value == 'null') return;
      rows.add(Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack)),
            Text(value, style: Typographies.bodyMedium),
          ],
        ),
      ));
    }

    if (p.hourlyRateMinUzs != null || p.hourlyRateMaxUzs != null) {
      final min = p.hourlyRateMinUzs ?? '—';
      final max = p.hourlyRateMaxUzs ?? '—';
      addRow(t.ambassador.hourly_uzs, '$min – $max');
    }
    if (p.hourlyRateMinUsd != null || p.hourlyRateMaxUsd != null) {
      final min = p.hourlyRateMinUsd ?? '—';
      final max = p.hourlyRateMaxUsd ?? '—';
      addRow(t.ambassador.hourly_usd, '\$$min – \$$max');
    }
    if (p.campaignFee != null) {
      final currency = p.campaignFeeCurrency ?? '';
      addRow(t.ambassador.project_by, '${p.campaignFee} $currency'.trim());
    }
    addRow(t.optional_items.event_appearance_fee, p.eventAppearanceFee);
    addRow(t.ambassador.monthly_exclusivity_fee, p.monthlyExclusivityFee);
    if (p.monthlyContentCapacity != null) {
      addRow(t.ambassador.monthly_content_capacity,
          t.ambassador.content_capacity_posts(count: p.monthlyContentCapacity!));
    }

    if (rows.isEmpty) {
      return AppContainer(
        child: Text(
          t.ambassador.no_pricing_info,
          style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
        ),
      );
    }

    return AppContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows),
    );
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
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.grey),
                  const SizedBox(width: 8),
                  Text('${d.dateFrom} – ${d.dateTo}', style: Typographies.bodyMedium),
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

// ─── BOTTOM BUTTONS ──────────────────────────────────────────────────────────

class _BottomButtons extends StatefulWidget {
  const _BottomButtons({required this.ambassadorId});
  final int ambassadorId;

  @override
  State<_BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<_BottomButtons> {
  bool _addingFavourite = false;

  Future<void> _onAddToFavourites() async {
    if (_addingFavourite) return;
    setState(() => _addingFavourite = true);
    final result = await sl<IFavouritesRepository>()
        .addFavourite(influencerId: widget.ambassadorId);
    if (!mounted) return;
    setState(() => _addingFavourite = false);
    result.fold(
      ifLeft: (f) => context.showAppSnackBar(
        f.message,
        type: AppSnackBarType.error,
      ),
      ifRight: (_) => context.showAppSnackBar(t.ambassador.added_to_favourites),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _addingFavourite ? null : _onAddToFavourites,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.borderColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: _addingFavourite
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.favorite_border, size: 18, color: AppColors.mutedBlack),
              label: Text(t.ambassador.add_to_favourites, style: Typographies.labelLarge),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => context.pushNamed(
                SendEnquiryPage.tag,
                extra: SendEnquiryArguments(otherUserId: widget.ambassadorId),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: Icon(Icons.chat_bubble_outline,
                  size: 18, color: AppColors.black),
              label: Text(
                t.ambassador.send_enquiry,
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
