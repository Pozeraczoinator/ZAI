import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/screens/home/bloc/home_bloc.dart';
import 'package:sport_plus/screens/home/widgets/news_slider.dart';
import 'package:sport_plus/screens/home/widgets/sport_facilities_slider.dart';
import 'package:sport_plus/widgets/app_scaffold.dart';

class HomeLoadedView extends StatelessWidget {
  const HomeLoadedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AppScaffold(
          showDrawer: true,
          setPadding: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SportFacilitiesSlider(
                    title: AppStrings.yourFacilities,
                    facilities: state.userFacility),
                NewsSlider(
                  title: AppStrings.whatsNew,
                  news: state.news,
                ),
                SportFacilitiesSlider(
                    title: AppStrings.propositions,
                    facilities: state.propositions),
              ],
            ),
          ),
        );
      },
    );
  }
}
