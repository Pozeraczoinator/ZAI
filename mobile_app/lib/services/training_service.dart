import 'package:sport_plus/models/coach/coach.dart';
import 'package:sport_plus/models/sport_facility.dart';
import 'package:sport_plus/models/training_session/training_session.dart';
import 'package:sport_plus/screens/facility_details/models/day_training.dart';
import 'package:sport_plus/screens/trainings/models/calendar_training.dart';

class TrainingService {
  List<DayTrainings> extractWeekTrainings(
      List<TrainingSession> data, List<Coach> coaches, DateTime focusDate) {
    for (var training in data) {
      training.coach =
          coaches.where((coach) => coach.id == training.coachesId).firstOrNull;
    }
    List<DayTrainings> trainings = [];
    for (var training in data) {
      var date = training.trainingDate;
      if (date == null) continue;

      var trainingId = training.id ?? -1;
      var freeBooked = training.freeBooked ?? 0;
      var coachId = training.coachesId ?? -1;
      var coachName = training.coach?.name ?? "";
      var coachSurname = training.coach?.surname ?? "";
      var trainingName = training.name ?? "";
      if (training.isWeekly == 1) {
        var trainingDate = _getTrainingDateThisWeek(date, focusDate);
        var startTime = _getStartTime(training, trainingDate: trainingDate);
        var endTime = _getEndTime(training, trainingDate: trainingDate);
        if (endTime == null || startTime == null) continue;

        trainings.add(DayTrainings(
            trainingId: trainingId,
            freeBooked: freeBooked,
            coachId: coachId,
            description: "prowadzone przez: $coachName $coachSurname",
            end: endTime,
            start: startTime,
            title: trainingName));
      } else if (_isSameWeek(date, focusDate)) {
        var startTime = _getStartTime(training);
        var endTime = _getEndTime(training);
        if (endTime == null || startTime == null) continue;
        trainings.add(DayTrainings(
            trainingId: trainingId,
            freeBooked: freeBooked,
            coachId: coachId,
            description: "prowadzone przez: $coachName $coachSurname",
            end: endTime,
            start: startTime,
            title: trainingName));
      }
    }
    return trainings;
  }

  Map<DateTime, List<CalendarTraining>>? extractMonthTrainings(
      List<TrainingSession> data,
      List<Coach> coaches,
      List<SportFacility> facilities,
      DateTime focusDate) {
    Map<DateTime, List<CalendarTraining>> trainings = {};

    for (var training in data) {
      SportFacility? facility;
      training.coach =
          coaches.where((coach) => coach.id == training.coachesId).firstOrNull;
      facility = facilities
          .where((facility) => facility.id == training.sportFacilitiesId)
          .firstOrNull;

      var date = training.trainingDate;
      if (date == null) continue;

      var coachName = training.coach?.name ?? "";
      var coachSurname = training.coach?.surname ?? "";

      if (training.isWeekly == 1) {
        List<DateTime> trainingDates =
            _getTrainingDatesThisMonth(date, focusDate);

        for (var trainingDate in trainingDates) {
          var startTime = _getStartTime(training, trainingDate: trainingDate);
          var endTime = _getEndTime(training, trainingDate: trainingDate);
          if (endTime == null || startTime == null) continue;

          if (!trainings.containsKey(trainingDate)) {
            trainings[trainingDate] = [];
          }
          trainings[trainingDate]?.add(CalendarTraining(
            trainingId: training.id ?? -1,
            coachName: "$coachName $coachSurname",
            name: training.name ?? "",
            place: facility?.name ?? "",
            time: _getTrainingTime(training),
          ));
        }
      } else if (_isSameMonth(date, focusDate)) {
        var startTime = _getStartTime(training);
        var endTime = _getEndTime(training);
        if (endTime == null || startTime == null) continue;

        if (!trainings.containsKey(date)) {
          trainings[date] = [];
        }
        trainings[date]?.add(CalendarTraining(
          trainingId: training.id ?? -1,
          coachName: "$coachName $coachSurname",
          name: training.name ?? "",
          place: facility?.name ?? "",
          time: _getTrainingTime(training),
        ));
      }
    }
    return trainings;
  }

  DateTime? _getEndTime(TrainingSession training, {DateTime? trainingDate}) {
    var date = trainingDate ?? training.trainingDate;
    var startTime = training.startHour?.split(":") ?? [];
    var startHour = int.tryParse(startTime[0]);
    var startMin = int.tryParse(startTime[1]) ?? 0;
    var duration = training.duration;
    if (date == null || startHour == null || duration == null) return null;
    return date.add(Duration(hours: startHour, minutes: startMin + duration));
  }

  DateTime? _getStartTime(TrainingSession training, {DateTime? trainingDate}) {
    var date = trainingDate ?? training.trainingDate;
    var startTime = training.startHour?.split(":") ?? [];
    var startHour = int.tryParse(startTime[0]);
    var startMin = int.tryParse(startTime[1]) ?? 0;
    var duration = training.duration;
    if (date == null || startHour == null || duration == null) return null;
    return date.add(Duration(hours: startHour, minutes: startMin));
  }

  String _getTrainingTime(TrainingSession training) {
    var date = training.trainingDate;
    var startTime = training.startHour?.split(":") ?? [];
    var startHour = int.tryParse(startTime[0]);
    var startMin = int.tryParse(startTime[1]) ?? 0;
    var duration = training.duration;
    if (date == null || startHour == null || duration == null) return "";
    date.add(Duration(hours: startHour, minutes: startMin + duration));
    var endTime = "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    var lastStartTime = "$startHour:${startMin.toString().padLeft(2, '0')}";
    return "$lastStartTime - $endTime";
  }

  bool _isSameWeek(DateTime dateToCheck, DateTime focusDate) {
    DateTime startOfWeek =
        focusDate.subtract(Duration(days: focusDate.weekday - 1));

    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    return dateToCheck.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        dateToCheck.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  DateTime _getTrainingDateThisWeek(
      DateTime firstTrainingDate, DateTime focusDate) {
    DateTime now = DateTime(focusDate.year, focusDate.month, focusDate.day);
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    int daysDifference = firstTrainingDate.weekday - startOfWeek.weekday;

    DateTime trainingDateThisWeek =
        startOfWeek.add(Duration(days: daysDifference));

    /*if (trainingDateThisWeek.isBefore(now)) {
      trainingDateThisWeek = trainingDateThisWeek.add(const Duration(days: 7));
    }*/

    return trainingDateThisWeek;
  }

  bool _isSameMonth(DateTime dateToCheck, DateTime focusDate) {
    return dateToCheck.year == focusDate.year &&
        dateToCheck.month == focusDate.month;
  }

  List<DateTime> _getTrainingDatesThisMonth(
      DateTime firstTrainingDate, DateTime focusDate) {
    List<DateTime> trainingDates = [];

    DateTime startOfMonth = DateTime(focusDate.year, focusDate.month, 1);

    int daysDifference = firstTrainingDate.weekday - startOfMonth.weekday;
    DateTime firstTrainingDateThisMonth =
        startOfMonth.add(Duration(days: daysDifference));

    if (firstTrainingDateThisMonth.isBefore(startOfMonth)) {
      firstTrainingDateThisMonth =
          firstTrainingDateThisMonth.add(const Duration(days: 7));
    }

    DateTime trainingDate = firstTrainingDateThisMonth;
    while (trainingDate.month == focusDate.month) {
      trainingDates.add(trainingDate);
      trainingDate = trainingDate.add(const Duration(days: 7));
    }

    return trainingDates;
  }
}
