import 'package:brandface/domain/entities/profile/influencer_analytics_entity.dart';
import 'package:brandface/presentation/home_page/profile/bloc/stats/stats_cubit.dart';
import 'package:brandface/presentation/home_page/profile/bloc/stats/stats_state.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  static const String tag = '/stats';

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  String _selectedPeriod = _PeriodOption.last30Days;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.lightBg,
        titleSpacing: 4,
        title: Text('Analytics', style: Typographies.titleLarge),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<StatsCubit, StatsState>(
          builder: (context, state) {
            return switch (state.status) {
              StatsStatus.loading ||
              StatsStatus.initial => const _LoadingView(),
              StatsStatus.failure => _FailureView(
                message:
                    state.failure?.message ??
                    'Analytics ma\'lumotlarini yuklab bo\'lmadi.',
                onRetry: () =>
                    context.read<StatsCubit>().loadAnalytics(force: true),
              ),
              StatsStatus.success => _ContentView(
                selectedPeriod: _selectedPeriod,
                analytics: state.analytics,
                onChangePeriod: _onChangePeriod,
                onRefresh: () async {
                  await context.read<StatsCubit>().loadAnalytics(force: true);
                },
              ),
            };
          },
        ),
      ),
    );
  }

  Future<void> _onChangePeriod() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: _PeriodOption.values
                .map(
                  (item) => ListTile(
                    title: Text(item),
                    trailing: item == _selectedPeriod
                        ? Icon(Icons.check, color: AppColors.primaryDark)
                        : null,
                    onTap: () => Navigator.of(bottomSheetContext).pop(item),
                  ),
                )
                .toList(),
          ),
        );
      },
    );

    if (!mounted || selected == null) {
      return;
    }

    setState(() {
      _selectedPeriod = selected;
    });
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({
    required this.selectedPeriod,
    required this.analytics,
    required this.onChangePeriod,
    required this.onRefresh,
  });

  final String selectedPeriod;
  final InfluencerAnalyticsEntity analytics;
  final VoidCallback onChangePeriod;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final currentViews = selectedPeriod == _PeriodOption.last30Days
        ? analytics.last30DaysProfileViews
        : analytics.totalProfileViews;

    final summaryCards = <_MetricCardData>[
      _MetricCardData(
        title: 'Average rating',
        value: analytics.averageRating == 0
            ? '0.0'
            : analytics.averageRating.toStringAsFixed(1),
      ),
      _MetricCardData(
        title: 'Total reviews',
        value: analytics.totalReviews.toString(),
      ),
      _MetricCardData(
        title: 'Applications',
        value: analytics.totalApplicationsSubmitted.toString(),
      ),
      _MetricCardData(
        title: 'Selected period',
        value: _formatNumber(currentViews),
      ),
    ];

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile views',
              style: Typographies.titleLarge.copyWith(
                fontSize: 28,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Period',
              style: Typographies.titleSmall.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onChangePeriod,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightBg2,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedPeriod,
                      style: Typographies.labelLarge.copyWith(fontSize: 15),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 24),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            _ViewsBarChart(
              totalViews: analytics.totalProfileViews,
              last30DaysViews: analytics.last30DaysProfileViews,
            ),
            const SizedBox(height: 16),
            AppContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatNumber(currentViews),
                    style: Typographies.titleLarge.copyWith(
                      fontSize: 32,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedPeriod == _PeriodOption.last30Days
                        ? 'Profile views in the last 30 days'
                        : 'Total profile views',
                    style: Typographies.bodySmall.copyWith(
                      fontSize: 14,
                      color: AppColors.mutedBlack,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: summaryCards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                final card = summaryCards[index];
                return AppContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card.value,
                        style: Typographies.titleLarge.copyWith(
                          fontSize: 26,
                          height: 1,
                        ),
                      ),
                      Text(
                        card.title,
                        style: Typographies.bodySmall.copyWith(
                          fontSize: 13,
                          color: AppColors.mutedBlack,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            AppContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Applications by status',
                    style: Typographies.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _ApplicationsBreakdown(
                    totalApplications: analytics.totalApplicationsSubmitted,
                    applicationsByStatus: analytics.applicationsByStatus,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewsBarChart extends StatelessWidget {
  const _ViewsBarChart({
    required this.totalViews,
    required this.last30DaysViews,
  });

  final int totalViews;
  final int last30DaysViews;

  @override
  Widget build(BuildContext context) {
    final items = <_BarItem>[
      _BarItem(label: '30 days', value: last30DaysViews),
      _BarItem(label: 'All time', value: totalViews),
    ];
    final maxValue = items
        .map((item) => item.value)
        .fold<int>(0, (max, value) => value > max ? value : max);

    return AppContainer(
      child: SizedBox(
        height: 220,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: items.map((item) {
            final factor = maxValue == 0 ? 0.0 : item.value / maxValue;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: item == items.last ? 0 : 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _formatNumber(item.value),
                      style: Typographies.labelMedium.copyWith(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      width: double.infinity,
                      height: 130 * factor + 20,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.label,
                      style: Typographies.labelMedium.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ApplicationsBreakdown extends StatelessWidget {
  const _ApplicationsBreakdown({
    required this.totalApplications,
    required this.applicationsByStatus,
  });

  final int totalApplications;
  final Map<String, int> applicationsByStatus;

  @override
  Widget build(BuildContext context) {
    final orderedStatuses = <MapEntry<String, int>>[
      if (applicationsByStatus.containsKey('pending'))
        MapEntry('pending', applicationsByStatus['pending'] ?? 0),
      if (applicationsByStatus.containsKey('shortlisted'))
        MapEntry('shortlisted', applicationsByStatus['shortlisted'] ?? 0),
      if (applicationsByStatus.containsKey('accepted'))
        MapEntry('accepted', applicationsByStatus['accepted'] ?? 0),
      if (applicationsByStatus.containsKey('rejected'))
        MapEntry('rejected', applicationsByStatus['rejected'] ?? 0),
      ...applicationsByStatus.entries.where(
        (entry) => !const {
          'pending',
          'shortlisted',
          'accepted',
          'rejected',
        }.contains(entry.key),
      ),
    ];

    if (orderedStatuses.isEmpty) {
      return Text(
        'No applications yet.',
        style: Typographies.bodyMedium.copyWith(color: AppColors.mutedBlack),
      );
    }

    final maxValue = orderedStatuses
        .map((entry) => entry.value)
        .fold<int>(0, (max, value) => value > max ? value : max);

    return Column(
      children: orderedStatuses.map((entry) {
        final value = entry.value;
        final widthFactor = maxValue == 0 ? 0.0 : value / maxValue;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatStatus(entry.key),
                    style: Typographies.titleSmall.copyWith(fontSize: 15),
                  ),
                  Text(
                    totalApplications == 0
                        ? '0'
                        : '$value / $totalApplications',
                    style: Typographies.bodySmall.copyWith(
                      fontSize: 13,
                      color: AppColors.mutedBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: widthFactor.clamp(0.0, 1.0),
                  minHeight: 10,
                  backgroundColor: AppColors.borderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _statusColor(entry.key),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return AppColors.primaryDark;
      case 'shortlisted':
        return AppColors.orange;
      case 'rejected':
        return AppColors.red;
      default:
        return AppColors.black;
    }
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Typographies.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.black,
              ),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCardData {
  final String title;
  final String value;

  const _MetricCardData({required this.title, required this.value});
}

class _BarItem {
  final String label;
  final int value;

  const _BarItem({required this.label, required this.value});
}

class _PeriodOption {
  static const String last30Days = 'Last 30 days';
  static const String allTime = 'All time';
  static const List<String> values = [last30Days, allTime];
}

String _formatNumber(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < digits.length; i++) {
    final reverseIndex = digits.length - i;
    buffer.write(digits[i]);
    if (reverseIndex > 1 && reverseIndex % 3 == 1) {
      buffer.write(',');
    }
  }

  return buffer.toString();
}

String _formatStatus(String status) {
  if (status.isEmpty) {
    return 'Unknown';
  }

  return status
      .split('_')
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');
}
