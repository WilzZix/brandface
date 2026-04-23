import 'package:brandface/core/error/failures.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/home_page/home_page.dart';
import 'package:brandface/presentation/registration/bloc/audience/audience_cubit.dart';
import 'package:brandface/presentation/registration/bloc/award/award_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/category/category_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/language/language_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/region/region_cubit.dart';
import 'package:brandface/presentation/registration/bloc/catalog/service_type/service_type_cubit.dart';
import 'package:brandface/presentation/registration/bloc/fill_profile/fill_profile_bloc.dart';
import 'package:brandface/presentation/registration/bloc/get_profile/get_profile_cubit.dart';
import 'package:brandface/presentation/registration/ui/components/ambassador_contract_page_view.dart';
import 'package:brandface/presentation/registration/ui/components/ambassador_experience_page_view.dart';
import 'package:brandface/presentation/registration/ui/components/brand_categories_page_view.dart';
import 'package:brandface/presentation/registration/ui/components/brand_info_page_view.dart';
import 'package:brandface/presentation/registration/ui/components/brandface_camera_experience_page_view.dart';
import 'package:brandface/presentation/registration/ui/components/brandface_pricing_page_view.dart';
import 'package:brandface/presentation/registration/ui/components/brandface_segment_page_view.dart';
import 'package:brandface/presentation/registration/ui/components/services_page_view.dart';
import 'package:brandface/uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/di/app_di.dart';
import '../../../domain/entities/registration/registration_entity.dart';
import '../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import 'components/audience_and_followers_page_view.dart';
import 'components/experience_page_view.dart';
import 'components/general_info_page_view.dart';
import 'components/my_pricing_tariffs_page_view.dart';
import 'components/niche_page_view.dart';

class FillProfileInformationPage extends StatefulWidget {
  const FillProfileInformationPage({
    super.key,
    required this.registrationEntity,
  });

  static const String tag = '/fill_profile_information';
  final RegistrationEntity registrationEntity;

  @override
  State<FillProfileInformationPage> createState() =>
      _FillProfileInformationPageState();
}

