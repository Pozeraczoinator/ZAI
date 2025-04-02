import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges_package;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_colors.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/screens/profile/bloc/profile_bloc.dart';
import 'package:sport_plus/screens/profile/edit_profile/models/image_picker_source.dart';
import 'package:sport_plus/screens/profile/edit_profile/widgets/cupertino_image_picker_bottom_sheet.dart';
import 'package:sport_plus/screens/profile/edit_profile/widgets/image_picker_bottom_sheet.dart';

class EditAvatar extends StatefulWidget {
  const EditAvatar({super.key});

  @override
  State<EditAvatar> createState() => _EditAvatarState();
}

class _EditAvatarState extends State<EditAvatar> {
  Future<ImagePickerSource?> pickImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImagePickerSource>(
          context: context,
          builder: ((context) => const CupertinoImagePickerBottomSheet()));
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => const ImagePickerBottomSheet());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: GestureDetector(
            onTap: () async {
              pickImageSource(context).then((value) {
                if (value != null) {
                  context.read<ProfileBloc>().add(PickImageEvent(value));
                }
              });
            },
            child: badges_package.Badge(
              badgeStyle: const badges_package.BadgeStyle(
                  badgeColor: AppColors.mainColor),
              position:
                  badges_package.BadgePosition.bottomEnd(bottom: 5, end: 5),
              badgeContent: const Icon(Icons.add, color: Colors.white),
              child: CircleAvatar(
                minRadius: 50,
                maxRadius: 80,
                backgroundColor: AppColors.backgroundColor,
                backgroundImage: state.avatarUrl != null
                    ? NetworkImage(
                        "${AppConsts.imageContainerUrl}${state.avatarUrl}",
                      )
                    : null,
                child: state.avatarUrl == null
                    ? Text(
                        state.user?.getInitials ?? "",
                        style: AppTypography.bigBoldTextStyle(),
                      )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
