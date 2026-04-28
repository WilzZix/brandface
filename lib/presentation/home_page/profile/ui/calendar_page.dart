import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/influencer_profile_information_entity.dart';
import 'package:brandface/domain/usecase/profile/get_influencer_profile_use_case.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  static const String tag = '/calendar';

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  bool _isLoading = true;
  Failure? _failure;
  List<DateTime> _availableDates = const [];
  DateTime _selectedMonth = _monthStart(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadCalendar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.lightBg,

        titleSpacing: 4,
        title: Text('Calendar', style: Typographies.titleLarge),
      ),
      body: SafeArea(top: false, child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_failure != null) {
      return _CalendarErrorState(
        message: _failure!.message,
        onRetry: _loadCalendar,
      );
    }

    final monthDays = _daysInMonth(_selectedMonth);
    final availableCount = monthDays
        .where((day) => _containsDate(_availableDates, day))
        .length;

    return RefreshIndicator(
      color: AppColors.black,
      onRefresh: _loadCalendar,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          MediaQuery.of(context).padding.bottom + 24,
        ),
        children: [
          _MonthNavigation(
            monthLabel: _formatMonth(_selectedMonth),
            onPrevious: () => _changeMonth(-1),
            onNext: () => _changeMonth(1),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available dates ($availableCount)',
                style: Typographies.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...monthDays.map((day) {
            final isActive = _containsDate(_availableDates, day);

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _CalendarDateTile(
                label: day.day.toString().padLeft(2, '0'),
                isActive: isActive,
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _loadCalendar() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _failure = null;
      });
    }

    final result = await sl<GetInfluencerProfileUseCase>().call(params: null);

    if (!mounted) {
      return;
    }

    result.fold(
      ifLeft: (failure) {
        setState(() {
          _isLoading = false;
          _failure = failure;
        });
      },
      ifRight: (profile) {
        final parsedDates = _parseAvailableDates(profile);
        final currentMonth = _resolveInitialMonth(parsedDates);

        setState(() {
          _isLoading = false;
          _availableDates = parsedDates;
          _selectedMonth = currentMonth;
        });
      },
    );
  }

  void _changeMonth(int delta) {
    setState(() {
      _selectedMonth = DateTime(
        _selectedMonth.year,
        _selectedMonth.month + delta,
      );
    });
  }

  DateTime _resolveInitialMonth(List<DateTime> parsedDates) {
    final now = DateTime.now();
    final currentMonth = _monthStart(now);

    final hasCurrentMonthDate = parsedDates.any(
      (item) =>
          item.year == currentMonth.year && item.month == currentMonth.month,
    );

    if (hasCurrentMonthDate) {
      return currentMonth;
    }

    if (parsedDates.isNotEmpty) {
      return _monthStart(parsedDates.first);
    }

    return currentMonth;
  }

  List<DateTime> _parseAvailableDates(
    InfluencerProfileInformationEntity profile,
  ) {
    final normalized = <DateTime>{};

    for (final item in profile.availableDates ?? const []) {
      final parsed = DateTime.tryParse(item.toString());
      if (parsed == null) {
        continue;
      }

      normalized.add(DateTime(parsed.year, parsed.month, parsed.day));
    }

    final dates = normalized.toList()..sort();
    return dates;
  }

  static DateTime _monthStart(DateTime date) => DateTime(date.year, date.month);

  static List<DateTime> _daysInMonth(DateTime month) {
    final daysCount = DateTime(month.year, month.month + 1, 0).day;

    return List<DateTime>.generate(
      daysCount,
      (index) => DateTime(month.year, month.month, index + 1),
    );
  }

  static bool _containsDate(List<DateTime> dates, DateTime day) {
    return dates.any(
      (item) =>
          item.year == day.year &&
          item.month == day.month &&
          item.day == day.day,
    );
  }

  static String _formatMonth(DateTime date) {
    return '${_monthNames[date.month - 1]}, ${date.year}';
  }
}

class _MonthNavigation extends StatelessWidget {
  const _MonthNavigation({
    required this.monthLabel,
    required this.onPrevious,
    required this.onNext,
  });

  final String monthLabel;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MonthArrowButton(iconPath: AppAssets.icArrowLeft, onTap: onPrevious),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.center,
            child: Text(
              monthLabel,
              style: Typographies.labelMedium.copyWith(color: AppColors.white),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _MonthArrowButton(iconPath: AppAssets.icArrowRight, onTap: onNext),
      ],
    );
  }
}

class _MonthArrowButton extends StatelessWidget {
  const _MonthArrowButton({required this.iconPath, required this.onTap});

  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Ink(
        width: 72,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.lightBg2,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Center(child: SvgPicture.asset(iconPath)),
      ),
    );
  }
}

class _CalendarDateTile extends StatelessWidget {
  const _CalendarDateTile({required this.label, required this.isActive});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final background = isActive ? AppColors.lightGreen : AppColors.lightBg3;
    final textColor = isActive ? AppColors.black : AppColors.grey;
    final borderColor = isActive
        ? AppColors.primaryDark
        : AppColors.borderColor;
    final thumbColor = isActive ? AppColors.primaryDark : AppColors.borderColor;
    final thumbAlignment = isActive
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: Typographies.titleMedium.copyWith(color: textColor),
          ),
          const Spacer(),
          Container(
            width: 36,
            height: 20,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: borderColor),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              alignment: thumbAlignment,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: thumbColor,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarErrorState extends StatelessWidget {
  const _CalendarErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

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
              style: Typographies.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Pull to refresh or try again.',
              style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 170,
              child: AppButtons.primary(title: 'Try again', onTap: onRetry),
            ),
          ],
        ),
      ),
    );
  }
}
