import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/usecase/registration/upload_profile_file_use_case.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:brandface/uikit/components/ui_components/profile_image.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/inputs/bio_input_field.dart';
import 'choose_contact_detail.dart';
import 'choose_date_of_birthday.dart';
import 'choose_gender.dart';
import 'choose_spoken_language.dart';

class GeneralInfoPageView extends StatefulWidget {
  const GeneralInfoPageView({
    super.key,
    required this.onChanged,
    this.initialParam,
  });

  final Function(FillInfluencerProfileParam) onChanged;
  final FillInfluencerProfileParam? initialParam;

  @override
  State<GeneralInfoPageView> createState() => _GeneralInfoPageViewState();
}

class _GeneralInfoPageViewState extends State<GeneralInfoPageView>
    with AutomaticKeepAliveClientMixin<GeneralInfoPageView> {
  final TextEditingController _profileInfoController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  FillInfluencerProfileParam _fillInfluencerProfileParam =
      FillInfluencerProfileParam();
  bool _isUploadingAvatar = false;
  String? _avatarUrl;
  String? _avatarFileName;

  @override
  void initState() {
    super.initState();
    _fillInfluencerProfileParam =
        widget.initialParam ?? FillInfluencerProfileParam();
    _avatarUrl = widget.initialParam?.avatarUrl;
    _profileInfoController.text = widget.initialParam?.bio ?? '';
    _fullNameController.text = widget.initialParam?.displayName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.registration.upload_profile_picture,
            style: Typographies.titleMedium,
          ),
          SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                height: 96,
                width: 96,
                child: ProfileImage(imageUrl: _avatarUrl, size: 96),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _isUploadingAvatar ? null : _pickAndUploadAvatar,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(999),
                        color: _isUploadingAvatar
                            ? AppColors.lightBg2
                            : AppColors.primary,
                      ),
                      child: Row(
                        children: [
                          if (_isUploadingAvatar)
                            const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          else
                            SvgPicture.asset(AppAssets.icAttachFile),
                          SizedBox(width: 8),
                          Text(
                            _isUploadingAvatar
                                ? 'Uploading...'
                                : t.registration.choose_file,
                            style: Typographies.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    t.registration.file_format_hint,
                    style: Typographies.bodySmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  if (_avatarFileName != null) ...[
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 190,
                      child: Text(
                        _avatarFileName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Typographies.bodySmall.copyWith(
                          color: AppColors.mutedBlack,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.registration.full_name, style: Typographies.titleSmall),
              const SizedBox(height: 8),
              CredInputField(
                controller: _fullNameController,
                label: t.registration.full_name,
                onChanged: (val) {
                  _fillInfluencerProfileParam = _fillInfluencerProfileParam
                      .copyWith(displayName: val);
                  widget.onChanged(_fillInfluencerProfileParam);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return t.validation.name_required;
                  }

                  final nameParts = value
                      .trim()
                      .split(' ')
                      .where((part) => part.isNotEmpty)
                      .toList();
                  if (nameParts.length < 2) {
                    return t.validation.name_full_required;
                  }

                  if (!_containsOnlyNameLetters(value)) {
                    return t.validation.name_letters_only;
                  }

                  if (value.trim().length < 3) {
                    return t.validation.name_too_short;
                  }

                  return null;
                },
              ),
            ],
          ),
          SizedBox(height: 24),
          ChooseSpokenLanguage(
            initialValue: widget.initialParam?.languageIds,
            title: t.common.select,
            label: t.registration.spoken_languages,
            onItemSelected: (List<int> ids) {
              _fillInfluencerProfileParam = _fillInfluencerProfileParam
                  .copyWith(languageIds: ids);
              widget.onChanged(_fillInfluencerProfileParam);
            },
          ),
          SizedBox(height: 24),
          ChooseDateOfBirthday(
            initialValue: widget.initialParam?.birthDate,
            title: 'DD.MM.YYYY',
            label: t.registration.date_of_birth,
            onItemSelected: (DateTime date) {
              _fillInfluencerProfileParam = _fillInfluencerProfileParam
                  .copyWith(birthDate: date);
              widget.onChanged(_fillInfluencerProfileParam);
            },
            iconPath: AppAssets.icCalendar,
          ),
          SizedBox(height: 24),
          ChooseGender(
            initialValue: widget.initialParam?.gender,
            title: t.common.select,
            label: t.registration.gender,
            onItemSelected: (String p1) {
              _fillInfluencerProfileParam = _fillInfluencerProfileParam
                  .copyWith(gender: p1);
              widget.onChanged(_fillInfluencerProfileParam);
            },
          ),
          SizedBox(height: 24),
          ChooseContactDetail(
            initialValue: widget.initialParam?.contacts,
            title: t.contact.phone,
            label: t.registration.contact_details,
            onItemSelected: (List<Contact> contacts) {
              _fillInfluencerProfileParam = _fillInfluencerProfileParam
                  .copyWith(contacts: contacts);
              widget.onChanged(_fillInfluencerProfileParam);
            },
          ),
          SizedBox(height: 24),
          BioInputField(
            controller: _profileInfoController,
            label: t.registration.profile_information,
            onChanged: () {
              _fillInfluencerProfileParam = _fillInfluencerProfileParam
                  .copyWith(bio: _profileInfoController.text);
              widget.onChanged(_fillInfluencerProfileParam);
            },
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _pickAndUploadAvatar() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['svg', 'png', 'jpg', 'jpeg', 'gif'],
      withData: false,
    );

    if (!mounted || result == null || result.files.isEmpty) {
      return;
    }

    final selectedFile = result.files.single;
    final path = selectedFile.path;
    if (path == null || path.isEmpty) {
      _showMessage('Selected file path is unavailable.');
      return;
    }

    setState(() {
      _isUploadingAvatar = true;
      _avatarFileName = selectedFile.name;
    });

    final uploadResult = await sl<UploadProfileFileUseCase>().call(
      params: path,
    );
    UploadedFileEntity? uploadedFile;
    Object? uploadFailure;
    uploadResult.fold(
      ifLeft: (failure) => uploadFailure = failure,
      ifRight: (file) => uploadedFile = file,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isUploadingAvatar = false;
    });

    if (uploadedFile == null) {
      _showMessage(uploadFailure?.toString() ?? 'File upload failed.');
      return;
    }

    _fillInfluencerProfileParam = _fillInfluencerProfileParam.copyWith(
      avatarId: uploadedFile!.id,
      avatarUrl: uploadedFile!.fileUrl,
    );
    setState(() {
      _avatarUrl = uploadedFile!.fileUrl;
      _avatarFileName = selectedFile.name;
    });
    widget.onChanged(_fillInfluencerProfileParam);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  bool _containsOnlyNameLetters(String value) {
    for (final rune in value.runes) {
      final isLatinUpper = rune >= 65 && rune <= 90;
      final isLatinLower = rune >= 97 && rune <= 122;
      final isCyrillic = rune >= 0x0400 && rune <= 0x04FF;
      final isSpaceOrApostrophe = rune == 32 || rune == 39 || rune == 0x02BC;
      if (!isLatinUpper &&
          !isLatinLower &&
          !isCyrillic &&
          !isSpaceOrApostrophe) {
        return false;
      }
    }

    return true;
  }

  @override
  bool get wantKeepAlive => true;
}
