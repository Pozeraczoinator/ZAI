import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/screens/profile/edit_profile/models/image_picker_source.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text(AppStrings.camera),
          onTap: () => Navigator.of(context).pop(ImagePickerSource.camera),
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text(AppStrings.gallery),
          onTap: () => Navigator.of(context).pop(ImagePickerSource.gallery),
        ),
      ],
    );
  }
}
