import "package:collection/collection.dart";
import 'package:sport_plus/models/sport_facility_news.dart';
import 'package:sport_plus/models/sport_facility.dart';

class News {
  String title;
  String description;
  String imageUrl;
  String facilityName;

  News(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.facilityName});

  factory News.fromResponse(
      SportFacilityNews input, List<SportFacility> facilities) {
    return News(
        title: input.title,
        description: input.description,
        imageUrl: input.imageUrl,
        facilityName: facilities
                .firstWhereOrNull((e) => e.id == input.sportFacilitiesId)
                ?.name ??
            "");
  }
}
