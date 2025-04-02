import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sport_plus/models/coach/coach.dart';
import 'package:sport_plus/models/sport_facility.dart';
import 'package:sport_plus/models/training_session/training_session.dart';
import 'package:sport_plus/repository/coach_repository.dart';
import 'package:sport_plus/repository/sport_facility_repository.dart';
import 'package:sport_plus/repository/training_session_participant_repository.dart';
import 'package:sport_plus/screens/trainings/models/calendar_training.dart';
import 'package:sport_plus/services/training_service.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final TrainingSessionParticipantRepository
      trainingSessionParticipantRepository;
  final SportFacilityRepository sportFacilityRepository;
  final CoachRepository coachRepository;
  final TrainingService trainingService;
  CalendarBloc(
      {required this.trainingSessionParticipantRepository,
      required this.sportFacilityRepository,
      required this.coachRepository,
      required this.trainingService})
      : super(const CalendarState()) {
    on<InitTrainingDataEvent>(_initData);
    on<GiveupTrainingEvent>(_deleteTraining);
    on<MonthChangedEvent>(_monthChanged);
  }
  Future<void> _monthChanged(
      MonthChangedEvent event, Emitter<CalendarState> emitter) async {
    var monthTrainings = trainingService.extractMonthTrainings(
        state.userTrainings,
        state.coaches,
        state.facilities,
        event.newFocusDate);

    emitter(state.copyWith(trainings: monthTrainings));
  }

  Future<void> _initData(
      InitTrainingDataEvent event, Emitter<CalendarState> emitter) async {
    emitter(state.copyWith(status: CalendarLoadingStatus.loading));
    var trainings =
        await trainingSessionParticipantRepository.getUserTrainings();
    var coaches = await coachRepository.getCoaches();
    var facilities = await sportFacilityRepository.getAllFacilities();
    if (trainings == null || coaches == null || facilities == null) {
      emitter(state.copyWith(status: CalendarLoadingStatus.error));
      return;
    }
    var monthTrainings = trainingService.extractMonthTrainings(
        trainings, coaches, facilities, DateTime.now());

    emitter(state.copyWith(
        status: CalendarLoadingStatus.loaded,
        trainings: monthTrainings,
        userTrainings: trainings,
        coaches: coaches,
        facilities: facilities));
  }

  Future<void> _deleteTraining(
      GiveupTrainingEvent event, Emitter<CalendarState> emitter) async {
    emitter(state.copyWith(deletingStatus: CalendarDeletingStatus.deleting));
    var deletingResult = await trainingSessionParticipantRepository
        .leaveTraining(event.trainingId);
    if (deletingResult) {
      emitter(state.copyWith(deletingStatus: CalendarDeletingStatus.deleted));
    } else {
      emitter(state.copyWith(deletingStatus: CalendarDeletingStatus.error));
    }
    emitter(state.copyWith(deletingStatus: CalendarDeletingStatus.idle));

    add(InitTrainingDataEvent());
  }
}
