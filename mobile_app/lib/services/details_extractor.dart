import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/models/coach/coach.dart';
import 'package:sport_plus/models/coach/coach_avarege_rating.dart';
import 'package:sport_plus/models/details/facility_details.dart';
import 'package:sport_plus/models/open_hours/open_time.dart';
import 'package:sport_plus/models/open_hours/opening_time.dart';
import 'package:sport_plus/models/sport_facility.dart';
import 'package:sport_plus/screens/facility_details/models/coach_with_rating.dart';
import 'package:sport_plus/screens/facility_details/models/facility_data.dart';

class DetailsExtractor {
  FacilityData getData(
      SportFacilityDetails details, List<SportFacility> userFacility) {
    return FacilityData(
        id: details.id ?? -1,
        name: details.name ?? "",
        description: details.description ?? "",
        address: details.address ?? "",
        type: details.type,
        membershipRequired: details.membershipRequired,
        imageUrl: details.imageUrl ?? "",
        openHours: _getOpenHours(details.openHours),
        coaches: _getCoachesData(details.coaches, details.coachRatings),
        equipment: details.equipment ?? [],
        rating: details.averageRating,
        trainings: details.trainingSessions ?? [],
        news: details.news ?? [],
        canRate: userFacility
                    .where((facility) => facility.id == details.id)
                    .firstOrNull !=
                null ||
            !details.membershipRequired);
  }

  List<CoachWithRating> _getCoachesData(
      List<Coach>? coaches, List<CoachAverageRating>? ratings) {
    if (coaches == null) return [];

    List<CoachWithRating> values = [];
    for (var coach in coaches) {
      var rating =
          ratings?.where((element) => element.coachId == coach.id).firstOrNull;
      values.add(CoachWithRating(
          id: coach.id ?? -1,
          averageRating: rating?.averageRating,
          imageUrl: coach.imageUrl ?? "",
          name: coach.name ?? "",
          surname: coach.surname ?? ""));
    }
    return values;
  }

  Map<String, String> _getOpenHours(OpenHour? openHours) {
    if (openHours == null) return {};
    return {
      AppStrings.monday: _formatOpenTime(openHours.monday),
      AppStrings.tuesday: _formatOpenTime(openHours.tuesday),
      AppStrings.wednesday: _formatOpenTime(openHours.wednesday),
      AppStrings.thursday: _formatOpenTime(openHours.thursday),
      AppStrings.friday: _formatOpenTime(openHours.friday),
      AppStrings.saturday: _formatOpenTime(openHours.saturday),
      AppStrings.sunday: _formatOpenTime(openHours.sunday),
    };
  }

  String _formatOpenTime(OpeningTime? time) {
    if (time == null) return "";
    DateTime open = DateTime.parse("1970-01-01T${time.start}");
    DateTime close = DateTime.parse("1970-01-01T${time.end}");

    String openMinutes = open.minute.toString().padLeft(2, '0');
    String closeMinutes = close.minute.toString().padLeft(2, '0');

    return "${open.hour}:$openMinutes - ${close.hour}:$closeMinutes";
  }
}
