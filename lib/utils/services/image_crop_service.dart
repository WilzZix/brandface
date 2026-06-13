import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

import '../../uikit/tokens/colors.dart';

/// Wraps image_cropper for the app. Returns the cropped file, or null if the
/// user cancelled or cropping failed.
Future<File?> cropImage({
  required File source,
  bool square = true,
}) async {
  final cropped = await ImageCropper().cropImage(
    sourcePath: source.path,
    aspectRatio: square ? const CropAspectRatio(ratioX: 1, ratioY: 1) : null,
    compressQuality: 90,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop',
        toolbarColor: AppColors.black,
        toolbarWidgetColor: AppColors.white,
        activeControlsWidgetColor: AppColors.primary,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: square,
        hideBottomControls: square,
      ),
      IOSUiSettings(
        title: 'Crop',
        aspectRatioLockEnabled: square,
        resetAspectRatioEnabled: !square,
      ),
    ],
  );
  if (cropped == null) return null;
  return File(cropped.path);
}
