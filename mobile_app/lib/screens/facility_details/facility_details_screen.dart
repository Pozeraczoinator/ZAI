import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/screens/facility_details/bloc/facility_details_bloc.dart';
import 'package:sport_plus/screens/facility_details/facility_details_loaded_view.dart';
import 'package:sport_plus/widgets/error_view.dart';
import 'package:sport_plus/widgets/loading_dialog.dart';
import 'package:sport_plus/widgets/loading_view.dart';

class FacilityDetailsScreen extends StatefulWidget {
  const FacilityDetailsScreen({super.key});
  static const String route = "/facility-details";

  @override
  State<FacilityDetailsScreen> createState() => _FacilityDetailsScreenState();
}

class _FacilityDetailsScreenState extends State<FacilityDetailsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var modalRoute = ModalRoute.of(context);
      if (modalRoute != null) {
        var arg = modalRoute.settings.arguments;
        if (arg is int) {
          context
              .read<FacilityDetailsBloc>()
              .add(LoadingFacilityDetailsEvent(arg));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FacilityDetailsBloc, FacilityDetailsState>(
      listener: (context, state) {
        switch (state.ratingStatus) {
          case RatingLoadingStatus.adding:
            showDialog(
              context: context,
              builder: (context) => const LoadingDialog(),
            );
            break;
          case RatingLoadingStatus.idle:
            break;
          case RatingLoadingStatus.success:
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.addRatingSuccess)));
            break;
          case RatingLoadingStatus.error:
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text(AppStrings.error)));
            break;
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case FacilityDetailsLoadingStatus.loading:
            return const LoadingView();
          case FacilityDetailsLoadingStatus.loaded:
            var facility = state.facility;
            if (facility == null) {
              return const ErrorView();
            }
            return FacilityDetailsLoadedView(
              facility: facility,
            );
          case FacilityDetailsLoadingStatus.error:
            return const ErrorView();
        }
      },
    );
  }
}
