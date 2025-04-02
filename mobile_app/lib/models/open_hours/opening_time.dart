class OpeningTime {
  String? start;
  String? end;

  OpeningTime({
    this.start,
    this.end,
  });

  factory OpeningTime.fromJson(Map<String, dynamic> json) {
    return OpeningTime(
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }
}
