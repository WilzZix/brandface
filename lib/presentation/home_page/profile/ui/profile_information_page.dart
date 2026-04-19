import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/profile_information/profile_information_cubit.dart';
import 'components/profile_information_body.dart';
import 'components/profile_shimmer.dart';

class ProfileInformationPage extends StatefulWidget {
  const ProfileInformationPage({super.key});

  static const String tag = '/profile-information-page';

  @override
  State<ProfileInformationPage> createState() => _ProfileInformationPageState();
}

class _ProfileInformationPageState extends State<ProfileInformationPage> {
  @override
  void initState() {
    context.read<ProfileInformationCubit>().getInfluencerProfileInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile information'),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SvgPicture.asset(AppAssets.icPen),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: BlocConsumer<ProfileInformationCubit, ProfileInformationState>(
            builder: (context, state) {
              state.maybeWhen(
                infoLoaded: (data) {
                  return ProfileInformationBody(data: data);
                },
                loading: () {
                  return ProfileShimmer();
                },
                orElse: () {},
              );
              return SizedBox();
            },
            listener: (BuildContext context, ProfileInformationState state) {
              state.maybeWhen(
                failure: (failure) {
                  BrandfaceBottomSheet.openFailureBottomSheet(
                    context: context,
                    message: failure.localized,
                  );
                },
                orElse: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}
