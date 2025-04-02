import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/screens/calendar/bloc/calendar_bloc.dart';
import 'package:sport_plus/screens/calendar/calendar_loaded_view.dart';
import 'package:sport_plus/widgets/error_view.dart';
import 'package:sport_plus/widgets/loading_dialog.dart';
import 'package:sport_plus/widgets/loading_view.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});
  static const String route = "/calendar";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarState>(
      listener: (context, state) {
        switch (state.deletingStatus) {
          case CalendarDeletingStatus.deleting:
            showDialog(
                context: context, builder: (context) => const LoadingDialog());
            break;
          case CalendarDeletingStatus.deleted:
            Navigator.pop(context);
            break;
          case CalendarDeletingStatus.error:
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text(AppStrings.error)));
            break;
          case CalendarDeletingStatus.idle:
            break;
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case CalendarLoadingStatus.loading:
            return const LoadingView();
          case CalendarLoadingStatus.loaded:
            return const CalendarLoadedView();
          case CalendarLoadingStatus.error:
            return const ErrorView();
        }
      },
    );
  }
}
