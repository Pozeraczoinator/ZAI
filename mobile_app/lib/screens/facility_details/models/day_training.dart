class DayTrainings {
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final int coachId;
  final int trainingId;
  final int freeBooked;
  const DayTrainings(
      {required this.description,
      required this.end,
      required this.start,
      required this.title,
      required this.coachId,
      required this.freeBooked,
      required this.trainingId});
}
