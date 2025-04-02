import 'package:sport_plus/models/details/sport_equipment.dart';
import 'package:sport_plus/models/sport_facility_news.dart';
import 'package:sport_plus/models/sport_facility_type.dart';
import 'package:sport_plus/models/training_session/training_session.dart';
import 'package:sport_plus/screens/facility_details/models/coach_with_rating.dart';

class FacilityData {
  int id;
  String name;
  String description;
  String address;
  SportFacilityType type;
  bool membershipRequired;
  String imageUrl;
  double? rating;
  Map<String, String> openHours;
  List<CoachWithRating> coaches;
  List<SportEquipment> equipment;
  List<TrainingSession> trainings;
  List<SportFacilityNews> news;
  bool canRate;

  FacilityData(
      {required this.id,
      required this.name,
      required this.description,
      required this.address,
      required this.type,
      required this.membershipRequired,
      required this.imageUrl,
      required this.openHours,
      required this.coaches,
      required this.equipment,
      required this.rating,
      required this.trainings,
      required this.news,
      required this.canRate});
}