class _FillProfileInformationPageState
    extends State<FillProfileInformationPage> {
  List<Widget> _cachedWidgets = [];
  List<String> _pageTitles = [];
  bool _isProfileLoading = true;

  PageController pageController = PageController();
  FillInfluencerProfileParam _finalParam = FillInfluencerProfileParam();
  int _currentPage = 0;

  int get _totalPages => _cachedWidgets.length;

  @override
  void initState() {
    super.initState();
    context.read<FillProfileBloc>().setEditMode(
      widget.registrationEntity.isEditMode,
    );
    if (widget.registrationEntity.isEditMode) {
      context.read<GetProfileCubit>().getMyProfile();
    } else {
      context.read<GetProfileCubit>().getProfile(
        profileId: widget.registrationEntity.profileId.toString(),
      );
    }
  }

  void _buildWidgetsAndTitles() {
    final List<String> titles;
    final List<Widget> widgets;

    switch (widget.registrationEntity.role) {
      case 'influencer':
        titles = [
          'General info',
          'Niche',
          'Services',
          'Audience and followers',
          'Experience',
          'My Pricing/Tariffs',
        ];
        widgets = [
          BlocProvider(
            create: (context) => sl<LanguageCubit>(),
            child: GeneralInfoPageView(
              initialParam: _finalParam,
              key: const PageStorageKey<String>('pageOne'),
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(
                  displayName: p1.displayName,
                  avatarId: p1.avatarId,
                  bio: p1.bio,
                  regionId: p1.regionId,
                  cityId: p1.cityId,
                  birthDate: p1.birthDate,
                  gender: p1.gender,
                  languageIds: p1.languageIds,
                  categoryIds: p1.categoryIds,
                  serviceIds: p1.serviceIds,
                  audience: p1.audience,
                  yearsOfExperience: p1.yearsOfExperience,
                  partners: p1.partners,
                  pricing: p1.pricing,
                  contacts: p1.contacts,
                );
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<CategoryCubit>(),
            child: NichePageView(
              key: const PageStorageKey<String>('pageTwo'),
              initialCategoryIds: _finalParam.categoryIds,
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(categoryIds: p1.categoryIds);
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<ServiceTypeCubit>(),
            child: ServicesPageView(
              key: const PageStorageKey<String>('pageThree'),
              initialServiceIds: _finalParam.serviceIds,
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(serviceIds: p1.serviceIds);
              },
            ),
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<RegionCubit>()),
              BlocProvider(create: (context) => sl<AudienceCubit>()),
            ],
            child: AudienceAndFollowersPageView(
              key: const PageStorageKey<String>('pageFour'),
              initialParam: _finalParam,
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(audience: p1.audience);
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<AwardCubit>(),
            child: ExperiencePageView(
              key: const PageStorageKey<String>('pageFive'),
              initialParam: _finalParam,
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(
                  yearsOfExperience: p1.yearsOfExperience,
                  partners: p1.partners,
                );
              },
            ),
          ),
          MyPricingTariffsPageView(
            key: const PageStorageKey<String>('pageSix'),
            initialParam: _finalParam,
            onChanged: (p1) {
              _finalParam = _finalParam.copyWith(pricing: p1.pricing);
            },
          ),
        ];

      case 'ambassador':
        titles = [
          'General info',
          'Niche',
          'Services',
          'Audience & followers',
          'Experience',
          'Contract',
        ];
        widgets = [
          BlocProvider(
            create: (context) => sl<LanguageCubit>(),
            child: GeneralInfoPageView(
              initialParam: _finalParam,
              key: const PageStorageKey<String>('pageOne'),
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(
                  displayName: p1.displayName,
                  avatarId: p1.avatarId,
                  bio: p1.bio,
                  regionId: p1.regionId,
                  cityId: p1.cityId,
                  birthDate: p1.birthDate,
                  gender: p1.gender,
                  contacts: p1.contacts,
                  languageIds: p1.languageIds,
                  categoryIds: p1.categoryIds,
                  serviceIds: p1.serviceIds,
                  audience: p1.audience,
                  yearsOfExperience: p1.yearsOfExperience,
                  partners: p1.partners,
                  pricing: p1.pricing,
                );
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<CategoryCubit>(),
            child: NichePageView(
              key: const PageStorageKey<String>('pageTwo'),
              initialCategoryIds: _finalParam.categoryIds,
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(categoryIds: p1.categoryIds);
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<ServiceTypeCubit>(),
            child: ServicesPageView(
              key: const PageStorageKey<String>('pageThree'),
              initialServiceIds: _finalParam.serviceIds,
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(serviceIds: p1.serviceIds);
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<RegionCubit>(),
            child: AudienceAndFollowersPageView(
              key: const PageStorageKey<String>('pageFour'),
              initialParam: _finalParam,
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(audience: p1.audience);
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<AwardCubit>(),
            child: AmbassadorExperiencePageView(
              key: const PageStorageKey<String>('pageFive'),
              onChanged: (p1) {},
            ),
          ),
          AmbassadorContractPageView(
            key: const PageStorageKey<String>('pageSix'),
            onChanged: (p1) {
              _finalParam = _finalParam.copyWith(pricing: p1.pricing);
            },
          ),
        ];

      case 'brandface':
        titles = [
          'General info',
          'Niche',
          'Services',
          'Audience and followers',
          'Camera experience',
          'My Pricing/Tariffs',
        ];
        widgets = [
          BlocProvider(
            create: (context) => sl<LanguageCubit>(),
            child: GeneralInfoPageView(
              initialParam: _finalParam,
              key: const PageStorageKey<String>('pageOne'),
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(
                  displayName: p1.displayName,
                  avatarId: p1.avatarId,
                  bio: p1.bio,
                  regionId: p1.regionId,
                  cityId: p1.cityId,
                  birthDate: p1.birthDate,
                  gender: p1.gender,
                  contacts: p1.contacts,
                  languageIds: p1.languageIds,
                  categoryIds: p1.categoryIds,
                  serviceIds: p1.serviceIds,
                  audience: p1.audience,
                  yearsOfExperience: p1.yearsOfExperience,
                  partners: p1.partners,
                  pricing: p1.pricing,
                );
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<CategoryCubit>(),
            child: NichePageView(
              key: const PageStorageKey<String>('pageTwo'),
              initialCategoryIds: _finalParam.categoryIds,
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(categoryIds: p1.categoryIds);
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<ServiceTypeCubit>(),
            child: ServicesPageView(
              key: const PageStorageKey<String>('pageThree'),
              initialServiceIds: _finalParam.serviceIds,
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(serviceIds: p1.serviceIds);
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<RegionCubit>(),
            child: BrandfaceSegmentPageView(
              key: const PageStorageKey<String>('pageFour'),
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(audience: p1.audience);
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<AwardCubit>(),
            child: BrandfaceCameraExperiencePageView(
              key: const PageStorageKey<String>('pageFive'),
              onChanged: (p1) {},
            ),
          ),
          BrandfacePricingPageView(
            key: const PageStorageKey<String>('pageSix'),
            initialParam: _finalParam,
            onChanged: (p1) {
              _finalParam = _finalParam.copyWith(pricing: p1.pricing);
            },
          ),
        ];

      case 'brand':
        titles = ['General info', 'Categories'];
        widgets = [
          BrandInfoPageView(
            key: const PageStorageKey<String>('pageOne'),
            onChanged: (p1) {
              _finalParam = _finalParam.copyWith(
                regionId: p1.regionId,
                cityId: p1.cityId,
              );
            },
          ),
          BlocProvider(
            create: (context) => sl<CategoryCubit>(),
            child: BrandCategoriesPageView(
              key: const PageStorageKey<String>('pageTwo'),
              onChanged: (p1) {
                _finalParam = _finalParam.copyWith(categoryIds: p1.categoryIds);
              },
            ),
          ),
        ];

      default:
        titles = [];
        widgets = [];
    }

    setState(() {
      _pageTitles = titles;
      _cachedWidgets = widgets;
      _isProfileLoading = false;
    });
  }

  void _saveAndContinueLater() {
    context.read<FillProfileBloc>().add(
      FillProfileEvent.fillProfile(
        profile: widget.registrationEntity.profileId.toString(),
        params: _finalParam,
      ),
    );
  }

  String get _pageViewTitle =>
      '${_pageTitles[_currentPage]} (${_currentPage + 1}/$_totalPages)';

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FillProfileBloc, FillProfileState>(
          listener: (context, state) {
            state.maybeWhen(
              filled: () {
                context.go(HomePage.tag);
              },
              fillingFailure: (failure) {
                BrandfaceBottomSheet.openFailureBottomSheet(
                  context: context,
                  message: failure.localized,
                );
              },
              orElse: () {},
            );
          },
        ),
        BlocListener<GetProfileCubit, GetProfileState>(
          listener: (context, state) {
            state.maybeWhen(
              profileLoaded: (data) {
                _finalParam = data.toParam();
                _buildWidgetsAndTitles();
              },
              profileLoadFailure: (_) {
                _buildWidgetsAndTitles();
              },
              orElse: () {},
            );
          },
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: _isProfileLoading
            ? null
            : Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppButtons.primary(
                      title: t.onboarding.kContinue,
                      onTap: () {
                        if (_currentPage < _totalPages - 1) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          context.read<FillProfileBloc>().add(
                            FillProfileEvent.fillProfile(
                              profile: widget.registrationEntity.profileId
                                  .toString(),
                              params: _finalParam,
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: _saveAndContinueLater,
                      child: Text(
                        'Save and continue later',
                        style: Typographies.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
        body: _isProfileLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16 + MediaQuery.of(context).padding.top),
                    Text(
                      'Fill profile information',
                      style: Typographies.headlineSmall,
                    ),
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: _currentPage > 0
                              ? () {
                                  pageController.previousPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(999),
                              color: AppColors.lightBg2,
                            ),
                            child: SvgPicture.asset(AppAssets.icArrowLeft),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(999),
                              color: AppColors.black,
                            ),
                            child: Center(
                              child: Text(
                                _pageViewTitle,
                                style: Typographies.labelMedium.copyWith(
                                  color: AppColors.lightBg,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: _currentPage < _totalPages - 1
                              ? () {
                                  pageController.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(999),
                              color: AppColors.lightBg2,
                            ),
                            child: SvgPicture.asset(AppAssets.icArrowRight),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        scrollDirection: Axis.horizontal,
                        controller: pageController,
                        itemCount: _cachedWidgets.length,
                        itemBuilder: (context, index) {
                          return _cachedWidgets[index];
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
