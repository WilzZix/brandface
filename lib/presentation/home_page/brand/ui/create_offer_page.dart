import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/profile/catalog/category_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/city_entity.dart';
import 'package:brandface/domain/entities/profile/catalog/region_entity.dart';
import 'package:brandface/presentation/home_page/brand/bloc/create_offer/create_offer_cubit.dart';
import 'package:brandface/presentation/home_page/brand/bloc/create_offer/create_offer_state.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/city/city_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/city/city_state.dart';
import 'package:brandface/presentation/registration/bloc/catalog/region/region_cubit.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/extansions/snackbar_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateOfferPage extends StatefulWidget {
  const CreateOfferPage({super.key});

  static const String tag = '/create-offer';

  @override
  State<CreateOfferPage> createState() => _CreateOfferPageState();
}

class _CreateOfferPageState extends State<CreateOfferPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<String> get _steps => [t.common.general, t.common.requirements_label, t.common.details_label];

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategory();
    context.read<RegionCubit>().getCategories();
    context.read<CityCubit>().getCities();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    if (step < 0 || step >= _steps.length) return;
    setState(() => _currentStep = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onCancel() {
    if (_currentStep > 0) {
      _goToStep(_currentStep - 1);
    } else {
      context.pop();
    }
  }

  void _onContinue() {
    final cubit = context.read<CreateOfferCubit>();
    cubit.setTitle(_titleController.text.trim());
    cubit.setDescription(_descriptionController.text.trim());
    if (_currentStep < _steps.length - 1) {
      _goToStep(_currentStep + 1);
    } else {
      cubit.submit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateOfferCubit, CreateOfferState>(
      listener: (context, state) {
        if (state.status == CreateOfferStatus.failure) {
          context.showAppSnackBar(
            state.errorMessage ?? t.common.error_occurred,
            type: AppSnackBarType.error,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.offer.create_title),
          centerTitle: false,
        ),
        body: BlocBuilder<CreateOfferCubit, CreateOfferState>(
          builder: (context, state) {
            if (state.status == CreateOfferStatus.success) {
              return _SuccessScreen();
            }
            return Column(
              children: [
                const SizedBox(height: 16),
                _StepTabBar(
                  steps: _steps,
                  currentStep: _currentStep,
                  onTap: (i) {
                    if (i <= _currentStep) _goToStep(i);
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _Step1General(
                        titleController: _titleController,
                        descriptionController: _descriptionController,
                      ),
                      const _Step2Requirements(),
                      const _Step3Details(),
                    ],
                  ),
                ),
                _BottomButtons(
                  isLastStep: _currentStep == _steps.length - 1,
                  isLoading: state.status == CreateOfferStatus.loading,
                  onCancel: _onCancel,
                  onContinue: _onContinue,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Step tab bar
// ---------------------------------------------------------------------------

class _StepTabBar extends StatelessWidget {
  const _StepTabBar({
    required this.steps,
    required this.currentStep,
    required this.onTap,
  });

  final List<String> steps;
  final int currentStep;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(steps.length, (i) {
          final isSelected = i == currentStep;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              child: Container(
                margin: EdgeInsets.only(right: i < steps.length - 1 ? 8 : 0),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.lightBg3,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Center(
                  child: Text(
                    steps[i],
                    style: Typographies.labelMedium.copyWith(
                      color:
                          isSelected ? AppColors.black : AppColors.mutedBlack,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Step 1 – General
// ---------------------------------------------------------------------------

class _Step1General extends StatelessWidget {
  const _Step1General({
    required this.titleController,
    required this.descriptionController,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateOfferCubit>();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.offer.offer_title, style: Typographies.titleSmall),
          const SizedBox(height: 8),
          _AppTextField(
            controller: titleController,
            hintText: t.offer.title_hint,
          ),
          const SizedBox(height: 20),
          Text(t.registration.niches, style: Typographies.titleSmall),
          const SizedBox(height: 8),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, catState) {
              final categories = catState.maybeWhen(
                categoryLoaded: (data) => data,
                orElse: () => <CategoryItemEntity>[],
              );
              if (categories.isEmpty) {
                return const SizedBox(
                  height: 40,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return BlocBuilder<CreateOfferCubit, CreateOfferState>(
                builder: (context, offerState) {
                  return SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        final cat = categories[i];
                        final isSelected = cubit.selectedNiches
                            .any((n) => n.id == cat.id);
                        return GestureDetector(
                          onTap: () => cubit.toggleNiche(cat),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.lightBg3,
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.borderColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                cat.name,
                                style: Typographies.labelMedium.copyWith(
                                  color: isSelected
                                      ? AppColors.black
                                      : AppColors.mutedBlack,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 12),
          BlocBuilder<CreateOfferCubit, CreateOfferState>(
            builder: (context, offerState) {
              final niches = cubit.selectedNiches;
              if (niches.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.registration.selected_niches,
                    style: Typographies.bodySmall.copyWith(
                      color: AppColors.mutedBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...niches.map(
                    (n) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(n.name, style: Typographies.bodyMedium),
                          GestureDetector(
                            onTap: () => cubit.removeNiche(n.id),
                            child: Text(
                              t.common.delete,
                              style: Typographies.labelMedium.copyWith(
                                color: AppColors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          Text(t.offer.description, style: Typographies.titleSmall),
          const SizedBox(height: 8),
          _AppTextField(
            controller: descriptionController,
            hintText: t.common.write_text_here,
            maxLines: 5,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Step 2 – Requirements
// ---------------------------------------------------------------------------

class _Step2Requirements extends StatelessWidget {
  const _Step2Requirements();

  List<_Option<String?>> get _genderOptions => [
    _Option(label: t.common.any, value: null),
    _Option(label: t.registration.male, value: 'male'),
    _Option(label: t.registration.female, value: 'female'),
  ];

  List<_AgeRange> get _ageRanges => [
    _AgeRange(label: t.common.any, min: null, max: null),
    const _AgeRange(label: '13–17', min: 13, max: 17),
    const _AgeRange(label: '18–24', min: 18, max: 24),
    const _AgeRange(label: '25–34', min: 25, max: 34),
    const _AgeRange(label: '35–44', min: 35, max: 44),
    const _AgeRange(label: '45+', min: 45, max: null),
  ];

  List<_Option<int?>> get _followersOptions => [
    _Option<int?>(label: t.common.any, value: null),
    const _Option<int?>(label: '1K', value: 1000),
    const _Option<int?>(label: '5K', value: 5000),
    const _Option<int?>(label: '10K', value: 10000),
    const _Option<int?>(label: '50K', value: 50000),
    const _Option<int?>(label: '100K', value: 100000),
    const _Option<int?>(label: '500K', value: 500000),
    const _Option<int?>(label: '1M+', value: 1000000),
  ];

  List<_Option<String?>> get _engagementOptions => [
    _Option(label: t.common.any, value: null),
    const _Option(label: '<1%', value: '<1'),
    const _Option(label: '1–2%', value: '1-2'),
    const _Option(label: '2–5%', value: '2-5'),
    const _Option(label: '5–10%', value: '5-10'),
    const _Option(label: '10%+', value: '10+'),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateOfferCubit>();

    return BlocBuilder<CreateOfferCubit, CreateOfferState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldLabel(t.registration.gender),
              const SizedBox(height: 8),
              _AppDropdown<String?>(
                value: cubit.gender,
                hint: t.common.any,
                items: _genderOptions
                    .map(
                      (o) => DropdownMenuItem<String?>(
                        value: o.value,
                        child: Text(o.label),
                      ),
                    )
                    .toList(),
                onChanged: (v) => cubit.setGender(v),
              ),
              const SizedBox(height: 16),
              _FieldLabel(t.common.age_range),
              const SizedBox(height: 8),
              _AppDropdown<String>(
                value: _currentAgeLabel(cubit),
                hint: t.common.any,
                items: _ageRanges
                    .map(
                      (o) => DropdownMenuItem<String>(
                        value: o.label,
                        child: Text(o.label),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  final range =
                      _ageRanges.firstWhere((r) => r.label == v, orElse: () => _ageRanges.first);
                  cubit.setAgeRange(range.min, range.max);
                },
              ),
              const SizedBox(height: 16),
              _FieldLabel(t.offer.country),
              const SizedBox(height: 8),
              BlocBuilder<RegionCubit, RegionState>(
                builder: (context, regionState) {
                  final regions = regionState.maybeWhen(
                    regionsLoaded: (data) => data,
                    orElse: () => <RegionEntity>[],
                  );
                  return _AppDropdown<RegionEntity>(
                    value: cubit.country,
                    hint: t.common.select_country,
                    items: regions
                        .map(
                          (r) => DropdownMenuItem<RegionEntity>(
                            value: r,
                            child: Text(r.name),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => cubit.setCountry(v),
                  );
                },
              ),
              const SizedBox(height: 16),
              _FieldLabel(t.offer.city),
              const SizedBox(height: 8),
              BlocBuilder<CityCubit, CityState>(
                builder: (context, cityState) {
                  final cities = cityState is CityLoaded
                      ? cityState.data
                      : <CityEntity>[];
                  return _AppDropdown<CityEntity>(
                    value: cubit.city,
                    hint: t.choose.select_city,
                    items: cities
                        .map(
                          (c) => DropdownMenuItem<CityEntity>(
                            value: c,
                            child: Text(c.name),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => cubit.setCity(v),
                  );
                },
              ),
              const SizedBox(height: 16),
              _FieldLabel(t.offer.followers_min),
              const SizedBox(height: 8),
              _AppDropdown<int?>(
                value: cubit.followersMin,
                hint: t.common.any,
                items: _followersOptions
                    .map(
                      (o) => DropdownMenuItem<int?>(
                        value: o.value,
                        child: Text(o.label),
                      ),
                    )
                    .toList(),
                onChanged: (v) => cubit.setFollowersMin(v),
              ),
              const SizedBox(height: 16),
              _FieldLabel(t.offer.followers_max),
              const SizedBox(height: 8),
              _AppDropdown<int?>(
                value: cubit.followersMax,
                hint: t.common.any,
                items: _followersOptions
                    .map(
                      (o) => DropdownMenuItem<int?>(
                        value: o.value,
                        child: Text(o.label),
                      ),
                    )
                    .toList(),
                onChanged: (v) => cubit.setFollowersMax(v),
              ),
              const SizedBox(height: 16),
              _FieldLabel(t.offer.engagement_rate),
              const SizedBox(height: 8),
              _AppDropdown<String?>(
                value: cubit.engagementRate,
                hint: t.common.any,
                items: _engagementOptions
                    .map(
                      (o) => DropdownMenuItem<String?>(
                        value: o.value,
                        child: Text(o.label),
                      ),
                    )
                    .toList(),
                onChanged: (v) => cubit.setEngagementRate(v),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  String? _currentAgeLabel(CreateOfferCubit cubit) {
    if (cubit.ageMin == null && cubit.ageMax == null) return null;
    for (final r in _ageRanges) {
      if (r.min == cubit.ageMin && r.max == cubit.ageMax) return r.label;
    }
    return null;
  }
}

// ---------------------------------------------------------------------------
// Step 3 – Details
// ---------------------------------------------------------------------------

class _Step3Details extends StatelessWidget {
  const _Step3Details();

  List<_Option<String?>> get _durationOptions => [
    _Option(label: t.common.any, value: null),
    _Option(label: t.common.duration_1_week, value: '1_week'),
    _Option(label: t.common.duration_2_weeks, value: '2_weeks'),
    _Option(label: t.common.duration_1_month, value: '1_month'),
    _Option(label: t.common.duration_2_months, value: '2_months'),
    _Option(label: t.common.duration_3_months, value: '3_months'),
  ];

  List<_Option<String?>> get _visibilityOptions => [
    _Option(label: t.common.public, value: 'public'),
    _Option(label: t.common.private, value: 'private'),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateOfferCubit>();

    return BlocBuilder<CreateOfferCubit, CreateOfferState>(
      builder: (context, state) {
        final deadline = cubit.deadline;
        final deadlineText = deadline != null
            ? '${deadline.day.toString().padLeft(2, '0')}.${deadline.month.toString().padLeft(2, '0')}.${deadline.year}'
            : null;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldLabel(t.offer.duration),
              const SizedBox(height: 8),
              _AppDropdown<String?>(
                value: cubit.duration,
                hint: t.common.any,
                items: _durationOptions
                    .map(
                      (o) => DropdownMenuItem<String?>(
                        value: o.value,
                        child: Text(o.label),
                      ),
                    )
                    .toList(),
                onChanged: (v) => cubit.setDuration(v),
              ),
              const SizedBox(height: 16),
              _FieldLabel(t.common.deadline),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: cubit.deadline ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                  );
                  if (picked != null) cubit.setDeadline(picked);
                },
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.lightBg3,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          deadlineText ?? t.common.date_format_hint,
                          style: Typographies.bodyMedium.copyWith(
                            color: deadlineText != null
                                ? AppColors.black
                                : AppColors.grey,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.grey,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _FieldLabel(t.offer.visibility),
              const SizedBox(height: 8),
              _AppDropdown<String?>(
                value: cubit.visibility,
                hint: t.common.select_visibility,
                items: _visibilityOptions
                    .map(
                      (o) => DropdownMenuItem<String?>(
                        value: o.value,
                        child: Text(o.label),
                      ),
                    )
                    .toList(),
                onChanged: (v) => cubit.setVisibility(v),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Success screen
// ---------------------------------------------------------------------------

class _SuccessScreen extends StatelessWidget {
  const _SuccessScreen();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 24),
          Text(
            t.offer.new_offer_success,
            textAlign: TextAlign.center,
            style: Typographies.titleMedium,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom buttons
// ---------------------------------------------------------------------------

class _BottomButtons extends StatelessWidget {
  const _BottomButtons({
    required this.isLastStep,
    required this.isLoading,
    required this.onCancel,
    required this.onContinue,
  });

  final bool isLastStep;
  final bool isLoading;
  final VoidCallback onCancel;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + bottom),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onCancel,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.lightBg3,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Center(
                  child: Text(t.common.cancel, style: Typographies.labelLarge),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: isLoading
                ? Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : AppButtons.primary(
                    title: isLastStep ? t.common.confirm : t.common.continue_label,
                    onTap: onContinue,
                  ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared widgets / helpers
// ---------------------------------------------------------------------------

class _AppTextField extends StatelessWidget {
  const _AppTextField({
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Typographies.bodyMedium.copyWith(color: AppColors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

class _AppDropdown<T> extends StatelessWidget {
  const _AppDropdown({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  final T? value;
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.lightBg3,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          hint: Text(
            hint,
            style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
          ),
          value: value,
          items: items,
          onChanged: onChanged,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          borderRadius: BorderRadius.circular(12),
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: Typographies.titleSmall);
  }
}

class _Option<T> {
  final String label;
  final T value;
  const _Option({required this.label, required this.value});
}

class _AgeRange {
  final String label;
  final int? min;
  final int? max;
  const _AgeRange({required this.label, required this.min, required this.max});
}
