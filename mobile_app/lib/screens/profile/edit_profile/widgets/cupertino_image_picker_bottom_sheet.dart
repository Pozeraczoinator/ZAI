import 'package:flutter/cupertino.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/screens/profile/edit_profile/models/image_picker_source.dart';

class CupertinoImagePickerBottomSheet extends StatelessWidget {
  const CupertinoImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
            child: const Text(AppStrings.camera),
            onPressed: () =>
                Navigator.of(context).pop(ImagePickerSource.camera)),
        CupertinoActionSheetAction(
            child: const Text(AppStrings.gallery),
            onPressed: () =>
                Navigator.of(context).pop(ImagePickerSource.gallery)),
      ],
    );
  }
}
