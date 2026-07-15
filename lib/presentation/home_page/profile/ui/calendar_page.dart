import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/profile/ambassador_detail_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/domain/usecase/profile/get_influencer_profile_use_case.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  static const String tag = '/calendar';

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<String> get _monthNames => [
    t.collab.month_january,
    t.collab.month_february,
    t.collab.month_march,
    t.collab.month_april,
    t.collab.month_may,
    t.collab.month_june,
    t.collab.month_july,
    t.collab.month_august,
    t.collab.month_september,
    t.collab.month_october,
    t.collab.month_november,
    t.collab.month_december,
  ];

  bool _isLoading = true;
  bool _isSaving = false;
  Failure? _failure;
  // Latest known server state — list of date ranges with ids.
  List<AvailableDateItem> _serverRanges = const [];
  // Range ids the user has marked for deletion (not yet sent).
  final Set<int> _pendingDeletes = <int>{};
  // Single-day adds the user has toggled on (not yet sent).
  final Set<DateTime> _pendingAdds = <DateTime>{};
  DateTime _selectedMonth = _monthStart(DateTime.now());

  bool get _hasPendingChanges =>
      _pendingDeletes.isNotEmpty || _pendingAdds.isNotEmpty;

  // Effective active days = server days (minus deleted ranges) ∪ pending adds.
  Set<DateTime> _effectiveActiveDays() {
    final result = <DateTime>{};
    for (final range in _serverRanges) {
      if (_pendingDeletes.contains(range.id)) continue;
      result.addAll(_expandRange(range));
    }
    result.addAll(_pendingAdds);
    return result;
  }

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
        title: Text(t.profile.calendar, style: Typographies.titleLarge),
        actions: [
          if (_hasPendingChanges && !_isLoading)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: TextButton(
                onPressed: _isSaving ? null : _saveChanges,
                child: _isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        t.collab.save,
                        style: Typographies.labelLarge.copyWith(
                          color: AppColors.primaryDark,
                        ),
                      ),
              ),
            ),
        ],
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
    final activeDays = _effectiveActiveDays();
    final availableCount = monthDays
        .where((day) => _containsDate(activeDays, day))
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
                t.collab.available_dates(count: availableCount),
                style: Typographies.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...monthDays.map((day) {
            final isActive = _containsDate(activeDays, day);

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _CalendarDateTile(
                label: day.day.toString().padLeft(2, '0'),
                isActive: isActive,
                onTap: _isSaving ? null : () => _toggleDate(day),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _toggleDate(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    final activeDays = _effectiveActiveDays();
    final wasActive = _containsDate(activeDays, normalized);

    setState(() {
      if (wasActive) {
        // Was active — figure out if it came from a pending add or a server range.
        if (_pendingAdds.any((d) => _sameDay(d, normalized))) {
          _pendingAdds.removeWhere((d) => _sameDay(d, normalized));
          return;
        }
        // It came from a server range — mark the whole range for deletion.
        final range = _serverRanges.firstWhere(
          (r) => _rangeContains(r, normalized),
          orElse: () => const AvailableDateItem(
            id: 0,
            dateFrom: '',
            dateTo: '',
          ),
        );
        if (range.id != 0) {
          _pendingDeletes.add(range.id);
          // If user previously added days that fall inside the now-deleted
          // range, they'd be hidden anyway — drop them so re-toggling works.
          _pendingAdds.removeWhere((d) => _rangeContains(range, d));
        }
      } else {
        // Was inactive — either undo a pending delete, or queue a new add.
        final restored = _serverRanges
            .where((r) =>
                _pendingDeletes.contains(r.id) && _rangeContains(r, normalized))
            .toList();
        if (restored.isNotEmpty) {
          for (final r in restored) {
            _pendingDeletes.remove(r.id);
          }
        } else {
          _pendingAdds.add(normalized);
        }
      }
    });
  }

  Future<void> _saveChanges() async {
    if (!_hasPendingChanges) return;
    setState(() => _isSaving = true);

    final repo = sl<IProfileRepository>();
    final deletes = List<int>.from(_pendingDeletes);
    final adds = List<DateTime>.from(_pendingAdds);
    final failures = <String>[];

    for (final id in deletes) {
      final result = await repo.deleteAvailableDate(dateId: id);
      result.fold(
        ifLeft: (f) => failures.add(f.message),
        ifRight: (_) {},
      );
    }

    for (final day in adds) {
      final iso = _formatIsoDate(day);
      final result = await repo.addAvailableDate(
        dateFrom: iso,
        dateTo: iso,
      );
      result.fold(
        ifLeft: (f) => failures.add(f.message),
        ifRight: (_) {},
      );
    }

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (failures.isNotEmpty) {
      context.showAppSnackBar(
        failures.first,
        type: AppSnackBarType.error,
      );
    } else {
      context.showAppSnackBar(t.collab.calendar_updated);
    }
    await _loadCalendar();
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
        final ranges = profile.availableDates ?? const <AvailableDateItem>[];
        final allDays = <DateTime>[];
        for (final r in ranges) {
          allDays.addAll(_expandRange(r));
        }
        allDays.sort();
        final currentMonth = _resolveInitialMonth(allDays);

        setState(() {
          _isLoading = false;
          _serverRanges = ranges;
          _pendingAdds.clear();
          _pendingDeletes.clear();
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

  static List<DateTime> _expandRange(AvailableDateItem range) {
    final from = DateTime.tryParse(range.dateFrom);
    final to = DateTime.tryParse(range.dateTo);
    if (from == null || to == null) return const [];
    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day);
    if (end.isBefore(start)) return const [];
    final days = <DateTime>[];
    var cursor = start;
    while (!cursor.isAfter(end)) {
      days.add(cursor);
      cursor = cursor.add(const Duration(days: 1));
    }
    return days;
  }

  static bool _rangeContains(AvailableDateItem range, DateTime day) {
    final from = DateTime.tryParse(range.dateFrom);
    final to = DateTime.tryParse(range.dateTo);
    if (from == null || to == null) return false;
    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day);
    final target = DateTime(day.year, day.month, day.day);
    return !target.isBefore(start) && !target.isAfter(end);
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static String _formatIsoDate(DateTime date) {
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '${date.year}-$m-$d';
  }

  static DateTime _monthStart(DateTime date) => DateTime(date.year, date.month);

  static List<DateTime> _daysInMonth(DateTime month) {
    final daysCount = DateTime(month.year, month.month + 1, 0).day;

    return List<DateTime>.generate(
      daysCount,
      (index) => DateTime(month.year, month.month, index + 1),
    );
  }

  static bool _containsDate(Iterable<DateTime> dates, DateTime day) {
    return dates.any(
      (item) =>
          item.year == day.year &&
          item.month == day.month &&
          item.day == day.day,
    );
  }

  String _formatMonth(DateTime date) {
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
  const _CalendarDateTile({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback? onTap;

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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
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
        ),
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
              t.common.pull_refresh_or_retry,
              style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 170,
              child: AppButtons.primary(
                title: t.common.try_again,
                onTap: onRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
