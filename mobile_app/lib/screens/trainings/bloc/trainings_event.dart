part of 'trainings_bloc.dart';

abstract class TrainingsEvent {}

class InitUserTrainingDataEvent extends TrainingsEvent {
  final dynamic trainings;
  InitUserTrainingDataEvent(this.trainings);
}

class SingUpForTrainingEvent extends TrainingsEvent {
  final int trainingId;
  SingUpForTrainingEvent(this.trainingId);
}

class WeekChangedEvent extends TrainingsEvent {
  final DateTime newFocusDate;
  WeekChangedEvent(this.newFocusDate);
}
