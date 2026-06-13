import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/language/language_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/region/region_cubit.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmbassadorsFilterPage extends StatefulWidget {
  const AmbassadorsFilterPage({super.key, this.initial});

  static const String tag = '/ambassador-filter';

  final AmbassadorsFilterParams? initial;

  @override
  State<AmbassadorsFilterPage> createState() => _AmbassadorsFilterPageState();
}

class _AmbassadorsFilterPageState extends State<AmbassadorsFilterPage> {
  int? _categoryId;
  String? _categoryName;
  int? _regionId;
  String? _regionName;
  int? _languageId;
  String? _languageName;
  String? _gender;
  String? _rankType;
  int? _ageFrom;
  int? _ageTo;
  String? _ageLabel;
  int? _followersFrom;
  int? _followersTo;
  String? _followersLabel;
  DateTime? _availableDate;
  String? _currency;
  final TextEditingController _priceFromCtrl = TextEditingController();
  final TextEditingController _priceToCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final p = widget.initial;
    if (p != null) {
      _categoryId = p.categoryId;
      _regionId = p.regionId;
      _languageId = p.languageId;
      _gender = p.gender;
      if (p.isTop == true) _rankType = 'top';
      if (p.isVip == true) _rankType = 'vip';
      _ageFrom = p.ageFrom;
      _ageTo = p.ageTo;
      _ageLabel = _formatAgeLabel(p.ageFrom, p.ageTo);
      _followersFrom = p.followersFrom;
      _followersTo = p.followersTo;
      _followersLabel = _formatFollowersLabel(p.followersFrom, p.followersTo);
      if (p.availableDate != null) {
        _availableDate = DateTime.tryParse(p.availableDate!);
      }
      _currency = p.currency;
      if (p.pricePerHourFrom != null) {
        _priceFromCtrl.text = p.pricePerHourFrom.toString();
      }
      if (p.pricePerHourTo != null) {
        _priceToCtrl.text = p.pricePerHourTo.toString();
      }
    }
  }

  @override
  void dispose() {
    _priceFromCtrl.dispose();
    _priceToCtrl.dispose();
    super.dispose();
  }

  AmbassadorsFilterParams _buildParams() {
    final priceFrom = int.tryParse(_priceFromCtrl.text.trim());
    final priceTo = int.tryParse(_priceToCtrl.text.trim());
    return AmbassadorsFilterParams(
      categoryId: _categoryId,
      regionId: _regionId,
      languageId: _languageId,
      gender: _gender,
      ageFrom: _ageFrom,
      ageTo: _ageTo,
      isTop: _rankType == 'top' ? true : null,
      isVip: _rankType == 'vip' ? true : null,
      followersFrom: _followersFrom,
      followersTo: _followersTo,
      availableDate: _availableDate != null
          ? '${_availableDate!.year.toString().padLeft(4, '0')}-'
              '${_availableDate!.month.toString().padLeft(2, '0')}-'
              '${_availableDate!.day.toString().padLeft(2, '0')}'
          : null,
      currency: _currency,
      pricePerHourFrom: priceFrom,
      pricePerHourTo: priceTo,
    );
  }

  void _clear() {
    setState(() {
      _categoryId = null;
      _categoryName = null;
      _regionId = null;
      _regionName = null;
      _languageId = null;
      _languageName = null;
      _gender = null;
      _rankType = null;
      _ageFrom = null;
      _ageTo = null;
      _ageLabel = null;
      _followersFrom = null;
      _followersTo = null;
      _followersLabel = null;
      _availableDate = null;
      _currency = null;
      _priceFromCtrl.clear();
      _priceToCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        backgroundColor: AppColors.lightBg,
        scrolledUnderElevation: 0,
        title: Text(t.brand.filter, style: Typographies.titleMedium),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DropdownField(
                    label: t.registration.services,
                    value: _categoryName,
                    onTap: () => _pickCategory(context),
                  ),
                  const SizedBox(height: 12),
                  _DropdownField(
                    label: t.registration.geography,
                    value: _regionName,
                    onTap: () => _pickRegion(context),
                  ),
                  const SizedBox(height: 12),
                  _DropdownField(
                    label: 'Language',
                    value: _languageName,
                    onTap: () => _pickLanguage(context),
                  ),
                  const SizedBox(height: 12),
                  _DropdownField(
                    label: t.registration.gender,
                    value: _genderLabel(_gender),
                    onTap: () => _pickGender(context),
                  ),
                  const SizedBox(height: 12),
                  _DropdownField(
                    label: 'Age',
                    value: _ageLabel,
                    onTap: _pickAge,
                  ),
                  const SizedBox(height: 12),
                  _DropdownField(
                    label: t.brand.rank_type,
                    value: _rankLabel(_rankType),
                    onTap: () => _pickRank(context),
                  ),
                  const SizedBox(height: 12),
                  _DropdownField(
                    label: 'Auditory',
                    value: _followersLabel,
                    onTap: _pickFollowers,
                  ),
                  const SizedBox(height: 12),
                  _DateField(
                    label: 'Available date',
                    value: _availableDate,
                    onTap: _pickDate,
                  ),
                  const SizedBox(height: 12),
                  _DropdownField(
                    label: 'Currency',
                    value: _currency,
                    onTap: _pickCurrency,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Price range (per hour)',
                    style: Typographies.bodySmall.copyWith(
                      color: AppColors.mutedBlack,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: _NumericInput(
                          controller: _priceFromCtrl,
                          hint: 'From',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _NumericInput(
                          controller: _priceToCtrl,
                          hint: 'To',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              MediaQuery.of(context).padding.bottom + 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _clear();
                      Navigator.of(context).pop(const AmbassadorsFilterParams());
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.borderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(t.common.cancel, style: Typographies.labelLarge),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(_buildParams()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      t.onboarding.kContinue,
                      style: Typographies.labelLarge.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _genderLabel(String? val) {
    switch (val) {
      case 'male':
        return t.registration.male;
      case 'female':
        return t.registration.female;
      default:
        return null;
    }
  }

  String? _rankLabel(String? val) {
    switch (val) {
      case 'top':
        return t.brand.top_label;
      case 'vip':
        return t.brand.vip_label;
      default:
        return null;
    }
  }

  String? _formatAgeLabel(int? from, int? to) {
    if (from == null && to == null) return null;
    if (from != null && to != null) return '$from – $to';
    if (from != null) return '$from+';
    return '≤ $to';
  }

  String? _formatFollowersLabel(int? from, int? to) {
    String fmt(int v) {
      if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(0)}M';
      if (v >= 1000) return '${(v / 1000).toStringAsFixed(0)}K';
      return v.toString();
    }

    if (from == null && to == null) return null;
    if (from != null && to != null) return '${fmt(from)} – ${fmt(to)}';
    if (from != null) return '${fmt(from)}+';
    return '≤ ${fmt(to!)}';
  }

  Future<void> _pickCategory(BuildContext context) async {
    final state = context.read<CategoryCubit>().state;
    final items = state.maybeWhen(
      categoryLoaded: (data) => data,
      orElse: () => [],
    );
    if (items.isEmpty) return;
    final result = await _showPicker(
      context: context,
      title: t.registration.services,
      items: items.map((e) => _PickerItem(id: e.id, name: e.name)).toList(),
    );
    if (result != null) {
      setState(() {
        _categoryId = result.id;
        _categoryName = result.name;
      });
    }
  }

  Future<void> _pickRegion(BuildContext context) async {
    final state = context.read<RegionCubit>().state;
    final items = state.maybeWhen(
      regionsLoaded: (data) => data,
      orElse: () => [],
    );
    if (items.isEmpty) return;
    final result = await _showPicker(
      context: context,
      title: t.registration.geography,
      items: items.map((e) => _PickerItem(id: e.id, name: e.name)).toList(),
    );
    if (result != null) {
      setState(() {
        _regionId = result.id;
        _regionName = result.name;
      });
    }
  }

  Future<void> _pickLanguage(BuildContext context) async {
    final state = context.read<LanguageCubit>().state;
    final items = state.maybeWhen(
      loaded: (data) => data,
      orElse: () => [],
    );
    if (items.isEmpty) return;
    final result = await _showPicker(
      context: context,
      title: 'Language',
      items: items.map((e) => _PickerItem(id: e.id, name: e.name)).toList(),
    );
    if (result != null) {
      setState(() {
        _languageId = result.id;
        _languageName = result.name;
      });
    }
  }

  Future<void> _pickGender(BuildContext context) async {
    final result = await _showPicker(
      context: context,
      title: t.registration.gender,
      items: [
        _PickerItem(id: 0, name: t.registration.male, value: 'male'),
        _PickerItem(id: 1, name: t.registration.female, value: 'female'),
      ],
    );
    if (result != null) {
      setState(() => _gender = result.value ?? result.name.toLowerCase());
    }
  }

  Future<void> _pickRank(BuildContext context) async {
    final result = await _showPicker(
      context: context,
      title: t.brand.rank_type,
      items: [
        _PickerItem(id: 0, name: t.brand.top_label, value: 'top'),
        _PickerItem(id: 1, name: t.brand.vip_label, value: 'vip'),
      ],
    );
    if (result != null) {
      setState(() => _rankType = result.value ?? result.name.toLowerCase());
    }
  }

  Future<void> _pickAge() async {
    const ranges = [
      (label: '13 – 17', from: 13, to: 17),
      (label: '18 – 24', from: 18, to: 24),
      (label: '25 – 34', from: 25, to: 34),
      (label: '35 – 44', from: 35, to: 44),
      (label: '45 – 54', from: 45, to: 54),
      (label: '55+', from: 55, to: null),
    ];
    final result = await _showPicker(
      context: context,
      title: 'Age',
      items: [
        for (var i = 0; i < ranges.length; i++)
          _PickerItem(id: i, name: ranges[i].label),
      ],
    );
    if (result != null) {
      final r = ranges[result.id];
      setState(() {
        _ageFrom = r.from;
        _ageTo = r.to;
        _ageLabel = r.label;
      });
    }
  }

  Future<void> _pickFollowers() async {
    const ranges = [
      (label: '< 1K', from: null as int?, to: 999 as int?),
      (label: '1K – 10K', from: 1000 as int?, to: 9999 as int?),
      (label: '10K – 100K', from: 10000 as int?, to: 99999 as int?),
      (label: '100K – 1M', from: 100000 as int?, to: 999999 as int?),
      (label: '1M+', from: 1000000 as int?, to: null as int?),
    ];
    final result = await _showPicker(
      context: context,
      title: 'Auditory',
      items: [
        for (var i = 0; i < ranges.length; i++)
          _PickerItem(id: i, name: ranges[i].label),
      ],
    );
    if (result != null) {
      final r = ranges[result.id];
      setState(() {
        _followersFrom = r.from;
        _followersTo = r.to;
        _followersLabel = r.label;
      });
    }
  }

  Future<void> _pickCurrency() async {
    final result = await _showPicker(
      context: context,
      title: 'Currency',
      items: const [
        _PickerItem(id: 0, name: 'UZS'),
        _PickerItem(id: 1, name: 'USD'),
      ],
    );
    if (result != null) {
      setState(() => _currency = result.name);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _availableDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() => _availableDate = picked);
    }
  }

  Future<_PickerItem?> _showPicker({
    required BuildContext context,
    required String title,
    required List<_PickerItem> items,
  }) {
    return showModalBottomSheet<_PickerItem>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _PickerSheet(title: title, items: items),
    );
  }
}

class _PickerItem {
  final int id;
  final String name;
  final String? value;

  const _PickerItem({required this.id, required this.name, this.value});
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.lightBg3,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value ?? t.common.select,
                  style: Typographies.bodyMedium.copyWith(
                    color: value != null ? AppColors.black : AppColors.grey,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;

  String _format(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.'
      '${d.month.toString().padLeft(2, '0')}.'
      '${d.year}';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.lightBg3,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value != null ? _format(value!) : 'DD.MM.YYYY',
                  style: Typographies.bodyMedium.copyWith(
                    color: value != null ? AppColors.black : AppColors.grey,
                  ),
                ),
                Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NumericInput extends StatelessWidget {
  const _NumericInput({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: Typographies.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Typographies.bodyMedium.copyWith(color: AppColors.grey),
        filled: true,
        fillColor: AppColors.lightBg3,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
      ),
    );
  }
}

class _PickerSheet extends StatelessWidget {
  const _PickerSheet({required this.title, required this.items});

  final String title;
  final List<_PickerItem> items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(title, style: Typographies.titleMedium),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (_, i) => InkWell(
                onTap: () => Navigator.of(context).pop(items[i]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Text(items[i].name, style: Typographies.bodyMedium),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
