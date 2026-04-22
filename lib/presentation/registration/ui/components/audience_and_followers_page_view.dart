import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/audience/audience_cubit.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/profile/catalog/social_media_account_stats_entity.dart';
import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/buttons/buttons.dart';
import '../../../../uikit/components/inputs/from_to_input_field.dart';
import '../../../../uikit/tokens/colors.dart';
import '../../../../uikit/typography/typography.dart';
import 'choose_geography.dart';
import 'choose_social_media_platform.dart';
import 'choose_spoken_language.dart';

class AudienceAndFollowersPageView extends StatefulWidget {
  const AudienceAndFollowersPageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<AudienceAndFollowersPageView> createState() =>
      _AudienceAndFollowersPageViewState();
}

class _AudienceAndFollowersPageViewState
    extends State<AudienceAndFollowersPageView>
    with AutomaticKeepAliveClientMixin<AudienceAndFollowersPageView> {
  late FillInfluencerProfileParam _param;

  final List<LangItemModel> _selectedGeographyItems = [];
  final List<SocialMediaAccount> _selectedSocialMediaAccounts = [];

  late TextEditingController _controllerFrom;
  late TextEditingController _controllerTo;
  late TextEditingController _controllerFromWomen;
  late TextEditingController _controllerToWomen;
  late TextEditingController _controllerSocial;

  String? _selectedPlatform;
  bool _isAddingAccount = false;

  @override
  void initState() {
    super.initState();
    _param = FillInfluencerProfileParam(audience: Audience());

    _controllerFrom = TextEditingController();
    _controllerTo = TextEditingController();
    _controllerFromWomen = TextEditingController();
    _controllerToWomen = TextEditingController();
    _controllerSocial = TextEditingController();

    // Debounced listener for better performance
    _controllerFrom.addListener(_debouncedUpdate);
    _controllerTo.addListener(_debouncedUpdate);
    _controllerFromWomen.addListener(_debouncedUpdate);
    _controllerToWomen.addListener(_debouncedUpdate);
  }

  void _debouncedUpdate() {
    // Consolidate all updates into a single setState call
    _handleUpdate();
  }

  void _handleUpdate() {
    final currentAudience = _param.audience ?? Audience();

    _param = _param.copyWith(
      audience: currentAudience.copyWith(
        menAgeFrom: int.tryParse(_controllerFrom.text),
        menAgeTo: int.tryParse(_controllerTo.text),
        womenAgeFrom: int.tryParse(_controllerFromWomen.text),
        womenAgeTo: int.tryParse(_controllerToWomen.text),
        socialMediaAccounts: _selectedSocialMediaAccounts,
        geography: _selectedGeographyItems.map((e) => e.id.toString()).toList(),
      ),
    );

    widget.onChanged(_param);
  }

  @override
  bool get wantKeepAlive => true;

  void _addSocialAccount() {
    // Validation
    if (_selectedPlatform == null || _controllerSocial.text.trim().isEmpty) {
      _showErrorSnackBar('Fill required fields');
      return;
    }

    if (_isAddingAccount) return; // Prevent duplicate requests

    setState(() => _isAddingAccount = true);

    try {
      // Check for duplicates
      final isDuplicate = _selectedSocialMediaAccounts.any(
        (acc) =>
            acc.platform == _selectedPlatform &&
            acc.username == _controllerSocial.text.trim(),
      );

      if (isDuplicate) {
        _showErrorSnackBar('Account already added');
        return;
      }

      // Add account
      final newAccount = SocialMediaAccount(
        platform: _selectedPlatform!,
        username: _controllerSocial.text.trim(),
      );

      setState(() {
        _selectedSocialMediaAccounts.add(newAccount);
      });

      _handleUpdate();

      // Fetch stats
      context.read<AudienceCubit>().getSocialMediaAccountStats(
        platform: _selectedPlatform ?? '',
        username: _controllerSocial.text.trim(),
      );

      // Clear input
      _controllerSocial.clear();
      _selectedPlatform = null;
    } finally {
      setState(() => _isAddingAccount = false);
    }
  }

  void _removeGeographyItem(int index) {
    setState(() {
      _selectedGeographyItems.removeAt(index);
      _handleUpdate();
    });
  }

  void _removeSocialAccount(int index) {
    setState(() {
      _selectedSocialMediaAccounts.removeAt(index);
      _handleUpdate();
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildGeographySection(),
          const SizedBox(height: 32),
          _buildAgeSection(),
          const SizedBox(height: 32),
          _buildSocialMediaSection(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildGeographySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.registration.geography, style: Typographies.titleMedium),
        const SizedBox(height: 8),
        ChooseGeography(
          onItemSelected: (LangItemModel item) {
            if (!_selectedGeographyItems.any((e) => e.id == item.id)) {
              setState(() {
                _selectedGeographyItems.add(item);
                _handleUpdate();
              });
            }
          },
        ),
        if (_selectedGeographyItems.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildGeographyList(),
        ],
      ],
    );
  }

  Widget _buildGeographyList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _selectedGeographyItems.length,
      itemBuilder: (context, index) {
        final geography = _selectedGeographyItems[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(geography.name, style: Typographies.bodyMedium),
              ),
              GestureDetector(
                onTap: () => _removeGeographyItem(index),
                child: Text(
                  t.common.delete,
                  style: Typographies.labelLarge.copyWith(color: AppColors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAgeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FromToInputField(
          controllerFrom: _controllerFrom,
          controllerTo: _controllerTo,
          title: t.registration.men,
          labelFrom: t.registration.age_from,
          labelTo: t.registration.age_to,
        ),
        const SizedBox(height: 24),
        FromToInputField(
          controllerFrom: _controllerFromWomen,
          controllerTo: _controllerToWomen,
          title: t.registration.women,
          labelFrom: t.registration.age_from,
          labelTo: t.registration.age_to,
        ),
      ],
    );
  }

  Widget _buildSocialMediaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.registration.social_media_accounts,
          style: Typographies.titleSmall,
        ),
        const SizedBox(height: 12),
        ChooseSocialMediaPlatform(
          onItemSelected: (String platform) {
            setState(() => _selectedPlatform = platform);
          },
        ),
        const SizedBox(height: 12),
        _buildAddAccountRow(),
        if (_selectedSocialMediaAccounts.isNotEmpty) ...[
          const SizedBox(height: 20),
          _buildSocialAccountsList(),
        ],
      ],
    );
  }

  Widget _buildAddAccountRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: CredInputField(
            controller: _controllerSocial,
            label: t.registration.paste_link_here,

            onChanged: (val) {
              // Only update if changed significantly
              if (_controllerSocial.text != val) {
                _controllerSocial.text = val;
              }
            },
          ),
        ),
        const SizedBox(width: 12),
        AppButtons.primary(title: t.common.apply, onTap: _addSocialAccount),
      ],
    );
  }

  Widget _buildSocialAccountsList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _selectedSocialMediaAccounts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final account = _selectedSocialMediaAccounts[index];
        return _buildSocialAccountCard(account, index);
      },
    );
  }

  Widget _buildSocialAccountCard(SocialMediaAccount account, int index) {
    return BlocBuilder<AudienceCubit, AudienceState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${account.platform}: ${account.username}",
                      style: Typographies.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    _buildAccountStats(state),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => _removeSocialAccount(index),
                child: Icon(Icons.close, color: AppColors.red, size: 20),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountStats(AudienceState state) {
    return state.maybeWhen(
      loading: () =>
          const SizedBox(height: 4, child: LinearProgressIndicator()),
      loaded: (data) => _buildStatsRow(data),
      failure: (err) => Tooltip(
        message: err.toString(),
        child: Text(
          'Failure',
          style: Typographies.bodySmall.copyWith(color: AppColors.red),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      orElse: () => Text(
        'Loading ...',
        style: Typographies.bodySmall.copyWith(color: AppColors.grey),
      ),
    );
  }

  Widget _buildStatsRow(SocialMediaAccountStatsEntity data) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${data.followers} followers',
            style: Typographies.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '${data.engagementRate}% engagement rate',
            style: Typographies.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controllerFrom.dispose();
    _controllerTo.dispose();
    _controllerFromWomen.dispose();
    _controllerToWomen.dispose();
    _controllerSocial.dispose();
    super.dispose();
  }
}
