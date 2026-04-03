import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/fill_profile/fill_profile_bloc.dart';
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
import '../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import 'components/choose_services.dart';
import 'components/general_info_page_view.dart';
import 'components/niche_page_view.dart';

class FillProfileInformationPage extends StatefulWidget {
  const FillProfileInformationPage({super.key});

  static const String tag = '/fill_profile_information';

  @override
  State<FillProfileInformationPage> createState() =>
      _FillProfileInformationPageState();
}

class _FillProfileInformationPageState
    extends State<FillProfileInformationPage> {
  List<Widget> get fillProfileWidgets => [
    SizedBox(
      child: GeneralInfoPageView(
        key: PageStorageKey<String>('pageOne'),
        onChanged: (FillInfluencerProfileParam p1) {
          _finalParam = p1;
        },
      ),
    ),
    SizedBox(
      child: NichePageView(
        key: PageStorageKey<String>('pageSecond'),
        onChanged: (FillInfluencerProfileParam p1) {},
      ),
    ),
    SizedBox(
      child: ServicesPageView(
        key: PageStorageKey<String>('pageThird'),
        onChanged: (FillInfluencerProfileParam p1) {},
      ),
    ),
    SizedBox(
      child: NichePageView(
        key: PageStorageKey<String>('pageFour'),
        onChanged: (FillInfluencerProfileParam p1) {},
      ),
    ),
    SizedBox(
      child: NichePageView(
        key: PageStorageKey<String>('pageFive'),
        onChanged: (FillInfluencerProfileParam p1) {},
      ),
    ),
    SizedBox(
      child: NichePageView(
        key: PageStorageKey<String>('pageSix'),
        onChanged: (FillInfluencerProfileParam p1) {},
      ),
    ),
  ];

  PageController pageController = PageController();
  FillInfluencerProfileParam _finalParam = FillInfluencerProfileParam();
  int _currentPage = 0;

  String pageViewTitle() {
    switch (_currentPage) {
      case 0:
        return 'General info (1/6)';
      case 1:
        return 'Niche (2/6)';
      case 2:
        return 'Services (3/6)';
      case 3:
        return 'Audience and followers (4/6)';
      case 4:
        return 'Experience (5/6)';
      case 5:
        return 'My Pricing/Tariffs (6/6)';
      default:
        return 'General info (1/6)';
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
                      // 400ms - optimal vaqt
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(999),
                      color: AppColors.lightBg2,
                    ),
                    child: SvgPicture.asset(AppAssets.icArrowLeft),
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
                          pageViewTitle(),
                          style: Typographies.labelMedium.copyWith(
                            color: AppColors.lightBg,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(999),
                      color: AppColors.lightBg2,
                    ),
                    child: SvgPicture.asset(AppAssets.icArrowRight),
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
