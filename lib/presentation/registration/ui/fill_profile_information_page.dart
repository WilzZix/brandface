import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/fill_profile/fill_profile_bloc.dart';
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

import '../../../core/constants/app_assets.dart';
import '../../../core/enums/enums.dart';
import '../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import 'components/audience_and_followers_page_view.dart';
import 'components/experience_page_view.dart';
import 'components/general_info_page_view.dart';
import 'components/my_pricing_tariffs_page_view.dart';
import 'components/niche_page_view.dart';

class FillProfileInformationPage extends StatefulWidget {
  const FillProfileInformationPage({super.key, required this.userRole});

  static const String tag = '/fill_profile_information';
  final UserRole userRole;

  @override
  State<FillProfileInformationPage> createState() =>
      _FillProfileInformationPageState();
}

class _FillProfileInformationPageState
    extends State<FillProfileInformationPage> {
  List<Widget> get fillProfileWidgets {
    switch (widget.userRole) {
      case UserRole.influencer:
        return [
          SizedBox(
            child: GeneralInfoPageView(
              key: const PageStorageKey<String>('pageOne'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(
                  displayName: p1.displayName,
                  avatarId: p1.avatarId,
                  bio: p1.bio,
                  regionId: p1.regionId,
                  cityId: p1.cityId,
                  birthDate: p1.birthDate,
                  gender: p1.gender,
                );
              },
            ),
          ),
          SizedBox(
            child: NichePageView(
              key: const PageStorageKey<String>('pageTwo'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(categoryIds: p1.categoryIds);
              },
            ),
          ),
          SizedBox(
            child: ServicesPageView(
              key: const PageStorageKey<String>('pageThree'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(serviceIds: p1.serviceIds);
              },
            ),
          ),
          SizedBox(
            child: AudienceAndFollowersPageView(
              key: const PageStorageKey<String>('pageFour'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(audience: p1.audience);
              },
            ),
          ),
          SizedBox(
            child: ExperiencePageView(
              key: const PageStorageKey<String>('pageFive'),
              onChanged: (FillInfluencerProfileParam p1) {
                ///TODO
              },
            ),
          ),
          SizedBox(
            child: MyPricingTariffsPageView(
              key: const PageStorageKey<String>('pageSix'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(pricing: p1.pricing);
              },
            ),
          ),
        ];

      case UserRole.ambassador:
        return [
          SizedBox(
            child: GeneralInfoPageView(
              key: const PageStorageKey<String>('pageOne'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(
                  displayName: p1.displayName,
                  avatarId: p1.avatarId,
                  bio: p1.bio,
                  regionId: p1.regionId,
                  cityId: p1.cityId,
                  birthDate: p1.birthDate,
                  gender: p1.gender,
                );
              },
            ),
          ),
          SizedBox(
            child: NichePageView(
              key: const PageStorageKey<String>('pageTwo'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(categoryIds: p1.categoryIds);
              },
            ),
          ),
          SizedBox(
            child: ServicesPageView(
              key: const PageStorageKey<String>('pageThree'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(serviceIds: p1.serviceIds);
              },
            ),
          ),
          SizedBox(
            child: AudienceAndFollowersPageView(
              key: const PageStorageKey<String>('pageFour'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(audience: p1.audience);
              },
            ),
          ),
          SizedBox(
            child: AmbassadorExperiencePageView(
              key: const PageStorageKey<String>('pageFive'),
              onChanged: (FillInfluencerProfileParam p1) {},
            ),
          ),
          SizedBox(
            child: AmbassadorContractPageView(
              key: const PageStorageKey<String>('pageSix'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(pricing: p1.pricing);
              },
            ),
          ),
        ];

      case UserRole.brandface:
        return [
          SizedBox(
            child: GeneralInfoPageView(
              key: const PageStorageKey<String>('pageOne'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(
                  displayName: p1.displayName,
                  avatarId: p1.avatarId,
                  bio: p1.bio,
                  regionId: p1.regionId,
                  cityId: p1.cityId,
                  birthDate: p1.birthDate,
                  gender: p1.gender,
                );
              },
            ),
          ),
          SizedBox(
            child: NichePageView(
              key: const PageStorageKey<String>('pageTwo'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(categoryIds: p1.categoryIds);
              },
            ),
          ),
          SizedBox(
            child: ServicesPageView(
              key: const PageStorageKey<String>('pageThree'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(serviceIds: p1.serviceIds);
              },
            ),
          ),
          SizedBox(
            child: BrandfaceSegmentPageView(
              key: const PageStorageKey<String>('pageFour'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(audience: p1.audience);
              },
            ),
          ),
          SizedBox(
            child: BrandfaceCameraExperiencePageView(
              key: const PageStorageKey<String>('pageFive'),
              onChanged: (FillInfluencerProfileParam p1) {},
            ),
          ),
          SizedBox(
            child: BrandfacePricingPageView(
              key: const PageStorageKey<String>('pageSix'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(pricing: p1.pricing);
              },
            ),
          ),
        ];

      case UserRole.brand:
        return [
          SizedBox(
            child: BrandInfoPageView(
              key: const PageStorageKey<String>('pageOne'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(
                  regionId: p1.regionId,
                  cityId: p1.cityId,
                );
              },
            ),
          ),
          SizedBox(
            child: BrandCategoriesPageView(
              key: const PageStorageKey<String>('pageTwo'),
              onChanged: (FillInfluencerProfileParam p1) {
                _finalParam = _finalParam.copyWith(categoryIds: p1.categoryIds);
              },
            ),
          ),
        ];
    }
  }

  PageController pageController = PageController();
  FillInfluencerProfileParam _finalParam = FillInfluencerProfileParam();
  int _currentPage = 0;

  int get _totalPages => fillProfileWidgets.length;

  String pageViewTitle(BuildContext context) {
    switch (widget.userRole) {
      case UserRole.influencer:
        const titles = [
          'General info',
          'Niche',
          'Services',
          'Audience and followers',
          'Experience',
          'My Pricing/Tariffs',
        ];
        return '${titles[_currentPage]} (${_currentPage + 1}/$_totalPages)';

      case UserRole.ambassador:
        const titles = [
          'General info',
          'Niche',
          'Services',
          'Audience & followers',
          'Experience',
          'My Pricing/Tariffs',
        ];
        return '${titles[_currentPage]} (${_currentPage + 1}/$_totalPages)';

      case UserRole.brandface:
        const titles = [
          'General info',
          'Niche',
          'Services',
          'Audience and followers',
          'Experience',
          'My Pricing/Tariffs',
        ];
        return '${titles[_currentPage]} (${_currentPage + 1}/$_totalPages)';

      case UserRole.brand:
        const titles = ['General info', 'Categories'];
        return '${titles[_currentPage]} (${_currentPage + 1}/$_totalPages)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FillProfileBloc, FillProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          fillingFailure: (failure) {
            BrandfaceBottomSheet.openFailureBottomSheet(
              context: context,
              message: failure,
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        bottomNavigationBar: Container(
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
                  context.read<FillProfileBloc>().add(
                    FillProfileEvent.fillProfile(
                      profile: '3',
                      params: _finalParam,
                    ),
                  );
                  if (_currentPage < fillProfileWidgets.length - 1) {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Save and continue later',
                  style: Typographies.labelLarge,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
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
                    onTap: () {
                      if (_currentPage > 0) {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
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
                          pageViewTitle(context),
                          style: Typographies.labelMedium.copyWith(
                            color: AppColors.lightBg,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      if (_currentPage < fillProfileWidgets.length - 1) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
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
                  itemCount: fillProfileWidgets.length,
                  itemBuilder: (context, index) {
                    return fillProfileWidgets[index];
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
