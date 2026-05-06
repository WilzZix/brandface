import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/home_page/brand/bloc/ambassadors/ambassadors_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/region/region_cubit.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
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
  String? _gender;
  String? _rankType;

  @override
  void initState() {
    super.initState();
    final p = widget.initial;
    if (p != null) {
      _categoryId = p.categoryId;
      _regionId = p.regionId;
      _gender = p.gender;
      if (p.isTop == true) _rankType = 'top';
      if (p.isVip == true) _rankType = 'vip';
    }
  }

  AmbassadorsFilterParams _buildParams() {
    return AmbassadorsFilterParams(
      categoryId: _categoryId,
      regionId: _regionId,
      gender: _gender,
      isTop: _rankType == 'top' ? true : null,
      isVip: _rankType == 'vip' ? true : null,
    );
  }

  void _clear() {
    setState(() {
      _categoryId = null;
      _categoryName = null;
      _regionId = null;
      _regionName = null;
      _gender = null;
      _rankType = null;
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
                    label: t.registration.gender,
                    value: _genderLabel(_gender),
                    onTap: () => _pickGender(context),
                  ),
                  const SizedBox(height: 12),
                  _DropdownField(
                    label: t.brand.rank_type,
                    value: _rankLabel(_rankType),
                    onTap: () => _pickRank(context),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              16, 8, 16, MediaQuery.of(context).padding.bottom + 16,
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
                    onPressed: () =>
                        Navigator.of(context).pop(_buildParams()),
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
