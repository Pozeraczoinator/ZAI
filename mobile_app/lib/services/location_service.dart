import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:sport_plus/models/sport_facility.dart';
import 'package:sport_plus/screens/map/models/coordinates.dart';
import 'package:sport_plus/services/locator.dart';

class LocationService {
  final Logger _logger = locator.get<Logger>();

  Future<bool> checkIsLocationEnabled() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _logger.e('Location services are disabled.');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _logger.e('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _logger.e(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }

    return true;
  }

  Future<Coordinates?> getCoordsFromAddres(String addres) async {
    try {
      List<Location> locations = await locationFromAddress(addres);
      return Coordinates(locations[0].latitude, locations[0].longitude);
    } catch (e) {
      return null;
    }
  }

  Future<Coordinates?> getCoordinates() async {
    if (!await checkIsLocationEnabled()) {
      _logger.e("Can't check location, enable location in phone settings");
      return null;
    }

    var position = await Geolocator.getCurrentPosition();
    return Coordinates(position.latitude, position.longitude);
  }

  Future<List<SportFacility>> getTheClosestFacilities(
      List<SportFacility> facilities) async {
    var range = facilities.length < 5 ? facilities.length : 5;
    if (!await checkIsLocationEnabled()) {
      _logger.e("Can't check location, enable location in phone settings");
      return facilities.getRange(0, range).toList();
    }

    var position = await Geolocator.getCurrentPosition();
    Map<SportFacility, double> distances = {};
    for (var facility in facilities) {
      var facilityCoords = await getCoordsFromAddres(facility.address);
      if (facilityCoords == null) continue;
      var distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          facilityCoords.latitude,
          facilityCoords.longitude);
      distances.addAll({facility: distance});
    }
    var sortedEntries = distances.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    Map<SportFacility, double> sortedMap = {
      for (var entry in sortedEntries) entry.key: entry.value
    };
    List<SportFacility> closestFacilities = sortedMap.keys.take(range).toList();
    return closestFacilities;
  }
}
