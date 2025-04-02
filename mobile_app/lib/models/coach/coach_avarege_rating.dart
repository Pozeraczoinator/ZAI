class CoachAverageRating {
  int? coachId;
  String? coachName;
  double? averageRating;

  CoachAverageRating({
    this.coachId,
    this.coachName,
    this.averageRating,
  });

  factory CoachAverageRating.fromJson(Map<String, dynamic> json) {
    return CoachAverageRating(
      coachId: json['coachId'],
      coachName: json['coachName'],
      averageRating: json['averageRating']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coachId': coachId,
      'coachName': coachName,
      'averageRating': averageRating,
    };
  }
}
