import 'package:sport_plus/models/coach/coach.dart';
import 'package:sport_plus/models/training_session/training_session_participant.dart';

class TrainingSession {
  int? id;
  int? coachesId;
  int? sportFacilitiesId;
  String? name;
  String? startHour;
  int? duration;
  int? isWeekly;
  DateTime? trainingDate;
  int? capacity;
  int? freeBooked;
  Coach? coach;
  List<TrainingSessionParticipant>? trainingSessionParticipants;

  TrainingSession({
    this.id,
    this.coachesId,
    this.sportFacilitiesId,
    this.name,
    this.startHour,
    this.duration,
    this.isWeekly,
    this.trainingDate,
    this.capacity,
    this.freeBooked,
    this.coach,
    this.trainingSessionParticipants,
  });

  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    var trainingJson = json["trainingSession"];
    return TrainingSession(
      id: trainingJson['id'] as int?,
      coachesId: trainingJson['coachId'] as int?,
      sportFacilitiesId: trainingJson['sportFacilityId'] as int?,
      name: trainingJson['name'] as String?,
      startHour: trainingJson['startHour'] as String?,
      duration: trainingJson['duration'] as int?,
      isWeekly: trainingJson['isWeekly'] as int?,
      trainingDate: trainingJson['trainingDate'] != null
          ? DateTime.parse(trainingJson['trainingDate'])
          : null,
      capacity: trainingJson['capacity'] as int?,
      freeBooked: trainingJson['freeBooked'] as int?,
      coach: trainingJson['coach'] != null
          ? Coach.fromJson(trainingJson['coach'])
          : null,
      trainingSessionParticipants:
          (trainingJson['trainingSessionParticipants'] as List<dynamic>?)
              ?.map((e) => TrainingSessionParticipant.fromJson(e))
              .toList(),
    );
  }
  factory TrainingSession.fromDetailsJson(Map<String, dynamic> trainingJson) {
    return TrainingSession(
      id: trainingJson['id'] as int?,
      coachesId: trainingJson['coachId'] as int?,
      sportFacilitiesId: trainingJson['sportFacilitiesId'] as int?,
      name: trainingJson['name'] as String?,
      startHour: trainingJson['startHour'] as String?,
      duration: trainingJson['duration'] as int?,
      isWeekly: trainingJson['isWeekly'] as int?,
      trainingDate: trainingJson['trainingDate'] != null
          ? DateTime.parse(trainingJson['trainingDate'])
          : null,
      capacity: trainingJson['capacity'] as int?,
      freeBooked: trainingJson['freeBooked'] as int?,
      coach: trainingJson['coach'] != null
          ? Coach.fromJson(trainingJson['coach'])
          : null,
      trainingSessionParticipants:
          (trainingJson['trainingSessionParticipants'] as List<dynamic>?)
              ?.map((e) => TrainingSessionParticipant.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['coachesId'] = coachesId;
    data['sportFacilitiesId'] = sportFacilitiesId;
    data['name'] = name;
    data['startHour'] = startHour;
    data['duration'] = duration;
    data['isWeekly'] = isWeekly;
    data['trainingDate'] = trainingDate?.toIso8601String();
    data['capacity'] = capacity;
    data['freeBooked'] = freeBooked;
    if (coach != null) {
      data['coach'] = coach!.toJson();
    }

    if (trainingSessionParticipants != null) {
      data['trainingSessionParticipants'] =
          trainingSessionParticipants!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
