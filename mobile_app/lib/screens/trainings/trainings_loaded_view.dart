import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:sport_plus/config/app_colors.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/screens/facility_details/models/day_training.dart';
import 'package:sport_plus/screens/trainings/bloc/trainings_bloc.dart';
import 'package:sport_plus/screens/trainings/widgets/training_participation_dialog.dart';
import 'package:sport_plus/widgets/app_scaffold.dart';
import 'package:sport_plus/widgets/generic_dialog.dart';

class TrainingsLoadedView extends StatefulWidget {
  final List<DayTrainings> trainings;
  const TrainingsLoadedView({super.key, required this.trainings});

  @override
  State<TrainingsLoadedView> createState() => _TrainingsLoadedViewState();
}

class _TrainingsLoadedViewState extends State<TrainingsLoadedView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    DateTime now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    _tabController = TabController(length: 7, vsync: this);
    _tabController.index = _selectedDate.weekday - 1;

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _updateDate();
      }
    });
    super.initState();
  }

  void _updateDate() {
    final now = DateTime.now();
    final selectedIndex = _tabController.index;
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final daysOfWeek =
        List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

    setState(() {
      _selectedDate = daysOfWeek[selectedIndex];
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      setPadding: false,
      child: Column(
        children: [
          Container(
            color: AppColors.backgroundColor,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorColor: AppColors.mainColor,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: "Pn"),
                Tab(text: "Wt"),
                Tab(text: "Śr"),
                Tab(text: "Czw"),
                Tab(text: "Pt"),
                Tab(text: "Sb"),
                Tab(text: "N")
              ],
            ),
          ),
          Expanded(
            child: DayView(
              style: const DayViewStyle(
                  hourRowHeight: 100,
                  backgroundColor: Colors.white,
                  headerSize: 0,
                  currentTimeRuleColor: AppColors.mainColor),
              date: _selectedDate,
              events: [
                ...widget.trainings.map(
                  (training) => FlutterWeekViewEvent(
                    margin: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: AppColors.mainColor),
                    title: training.title,
                    description: training.description,
                    start: training.start,
                    end: training.end,
                    onTap: () => showDialog(
                      context: context,
                      builder: (ctx) => training.freeBooked != 0
                          ? BlocProvider.value(
                              value: context.read<TrainingsBloc>(),
                              child: TrainingParticipationDialog(
                                trainingId: training.trainingId,
                              ),
                            )
                          : const GenericDialog(
                              title: AppStrings.trainingNotAvaliable,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
