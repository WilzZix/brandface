import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/registration/registration_entity.dart';
import 'package:brandface/presentation/home_page/profile/bloc/delete_account/delete_account_cubit.dart';
import 'package:brandface/presentation/login/ui/login_page.dart';
import 'package:brandface/presentation/registration/ui/fill_profile_information_page.dart';
import 'package:brandface/uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/components/ui_components/title_description_widget.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrandProfilePage extends StatefulWidget {
  const BrandProfilePage({super.key});

  static const String tag = '/brand-profile-page';

  @override
  State<BrandProfilePage> createState() => _BrandProfilePageState();
}

class _BrandProfilePageState extends State<BrandProfilePage> {
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
            t.profile.delete_account_confirm,
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
            if (context.mounted) context.go(LoginPage.tag);
          } else if (state is DeleteAccountFailure) {
            BrandfaceBottomSheet.openFailureBottomSheet(
              context: context,
              message: state.failure.localized,
            );
          }
        },
        child: Builder(builder: (ctx) => _buildScaffold(ctx)),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    final profileService = sl<ProfileService>();

    return Scaffold(
      appBar: AppBar(
        title: Text(t.brand.brand_profile),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              context.pushNamed(
                FillProfileInformationPage.tag,
                extra: RegistrationEntity(
                  role: profileService.getRole() ?? 'brand',
                  profileId: profileService.getProfileId() ?? 0,
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
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _HeaderSection(),
                    const SizedBox(height: 16),
                    Text(t.profile.general_info, style: Typographies.titleSmall),
                    const SizedBox(height: 8),
                    AppContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleDescriptionWidget(
                            title: t.registration.region,
                            descriptionItem: Text('—', style: Typographies.bodyMedium),
                          ),
                          const SizedBox(height: 16),
                          TitleDescriptionWidget(
                            title: t.registration.city,
                            descriptionItem: Text('—', style: Typographies.bodyMedium),
                          ),
                          const SizedBox(height: 16),
                          TitleDescriptionWidget(
                            title: t.registration.sphere,
                            descriptionItem: Text('—', style: Typographies.bodyMedium),
                          ),
                          const SizedBox(height: 16),
                          TitleDescriptionWidget(
                            title: t.registration.profile_information,
                            descriptionItem: Text('—', style: Typographies.bodyMedium),
                          ),
                          const SizedBox(height: 16),
                          TitleDescriptionWidget(
                            title: t.brand.website,
                            descriptionItem: Text('—', style: Typographies.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(t.registration.contact_details, style: Typographies.titleSmall),
                    const SizedBox(height: 8),
                    AppContainer(
                      child: TitleDescriptionWidget(
                        title: t.registration.contact_details,
                        descriptionItem: Text('—', style: Typographies.bodyMedium),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(t.registration.categories, style: Typographies.titleSmall),
                    const SizedBox(height: 8),
                    AppContainer(
                      child: TitleDescriptionWidget(
                        title: t.registration.categories,
                        descriptionItem: Text('—', style: Typographies.bodyMedium),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 16,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final prefs = sl<SharedPreferences>();
                      await prefs.clear();
                      if (context.mounted) context.go(LoginPage.tag);
                    },
                    child: Text(
                      t.profile.log_out,
                      style: Typographies.titleMedium.copyWith(color: AppColors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AvatarWidget(avatarUrl: null),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.brand.title,
                style: Typographies.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                t.registration.brand,
                style: Typographies.bodySmall.copyWith(color: AppColors.mutedBlack),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget({this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          '${ApiRoutes.mediaBaseUrl}$avatarUrl',
          width: 72,
          height: 72,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) => _placeholder(),
        ),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/im_person_avatar_sample.png',
          width: 72,
          height: 72,
          fit: BoxFit.cover,
        ),
      );
}
