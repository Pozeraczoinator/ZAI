import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sport_plus/models/training_session/training_session.dart';
import 'package:sport_plus/repository/coach_repository.dart';
import 'package:sport_plus/repository/training_session_participant_repository.dart';
import 'package:sport_plus/screens/facility_details/models/day_training.dart';
import 'package:sport_plus/services/training_service.dart';

import '../../../models/coach/coach.dart';

part 'trainings_event.dart';
part 'trainings_state.dart';

class TrainingsBloc extends Bloc<TrainingsEvent, TrainingsState> {
  final TrainingSessionParticipantRepository
      trainingSessionParticipantRepository;
  final CoachRepository coachRepository;
  final TrainingService trainingService;
  TrainingsBloc(
      {required this.trainingSessionParticipantRepository,
      required this.coachRepository,
      required this.trainingService})
      : super(const TrainingsState()) {
    on<SingUpForTrainingEvent>(_singUp);
    on<InitUserTrainingDataEvent>(_initData);
    on<WeekChangedEvent>(_weekChanged);
  }
  Future<void> _weekChanged(
      WeekChangedEvent event, Emitter<TrainingsState> emitter) async {
    var weekTrainings = trainingService.extractWeekTrainings(
        state.userTrainings, state.coaches, event.newFocusDate);
    emitter(state.copyWith(extractedTrainings: weekTrainings));
  }

  Future<void> _initData(
      InitUserTrainingDataEvent event, Emitter<TrainingsState> emitter) async {
    emitter(state.copyWith(status: TrainingsLoadingStatus.loading));
    if (event.trainings is! List) {
      emitter(state.copyWith(status: TrainingsLoadingStatus.loadingError));
      return;
    }
    var trainings =
        await trainingSessionParticipantRepository.getUserTrainings();
    var coaches = await coachRepository.getCoaches();
    if (trainings == null || coaches == null) {
      emitter(state.copyWith(status: TrainingsLoadingStatus.loadingError));
    } else {
      var weekTrainings = trainingService.extractWeekTrainings(
          event.trainings, coaches, DateTime.now());
      emitter(state.copyWith(
          status: TrainingsLoadingStatus.idle,
          userTrainings: trainings,
          extractedTrainings: weekTrainings,
          trainingsList: event.trainings));
    }
  }

  Future<void> _singUp(
      SingUpForTrainingEvent event, Emitter<TrainingsState> emitter) async {
    emitter(state.copyWith(status: TrainingsLoadingStatus.saving));
    var isUserSaved = state.userTrainings
            .where((element) => element.id == event.trainingId)
            .firstOrNull !=
        null;
    if (isUserSaved) {
      emitter(state.copyWith(status: TrainingsLoadingStatus.userAlreadySaved));
    } else {
      var savingResult = await trainingSessionParticipantRepository
          .joinTraining(event.trainingId);
      if (savingResult) {
        emitter(state.copyWith(status: TrainingsLoadingStatus.saved));
      } else {
        emitter(state.copyWith(status: TrainingsLoadingStatus.error));
      }
    }

    emitter(state.copyWith(status: TrainingsLoadingStatus.idle));
  }
}
