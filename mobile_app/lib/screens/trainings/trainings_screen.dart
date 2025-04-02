import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/screens/trainings/bloc/trainings_bloc.dart';
import 'package:sport_plus/screens/trainings/trainings_loaded_view.dart';
import 'package:sport_plus/widgets/error_view.dart';
import 'package:sport_plus/widgets/generic_dialog.dart';
import 'package:sport_plus/widgets/loading_dialog.dart';
import 'package:sport_plus/widgets/loading_view.dart';

class TrainingsScreen extends StatefulWidget {
  const TrainingsScreen({super.key});
  static const String route = "/trainings";

  @override
  State<TrainingsScreen> createState() => _TrainingsScreenState();
}

class _TrainingsScreenState extends State<TrainingsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var args = ModalRoute.of(context)?.settings.arguments;
      context.read<TrainingsBloc>().add(InitUserTrainingDataEvent(args));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainingsBloc, TrainingsState>(
        listener: (context, state) {
      switch (state.status) {
        case TrainingsLoadingStatus.saving:
          showDialog(
              context: context, builder: (context) => const LoadingDialog());
        case TrainingsLoadingStatus.saved:
        case TrainingsLoadingStatus.error:
        case TrainingsLoadingStatus.userAlreadySaved:
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => GenericDialog(
              title: state.status == TrainingsLoadingStatus.saved
                  ? AppStrings.participationSaved
                  : state.status == TrainingsLoadingStatus.userAlreadySaved
                      ? AppStrings.participationAlreadySaved
                      : AppStrings.participationError,
            ),
          );
          break;
        default:
          break;
      }
    }, builder: (context, state) {
      if (state.status == TrainingsLoadingStatus.loading) {
        return const LoadingView();
      }
      if (state.status == TrainingsLoadingStatus.loadingError) {
        return const ErrorView();
      } else {
        return TrainingsLoadedView(trainings: state.extractedTrainings);
      }
    });
  }
}
