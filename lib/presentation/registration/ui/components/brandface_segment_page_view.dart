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

class BrandfaceSegmentPageView extends StatefulWidget {
  const BrandfaceSegmentPageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<BrandfaceSegmentPageView> createState() =>
      _BrandfaceSegmentPageViewState();
}

class _BrandfaceSegmentPageViewState extends State<BrandfaceSegmentPageView>
    with AutomaticKeepAliveClientMixin<BrandfaceSegmentPageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam(
    audience: Audience(),
  );
  LangItemModel? _selectedSegment;
  final List<LangItemModel> _selectedGeographies = [];
  final List<SocialMediaAccount> _selectedSocialMediaAccounts = [];
  final Map<String, SocialMediaAccountStatsEntity> _statsMap = {};
  String? _pendingKey;
  String? _selectedPlatform;
  bool _isAddingAccount = false;

  final TextEditingController _controllerFrom = TextEditingController();
  final TextEditingController _controllerTo = TextEditingController();
  final TextEditingController _controllerFromWomen = TextEditingController();
  final TextEditingController _controllerToWomen = TextEditingController();
  final TextEditingController _controllerSocial = TextEditingController();

  final List<LangItemModel> _segments = [
    LangItemModel(name: 'Luxury', id: 0),
    LangItemModel(name: 'Premium', id: 1),
    LangItemModel(name: 'Mass market', id: 2),
    LangItemModel(name: 'Budget', id: 3),
  ];

  static const Map<int, String> _segmentCodes = {
    0: 'luxury',
    1: 'premium',
    2: 'mass',
    3: 'budget',
  };

  @override
  void initState() {
    super.initState();
    _controllerFrom.addListener(_handleUpdate);
    _controllerTo.addListener(_handleUpdate);
    _controllerFromWomen.addListener(_handleUpdate);
    _controllerToWomen.addListener(_handleUpdate);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _controllerFrom.dispose();
    _controllerTo.dispose();
    _controllerFromWomen.dispose();
    _controllerToWomen.dispose();
    _controllerSocial.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    final currentAudience = _param.audience ?? Audience();
    _param = _param.copyWith(
      audience: currentAudience.copyWith(
        brandSegment: _selectedSegment == null
            ? null
            : _segmentCodes[_selectedSegment!.id],
        menAgeFrom: int.tryParse(_controllerFrom.text),
        menAgeTo: int.tryParse(_controllerTo.text),
        womenAgeFrom: int.tryParse(_controllerFromWomen.text),
        womenAgeTo: int.tryParse(_controllerToWomen.text),
        geography: _selectedGeographies.map((e) => e.id.toString()).toList(),
        socialMediaAccounts: List.of(_selectedSocialMediaAccounts),
      ),
    );
    widget.onChanged(_param);
  }

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

      final newAccount =
          SocialMediaAccount(platform: platform, username: username);
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
      _selectedGeographies.removeAt(index);
    });
    _handleUpdate();
  }

  void _removeSocialAccount(int index) {
    final account = _selectedSocialMediaAccounts[index];
    final key = '${account.platform}:${account.username}';
    setState(() {
      _selectedSocialMediaAccounts.removeAt(index);
      _statsMap.remove(key);
    });
    _handleUpdate();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.registration.brand_segment_fit, style: Typographies.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _segments.map((segment) {
                final isSelected = _selectedSegment?.id == segment.id;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSegment = isSelected ? null : segment;
                    });
                    _handleUpdate();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.black : AppColors.lightBg2,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.black
                            : AppColors.borderColor,
                      ),
                    ),
                    child: Text(
                      segment.name,
                      style: Typographies.labelMedium.copyWith(
                        color: isSelected ? AppColors.lightBg : AppColors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(t.registration.geography, style: Typographies.titleMedium),
            const SizedBox(height: 8),
            ChooseGeography(
              onItemSelected: (LangItemModel item) {
                if (!_selectedGeographies.any((e) => e.id == item.id)) {
                  setState(() {
                    _selectedGeographies.add(item);
                  });
                  _handleUpdate();
                }
              },
            ),
            if (_selectedGeographies.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(t.registration.selected_geography, style: Typographies.titleSmall),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _selectedGeographies.length,
                itemBuilder: (context, index) {
                  final item = _selectedGeographies[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.name, style: Typographies.bodyMedium),
                        GestureDetector(
                          onTap: () => _removeGeographyItem(index),
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
            const SizedBox(height: 16),
            FromToInputField(
              onChanged: _handleUpdate,
              controllerFrom: _controllerFrom,
              controllerTo: _controllerTo,
              title: t.registration.men,
              labelFrom: t.registration.age_from,
              labelTo: t.registration.age_to,
            ),
            const SizedBox(height: 16),
            FromToInputField(
              onChanged: _handleUpdate,
              controllerFrom: _controllerFromWomen,
              controllerTo: _controllerToWomen,
              title: t.registration.women,
              labelFrom: t.registration.age_from,
              labelTo: t.registration.age_to,
            ),
            const SizedBox(height: 24),
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
            Row(
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
                AppButtons.primary(
                  title: t.common.apply,
                  onTap: _addSocialAccount,
                ),
              ],
            ),
            if (_selectedSocialMediaAccounts.isNotEmpty) ...[
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _selectedSocialMediaAccounts.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final account = _selectedSocialMediaAccounts[index];
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
                                const SizedBox(
                                  height: 4,
                                  child: LinearProgressIndicator(),
                                )
                              else if (stats != null)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${stats.followers} followers',
                                        style: Typographies.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        '${stats.engagementRate}% engagement rate',
                                        style: Typographies.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Text(
                                  '...',
                                  style: Typographies.bodySmall.copyWith(
                                    color: AppColors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => _removeSocialAccount(index),
                          child: Icon(
                            Icons.close,
                            color: AppColors.red,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
