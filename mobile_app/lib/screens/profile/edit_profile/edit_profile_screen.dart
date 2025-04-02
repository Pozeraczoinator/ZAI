import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/screens/profile/bloc/profile_bloc.dart';
import 'package:sport_plus/screens/profile/edit_profile/edit_profile_loaded_view.dart';
import 'package:sport_plus/screens/profile/profile/profile_screen.dart';
import 'package:sport_plus/widgets/error_view.dart';
import 'package:sport_plus/widgets/loading_dialog.dart';
import 'package:sport_plus/widgets/loading_view.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  static const String route = "/edit-profile";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileLoadingStatus.saving) {
          showDialog(
            context: context,
            builder: (context) => const LoadingDialog(),
          );
        } else if (state.status == ProfileLoadingStatus.saved) {
          Navigator.popUntil(context, ModalRoute.withName(ProfileScreen.route));
        } else if (state.status == ProfileLoadingStatus.savingError) {
          Navigator.pop(context);
           ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text(AppStrings.savingError)));
         
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case ProfileLoadingStatus.loading:
            return const LoadingView();
          case ProfileLoadingStatus.error:
            return const ErrorView();
          case ProfileLoadingStatus.loaded:
          case ProfileLoadingStatus.saved:
          case ProfileLoadingStatus.saving:
          case ProfileLoadingStatus.savingError:
            var user = state.user;
            if (user == null) {
              return const ErrorView();
            } else {
              return EditProfileLoadingView(user: user);
            }
        }
      },
    );
  }
}
