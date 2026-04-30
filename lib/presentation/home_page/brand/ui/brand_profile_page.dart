import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/data/models/profile/catalog/category_model.dart';
import 'package:brandface/domain/entities/profile/influencer_profile_information_entity.dart';
import 'package:brandface/domain/entities/profile/profile_entity.dart';
import 'package:brandface/domain/entities/registration/registration_entity.dart';
import 'package:brandface/presentation/home_page/profile/bloc/profile_information/profile_information_cubit.dart';
import 'package:brandface/presentation/registration/ui/fill_profile_information_page.dart';
import 'package:brandface/uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import 'package:brandface/uikit/components/ui_components/app_container.dart';
import 'package:brandface/uikit/components/ui_components/badge.dart';
import 'package:brandface/uikit/components/ui_components/title_description_widget.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:brandface/utils/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BrandProfilePage extends StatelessWidget {
  const BrandProfilePage({super.key});

  static const String tag = '/brand-profile-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.brand.brand_profile),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              final profileService = sl<ProfileService>();
              context.pushNamed(
                FillProfileInformationPage.tag,
                extra: RegistrationEntity(
                  role: profileService.getResolvedRole(fallback: 'brand'),
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
      body: BlocConsumer<ProfileInformationCubit, ProfileInformationState>(
        listener: (context, state) {
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
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            infoLoaded: (data) => _BrandProfileBody(data: data),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _BrandProfileBody extends StatelessWidget {
  const _BrandProfileBody({required this.data});

  final InfluencerProfileInformationEntity data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderSection(data: data),
          const SizedBox(height: 16),
          Text(t.profile.general_info, style: Typographies.titleSmall),
          const SizedBox(height: 8),
          AppContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleDescriptionWidget(
                  title: t.registration.region,
                  descriptionItem: Text(
                    data.region?.name ?? '—',
                    style: Typographies.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                TitleDescriptionWidget(
                  title: t.registration.city,
                  descriptionItem: Text(
                    data.city?.name ?? '—',
                    style: Typographies.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),
                TitleDescriptionWidget(
                  title: t.registration.sphere,
                  descriptionItem: Text('—', style: Typographies.bodyMedium),
                ),
                const SizedBox(height: 16),
                TitleDescriptionWidget(
                  title: t.registration.profile_information,
                  descriptionItem: Text(
                    data.bio?.isNotEmpty == true ? data.bio! : '—',
                    style: Typographies.bodyMedium,
                  ),
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
            child: _ContactDetailsWidget(contacts: data.contacts),
          ),
          const SizedBox(height: 16),
          Text(t.registration.categories, style: Typographies.titleSmall),
          const SizedBox(height: 8),
          AppContainer(
            child: _CategoriesWidget(categories: data.categories),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 24),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({required this.data});

  final InfluencerProfileInformationEntity data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AvatarWidget(avatarUrl: data.avatarUrl),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.displayName?.isNotEmpty == true
                    ? data.displayName!
                    : t.brand.title,
                style: Typographies.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                t.registration.brand,
                style: Typographies.bodySmall.copyWith(
                  color: AppColors.mutedBlack,
                ),
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

class _ContactDetailsWidget extends StatelessWidget {
  const _ContactDetailsWidget({this.contacts});

  final List<ContactEntity>? contacts;

  @override
  Widget build(BuildContext context) {
    if (contacts == null || contacts!.isEmpty) {
      return Text(t.common.no_contact_details, style: Typographies.bodyMedium);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contacts!.indexed.map(((int, ContactEntity) entry) {
        final index = entry.$1;
        final c = entry.$2;
        return Padding(
          padding: EdgeInsets.only(bottom: index < contacts!.length - 1 ? 16 : 0),
          child: TitleDescriptionWidget(
            title: _contactLabel(c.type),
            descriptionItem: Text(
              c.value ?? '—',
              style: Typographies.bodyMedium,
            ),
          ),
        );
      }).toList(),
    );
  }

  String _contactLabel(String? type) {
    switch (type?.toLowerCase()) {
      case 'phone':
        return t.contact.phone;
      case 'telegram':
        return t.contact.telegram;
      case 'instagram':
        return t.contact.instagram;
      default:
        return type ?? '';
    }
  }
}

class _CategoriesWidget extends StatelessWidget {
  const _CategoriesWidget({this.categories});

  final List<CategoryData>? categories;

  @override
  Widget build(BuildContext context) {
    if (categories == null || categories!.isEmpty) {
      return Text('—', style: Typographies.bodyMedium);
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories!
          .map((c) => AppBadge(title: c.name ?? ''))
          .toList(),
    );
  }
}
