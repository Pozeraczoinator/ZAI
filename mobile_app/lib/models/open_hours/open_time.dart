import 'opening_time.dart';

class OpenHour {
  int? id;
  OpeningTime? monday;
  OpeningTime? tuesday;
  OpeningTime? wednesday;
  OpeningTime? thursday;
  OpeningTime? friday;
  OpeningTime? saturday;
  OpeningTime? sunday;

  OpenHour({
    this.id,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  factory OpenHour.fromJson(Map<String, dynamic> json) {
    return OpenHour(
      id: json['id'],
      monday:
          json['monday'] != null ? OpeningTime.fromJson(json['monday']) : null,
      tuesday: json['tuesday'] != null
          ? OpeningTime.fromJson(json['tuesday'])
          : null,
      wednesday: json['wednesday'] != null
          ? OpeningTime.fromJson(json['wednesday'])
          : null,
      thursday: json['thursday'] != null
          ? OpeningTime.fromJson(json['thursday'])
          : null,
      friday:
          json['friday'] != null ? OpeningTime.fromJson(json['friday']) : null,
      saturday: json['saturday'] != null
          ? OpeningTime.fromJson(json['saturday'])
          : null,
      sunday:
          json['sunday'] != null ? OpeningTime.fromJson(json['sunday']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'monday': monday?.toJson(),
      'tuesday': tuesday?.toJson(),
      'wednesday': wednesday?.toJson(),
      'thursday': thursday?.toJson(),
      'friday': friday?.toJson(),
      'saturday': saturday?.toJson(),
      'sunday': sunday?.toJson(),
    };
  }
}
