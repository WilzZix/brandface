import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/catalog/service_type/service_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/profile/catalog/service_type_entity.dart' show ServiceTypeEntity;
import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_services.dart';
import 'choose_spoken_language.dart';

class ServicesPageView extends StatefulWidget {
  const ServicesPageView({
    super.key,
    required this.onChanged,
    this.initialServiceIds,
  });

  final Function(FillInfluencerProfileParam) onChanged;
  final List<int>? initialServiceIds;

  @override
  State<ServicesPageView> createState() => _ServicesPageViewState();
}

class _ServicesPageViewState extends State<ServicesPageView>
    with AutomaticKeepAliveClientMixin<ServicesPageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final List<LangItemModel> _selectedNichesItems = [];
  bool _prefilledFromInitial = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialServiceIds != null && widget.initialServiceIds!.isNotEmpty) {
      _param = _param.copyWith(serviceIds: widget.initialServiceIds);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final svcState = context.read<ServiceTypeCubit>().state;
        svcState.maybeWhen(
          serviceTypeLoaded: (data) => _tryPrefill(data),
          orElse: () {},
        );
      });
    }
  }

  void _tryPrefill(List<ServiceTypeEntity> serviceTypes) {
    if (_prefilledFromInitial) return;
    final ids = widget.initialServiceIds;
    if (ids == null || ids.isEmpty) return;
    final matched = serviceTypes
        .where((s) => ids.contains(s.id))
        .map((s) => LangItemModel(name: s.name, id: s.id))
        .toList();
    if (matched.isNotEmpty && mounted) {
      setState(() {
        for (final item in matched) {
          if (!_selectedNichesItems.any((e) => e.id == item.id)) {
            _selectedNichesItems.add(item);
          }
        }
        _prefilledFromInitial = true;
      });
    }
  }

  void _updateData() {
    _param = _param.copyWith(
      serviceIds: _selectedNichesItems.map((e) => e.id).toList(),
    );
    widget.onChanged(_param);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<ServiceTypeCubit, ServiceTypeState>(
      listener: (context, state) {
        state.maybeWhen(
          serviceTypeLoaded: (data) => _tryPrefill(data),
          orElse: () {},
        );
      },
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.registration.services, style: Typographies.titleMedium),
            const SizedBox(height: 24),
            BlocBuilder<ServiceTypeCubit, ServiceTypeState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const SizedBox(
                    height: 32,
                    child: Center(child: LinearProgressIndicator()),
                  ),
                  serviceTypeLoaded: (serviceTypes) {
                    if (serviceTypes.isEmpty) return const SizedBox.shrink();
                    return SizedBox(
                      height: 32,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: serviceTypes.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final service = serviceTypes[index];
                          final isSelected = _selectedNichesItems.any(
                            (e) => e.id == service.id,
                          );
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedNichesItems.removeWhere(
                                    (e) => e.id == service.id,
                                  );
                                } else {
                                  _selectedNichesItems.add(
                                    LangItemModel(
                                      name: service.name,
                                      id: service.id,
                                    ),
                                  );
                                }
                                _updateData();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryDark
                                    : AppColors.lightGreen,
                                border: Border.all(
                                  color: AppColors.primaryDark,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                service.name,
                                style: Typographies.labelMedium.copyWith(
                                  color: isSelected ? AppColors.lightBg : null,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
            SizedBox(height: 16),
            ChooseServices(
              onItemSelected: (LangItemModel item) {
                setState(() {
                  if (!_selectedNichesItems.any((e) => e.id == item.id)) {
                    _selectedNichesItems.add(item);
                    _updateData();
                  }
                });
              },
            ),
            const SizedBox(height: 32),
            if (_selectedNichesItems.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.registration.services, style: Typographies.titleSmall),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _selectedNichesItems.length,
                    itemBuilder: (context, index) {
                      final niche = _selectedNichesItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(niche.name, style: Typographies.bodyMedium),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedNichesItems.removeAt(index);
                                  _updateData();
                                });
                              },
                              child: Text(
                                t.common.delete,
                                style: Typographies.labelLarge.copyWith(
                                  color: AppColors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
