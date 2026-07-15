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
import '../../../../utils/extansions/snackbar_x.dart';
import 'choose_geography.dart';
import 'choose_social_media_platform.dart';
import 'choose_spoken_language.dart';
import 'profile_section_readonly_banner.dart';

class AudienceAndFollowersPageView extends StatefulWidget {
  const AudienceAndFollowersPageView({
    super.key,
    required this.onChanged,
    this.initialParam,
    this.readOnly = false,
  });

  final Function(FillInfluencerProfileParam) onChanged;
  final FillInfluencerProfileParam? initialParam;
  final bool readOnly;

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

  // Per-account stats map: "platform:username" → stats
  final Map<String, SocialMediaAccountStatsEntity> _statsMap = {};
  // Key of the account whose stats are currently being fetched
  String? _pendingKey;

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
    final audience = widget.initialParam?.audience;
    _param = FillInfluencerProfileParam(
      audience: Audience(
        menAgeFrom: audience?.menAgeFrom,
        menAgeTo: audience?.menAgeTo,
        womenAgeFrom: audience?.womenAgeFrom,
        womenAgeTo: audience?.womenAgeTo,
      ),
    );

    _controllerFrom = TextEditingController(
      text: audience?.menAgeFrom?.toString() ?? '',
    );
    _controllerTo = TextEditingController(
      text: audience?.menAgeTo?.toString() ?? '',
    );
    _controllerFromWomen = TextEditingController(
      text: audience?.womenAgeFrom?.toString() ?? '',
    );
    _controllerToWomen = TextEditingController(
      text: audience?.womenAgeTo?.toString() ?? '',
    );
    _controllerSocial = TextEditingController();

    _controllerFrom.addListener(_handleUpdate);
    _controllerTo.addListener(_handleUpdate);
    _controllerFromWomen.addListener(_handleUpdate);
    _controllerToWomen.addListener(_handleUpdate);
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
    if (_selectedPlatform == null || _controllerSocial.text.trim().isEmpty) {
      _showErrorSnackBar(t.validation.fill_required_fields);
      return;
    }

    if (_isAddingAccount) return;

    setState(() => _isAddingAccount = true);

    try {
      final username = _controllerSocial.text.trim();
      final platform = _selectedPlatform!;

      final isDuplicate = _selectedSocialMediaAccounts.any(
        (acc) => acc.platform == platform && acc.username == username,
      );

      if (isDuplicate) {
        _showErrorSnackBar(t.validation.account_already_added);
        return;
      }

      final newAccount = SocialMediaAccount(platform: platform, username: username);
      final key = '$platform:$username';

      setState(() {
        _selectedSocialMediaAccounts.add(newAccount);
        _pendingKey = key;
      });

      _handleUpdate();

      context.read<AudienceCubit>().getSocialMediaAccountStats(
        platform: platform,
        username: username,
      );

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
    final account = _selectedSocialMediaAccounts[index];
    final key = '${account.platform}:${account.username}';
    setState(() {
      _selectedSocialMediaAccounts.removeAt(index);
      _statsMap.remove(key);
      _handleUpdate();
    });
  }

  void _showErrorSnackBar(String message) {
    context.showAppSnackBar(message, type: AppSnackBarType.error);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<AudienceCubit, AudienceState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (data) {
            if (_pendingKey != null) {
              setState(() {
                _statsMap[_pendingKey!] = data;
                _pendingKey = null;
              });
            }
          },
          failure: (_) {
            setState(() => _pendingKey = null);
          },
          orElse: () {},
        );
      },
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.readOnly) const ProfileSectionReadOnlyBanner(),
            const SizedBox(height: 16),
            IgnorePointer(
              ignoring: widget.readOnly,
              child: Opacity(
                opacity: widget.readOnly ? 0.6 : 1.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGeographySection(),
                    const SizedBox(height: 32),
                    _buildAgeSection(),
                    const SizedBox(height: 32),
                    _buildSocialMediaSection(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
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
    final key = '${account.platform}:${account.username}';
    final stats = _statsMap[key];
    final isLoading = _pendingKey == key;

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
                  '${account.platform}: ${account.username}',
                  style: Typographies.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                if (isLoading)
                  const SizedBox(height: 4, child: LinearProgressIndicator())
                else if (stats != null)
                  _buildStatsRow(stats)
                else
                  Text(
                    '...',
                    style: Typographies.bodySmall.copyWith(color: AppColors.grey),
                  ),
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
  }

  Widget _buildStatsRow(SocialMediaAccountStatsEntity data) {
    return Row(
      children: [
        Expanded(
          child: Text(
            t.brand.followers_count(count: data.followers ?? 0),
            style: Typographies.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            t.misc.engagement_rate_value(rate: data.engagementRate ?? 0),
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
