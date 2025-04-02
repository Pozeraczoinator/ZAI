import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/screens/home/bloc/home_bloc.dart';
import 'package:sport_plus/screens/home/home_loaded_view.dart';
import 'package:sport_plus/widgets/error_view.dart';
import 'package:sport_plus/widgets/loading_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String route = "/home";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeLoadingStatus.loading:
            return const LoadingView();
          case HomeLoadingStatus.loaded:
            return const HomeLoadedView();
          case HomeLoadingStatus.error:
            return const ErrorView();
        }
      },
    );
  }
}
