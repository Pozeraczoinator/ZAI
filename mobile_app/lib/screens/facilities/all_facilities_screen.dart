import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/screens/facilities/all_facilities_loaded_view.dart';
import 'package:sport_plus/screens/facilities/bloc/all_facilities_bloc.dart';
import 'package:sport_plus/widgets/error_view.dart';
import 'package:sport_plus/widgets/loading_view.dart';

class AllFacilitiesScreen extends StatelessWidget {
  const AllFacilitiesScreen({super.key});
  static const String route = "/all-facilities";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllFacilitiesBloc, AllFacilitiesState>(
      builder: (context, state) {
        switch (state.status) {
          case AllFacilitiesStatus.loading:
            return const LoadingView();
          case AllFacilitiesStatus.loaded:
            return const AllFacilitiesLoadedView();
          case AllFacilitiesStatus.error:
            return const ErrorView();
        }
      },
    );
  }
}
