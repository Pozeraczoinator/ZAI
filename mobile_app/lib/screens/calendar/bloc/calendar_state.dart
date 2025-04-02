part of 'calendar_bloc.dart';

enum CalendarLoadingStatus { loading, loaded, error }

enum CalendarDeletingStatus { deleting, deleted, error, idle }

class CalendarState extends Equatable {
  final CalendarLoadingStatus status;
  final CalendarDeletingStatus deletingStatus;
  final Map<DateTime, List<CalendarTraining>> trainings;
  final List<TrainingSession> userTrainings;
  final List<SportFacility> facilities;
  final List<Coach> coaches;
  const CalendarState({
    this.status = CalendarLoadingStatus.loading,
    this.deletingStatus = CalendarDeletingStatus.idle,
    this.trainings = const {},
    this.userTrainings = const [],
    this.facilities = const [],
    this.coaches = const [],
  });

  CalendarState copyWith({
    CalendarLoadingStatus? status,
    CalendarDeletingStatus? deletingStatus,
    Map<DateTime, List<CalendarTraining>>? trainings,
    List<TrainingSession>? userTrainings,
    List<SportFacility>? facilities,
    List<Coach>? coaches,
  }) {
    return CalendarState(
        status: status ?? this.status,
        deletingStatus: deletingStatus ?? this.deletingStatus,
        trainings: trainings ?? this.trainings,
        userTrainings: userTrainings ?? this.userTrainings,
        facilities: facilities ?? this.facilities,
        coaches: coaches ?? this.coaches);
  }

  @override
  List<Object?> get props => [
        status,
        deletingStatus,
        trainings,
        userTrainings,
        facilities,
        coaches,
      ];
}
