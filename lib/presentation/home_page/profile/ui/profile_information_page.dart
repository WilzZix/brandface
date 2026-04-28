import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/registration/registration_entity.dart';
import 'package:brandface/presentation/home_page/profile/bloc/delete_account/delete_account_cubit.dart';
import 'package:brandface/presentation/login/ui/login_page.dart';
import 'package:brandface/presentation/registration/ui/fill_profile_information_page.dart';
import 'package:brandface/uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/di/app_di.dart';
import '../../../../core/i18n/strings.g.dart';
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

  void _showDeleteConfirmation(BuildContext context) {
    BrandfaceBottomSheet.openBottomSheet<void>(
      context: context,
      header: t.profile.delete_account,
      onConfirm: () {
        context.pop();
        context.read<DeleteAccountCubit>().deleteAccount();
      },
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Text(
            t.profile.confirm_delete,
            style: Typographies.labelLarge,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteAccountCubit>(
      create: (_) => sl<DeleteAccountCubit>(),
      child: BlocListener<DeleteAccountCubit, DeleteAccountState>(
        listener: (context, state) async {
          if (state is DeleteAccountSuccess) {
            final prefs = sl<SharedPreferences>();
            await prefs.clear();
            if (context.mounted) {
              context.go(LoginPage.tag);
            }
          } else if (state is DeleteAccountFailure) {
            BrandfaceBottomSheet.openFailureBottomSheet(
              context: context,
              message: state.failure.localized,
            );
          }
        },
        child: Builder(builder: (context) => _buildScaffold(context)),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.registration.profile_information),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              context.pushNamed(
                FillProfileInformationPage.tag,
                extra: RegistrationEntity(
                  role: sl<ProfileService>().getRole() ?? 'influencer',
                  profileId: sl<ProfileService>().getProfileId() ?? 1,
                  isEditMode: true,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SvgPicture.asset(AppAssets.icPen),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: BlocConsumer<ProfileInformationCubit, ProfileInformationState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      infoLoaded: (data) {
                        return ProfileInformationBody(data: data);
                      },
                      loading: () {
                        return ProfileShimmer();
                      },
                      orElse: () {
                        return SizedBox();
                      },
                    );
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
            Padding(
              padding: EdgeInsets.only(
                top: 16,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              child: GestureDetector(
                onTap: () => _showDeleteConfirmation(context),
                child: Text(
                  t.profile.delete_account,
                  style: Typographies.titleMedium.copyWith(color: AppColors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
