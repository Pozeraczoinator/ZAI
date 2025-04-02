import 'package:sport_plus/models/user/user_dto.dart';

class TrainingSessionParticipant {
  int? userId;
  int? trainingSessionId;
  UserDto? user;

  // Konstruktor
  TrainingSessionParticipant({
    this.userId,
    this.trainingSessionId,
    this.user,
  });

  // Metoda fromJson
  factory TrainingSessionParticipant.fromJson(Map<String, dynamic> json) {
    return TrainingSessionParticipant(
      userId: json['userId'] as int?,
      trainingSessionId: json['trainingSessionId'] as int?,
      user: json['user'] != null ? UserDto.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['trainingSessionId'] = trainingSessionId;
    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }
}
