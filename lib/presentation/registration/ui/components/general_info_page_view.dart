import 'dart:io';

import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/presentation/registration/bloc/upload/upload_cubit.dart';
import 'package:brandface/presentation/registration/ui/components/profile_avatar_item.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/components/inputs/bio_input_field.dart';
import '../../../../utils/extansions/snackbar_x.dart';
import 'choose_contact_detail.dart';
import 'choose_date_of_birthday.dart';
import 'choose_gender.dart';
import 'choose_spoken_language.dart';

class GeneralInfoPageView extends StatefulWidget {
  const GeneralInfoPageView({
    super.key,
    required this.onChanged,
    this.initialParam,
    this.initialAvatarUrl,
  });

  final Function(FillInfluencerProfileParam) onChanged;
  final FillInfluencerProfileParam? initialParam;
  final String? initialAvatarUrl;

  @override
  State<GeneralInfoPageView> createState() => _GeneralInfoPageViewState();
}

class _GeneralInfoPageViewState extends State<GeneralInfoPageView>
    with AutomaticKeepAliveClientMixin<GeneralInfoPageView> {
  final TextEditingController _profileInfoController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  FillInfluencerProfileParam _fillInfluencerProfileParam =
      FillInfluencerProfileParam();
  File? _pickedImage;
  String? _currentAvatarUrl;
  final List<UploadedAvatarItem> _uploadedItems = [];

  @override
  void initState() {
    super.initState();
    _fillInfluencerProfileParam =
        widget.initialParam ?? FillInfluencerProfileParam();
    _profileInfoController.text = widget.initialParam?.bio ?? '';
    _fullNameController.text = widget.initialParam?.displayName ?? '';
    _currentAvatarUrl = widget.initialAvatarUrl;
    final initialAvatarId = widget.initialParam?.avatarId;
    final initialAvatarUrl = widget.initialAvatarUrl;
    if (initialAvatarId != null &&
        initialAvatarUrl != null &&
        initialAvatarUrl.isNotEmpty) {
      _uploadedItems.add(
        UploadedAvatarItem(id: initialAvatarId, url: initialAvatarUrl),
      );
    }
  }

  Future<void> _pickAndUpload() async {
    final result = await FilePicker.pickFiles(
      type: FileType.image,
      withData: false,
    );
    if (!mounted || result == null || result.files.isEmpty) return;
    final path = result.files.single.path;
    if (path == null || path.isEmpty) return;
    final file = File(path);
    setState(() => _pickedImage = file);
    if (!mounted) return;
    context.read<UploadCubit>().uploadFile(file);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<UploadCubit, UploadState>(
      listener: (context, state) {
        state.maybeWhen(
          uploaded: (entity) {
            setState(() {
              _currentAvatarUrl = entity.fileUrl;
              _uploadedItems.add(
                UploadedAvatarItem(id: entity.id, file: _pickedImage),
              );
            });
            _fillInfluencerProfileParam = _fillInfluencerProfileParam.copyWith(
              avatarId: entity.id,
            );
            widget.onChanged(_fillInfluencerProfileParam);
          },
          failure: (_) {
            context.showAppSnackBar(
              'Image upload failed',
              type: AppSnackBarType.error,
            );
          },
          orElse: () {},
        );
      },
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  child: ClipOval(
                    child: _pickedImage != null
                        ? Image.file(_pickedImage!, fit: BoxFit.cover)
                        : (_currentAvatarUrl != null &&
                              _currentAvatarUrl!.isNotEmpty)
                        ? Image.network(
                            _currentAvatarUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Image.asset(
                              'assets/images/im_person_avatar_sample.png',
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            'assets/images/im_person_avatar_sample.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<UploadCubit, UploadState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);
                        return GestureDetector(
                          onTap: isLoading ? null : _pickAndUpload,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(999),
                              color: AppColors.primary,
                            ),
                            child: isLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.black,
                                    ),
                                  )
                                : Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.icAttachFile),
                                      SizedBox(width: 8),
                                      Text(
                                        t.registration.choose_file,
                                        style: Typographies.bodyMedium,
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 8),
                    Text(
                      t.registration.file_format_hint,
                      style: Typographies.bodySmall.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (_uploadedItems.isNotEmpty) ...[
              SizedBox(height: 24),
              ProfileAvatarItem(
                items: _uploadedItems,
                onSetMain: (id) {
                  _fillInfluencerProfileParam =
                      _fillInfluencerProfileParam.copyWith(avatarId: id);
                  widget.onChanged(_fillInfluencerProfileParam);
                },
                onDelete: (id) {
                  setState(() {
                    _uploadedItems.removeWhere((e) => e.id == id);
                  });
                  if (_uploadedItems.isNotEmpty) {
                    _fillInfluencerProfileParam = _fillInfluencerProfileParam
                        .copyWith(avatarId: _uploadedItems.first.id);
                    widget.onChanged(_fillInfluencerProfileParam);
                  }
                },
              ),
            ],
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
                    _fillInfluencerProfileParam =
                        _fillInfluencerProfileParam.copyWith(displayName: val);
                    widget.onChanged(_fillInfluencerProfileParam);
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return t.validation.name_required;
                    }

                    final nameParts = value.trim().split(RegExp('rs+'));
                    if (nameParts.length < 2) {
                      return t.validation.name_full_required;
                    }

                    final nameRegExp =
                        RegExp(r"^[a-zA-Zа-яА-ЯёЁқҚғҒҳҲўЎʼ' ]+$");

                    if (!nameRegExp.hasMatch(value)) {
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
                _fillInfluencerProfileParam =
                    _fillInfluencerProfileParam.copyWith(languageIds: ids);
                widget.onChanged(_fillInfluencerProfileParam);
              },
            ),
            SizedBox(height: 24),
            ChooseDateOfBirthday(
              initialValue: widget.initialParam?.birthDate,
              title: 'DD.MM.YYYY',
              label: t.registration.date_of_birth,
              onItemSelected: (DateTime date) {
                _fillInfluencerProfileParam =
                    _fillInfluencerProfileParam.copyWith(birthDate: date);
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
                _fillInfluencerProfileParam =
                    _fillInfluencerProfileParam.copyWith(gender: p1);
                widget.onChanged(_fillInfluencerProfileParam);
              },
            ),
            SizedBox(height: 24),
            ChooseContactDetail(
              initialValue: widget.initialParam?.contacts,
              title: t.contact.phone,
              label: t.registration.contact_details,
              onItemSelected: (List<Contact> contacts) {
                _fillInfluencerProfileParam =
                    _fillInfluencerProfileParam.copyWith(contacts: contacts);
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
      ),
    );
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
