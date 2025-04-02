part of 'trainings_bloc.dart';

enum TrainingsLoadingStatus {
  idle,
  saving,
  saved,
  error,
  userAlreadySaved,
  loading,
  loadingError
}

class TrainingsState extends Equatable {
  final TrainingsLoadingStatus status;
  final List<TrainingSession> userTrainings;
  final List<DayTrainings> extractedTrainings;
  final List<TrainingSession> trainingsList;
  final List<Coach> coaches;
  const TrainingsState({
    this.status = TrainingsLoadingStatus.loading,
    this.userTrainings = const [],
    this.extractedTrainings = const [],
    this.trainingsList = const [],
    this.coaches = const [],
  });

  TrainingsState copyWith({
    TrainingsLoadingStatus? status,
    List<TrainingSession>? userTrainings,
    List<DayTrainings>? extractedTrainings,
    List<TrainingSession>? trainingsList,
    List<Coach>? coaches,
  }) {
    return TrainingsState(
      status: status ?? this.status,
      userTrainings: userTrainings ?? this.userTrainings,
      extractedTrainings: extractedTrainings ?? this.extractedTrainings,
      trainingsList: trainingsList ?? this.trainingsList,
      coaches: coaches ?? this.coaches,
    );
  }

  @override
  List<Object> get props => [
        status,
        userTrainings,
        extractedTrainings,
        trainingsList,
        coaches,
      ];
}
