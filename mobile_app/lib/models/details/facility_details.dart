import 'package:sport_plus/models/coach/coach.dart';
import 'package:sport_plus/models/coach/coach_avarege_rating.dart';
import 'package:sport_plus/models/open_hours/open_time.dart';
import 'package:sport_plus/models/details/sport_equipment.dart';
import 'package:sport_plus/models/sport_facility_news.dart';
import 'package:sport_plus/models/sport_facility_type.dart';
import 'package:sport_plus/models/training_session/training_session.dart';

class SportFacilityDetails {
  int? id;
  String? name;
  String? description;
  String? address;
  SportFacilityType type;
  bool membershipRequired;
  String? imageUrl;
  OpenHour? openHours;
  List<Coach>? coaches;
  List<SportEquipment>? equipment;
  double? averageRating;
  List<CoachAverageRating>? coachRatings;
  List<SportFacilityNews>? news;
  List<TrainingSession>? trainingSessions;

  SportFacilityDetails(
      {this.id,
      this.name,
      this.description,
      this.address,
      this.type = SportFacilityType.other,
      this.membershipRequired = false,
      this.imageUrl,
      this.openHours,
      this.coaches,
      this.equipment,
      this.averageRating,
      this.coachRatings,
      this.news,
      this.trainingSessions});

  factory SportFacilityDetails.fromJson(Map<String, dynamic> json) {
    return SportFacilityDetails(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      type: SportFacilityType.fromString(json['type'] ?? ""),
      membershipRequired: json['membershipRequired'] ?? false,
      imageUrl: json['imageUrl'],
      openHours: json['openHours'] != null
          ? OpenHour.fromJson(json['openHours'])
          : null,
      coaches: json['coaches'] != null
          ? (json['coaches'] as List).map((i) => Coach.fromJson(i)).toList()
          : null,
      equipment: json['equipment'] != null
          ? (json['equipment'] as List)
              .map((i) => SportEquipment.fromJson(i))
              .toList()
          : null,
      averageRating: json['averageRating']?.toDouble(),
      coachRatings: json['coachRatings'] != null
          ? (json['coachRatings'] as List)
              .map((i) => CoachAverageRating.fromJson(i))
              .toList()
          : null,
      trainingSessions: json['trainingSessions'] != null
          ? (json['trainingSessions'] as List)
              .map((i) => TrainingSession.fromDetailsJson(i))
              .toList()
          : null,
      news: json['news'] != null
          ? (json['news'] as List)
              .map((i) => SportFacilityNews.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'type': type.toString(),
      'membershipRequired': membershipRequired,
      'imageUrl': imageUrl,
      'openHours': openHours?.toJson(),
      'coaches': coaches?.map((e) => e.toJson()).toList(),
      'equipment': equipment?.map((e) => e.toJson()).toList(),
      'averageRating': averageRating,
      'coachRatings': coachRatings?.map((e) => e.toJson()).toList(),
    };
  }
}
