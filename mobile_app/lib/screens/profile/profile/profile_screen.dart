import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/screens/profile/bloc/profile_bloc.dart';
import 'package:sport_plus/screens/profile/profile/profile_loaded_view.dart';
import 'package:sport_plus/widgets/error_view.dart';
import 'package:sport_plus/widgets/loading_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String route = "/profile";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
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
              return ProfileLoadedView(
                user: user,
                imageUrl: state.avatarUrl,
              );
            }
        }
      },
    );
  }
}
