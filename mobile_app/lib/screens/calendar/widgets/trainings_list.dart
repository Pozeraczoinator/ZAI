import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_colors.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/screens/calendar/bloc/calendar_bloc.dart';
import 'package:sport_plus/screens/trainings/models/calendar_training.dart';

class TrainingsList extends StatelessWidget {
  final List<CalendarTraining> trainings;
  const TrainingsList({super.key, required this.trainings});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...trainings.map(
          (training) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              dense: true,
              tileColor: AppColors.backgroundColor,
              isThreeLine: true,
              title: Text(
                training.name,
                style: AppTypography.bigTextStyle,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${training.time}, ${training.place}"),
                  Text("${AppStrings.coach} ${training.coachName}"),
                ],
              ),
              trailing: TextButton(
                onPressed: () => context
                    .read<CalendarBloc>()
                    .add(GiveupTrainingEvent(training.trainingId)),
                child: const Text(AppStrings.giveup),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
