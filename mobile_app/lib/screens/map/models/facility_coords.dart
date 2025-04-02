import 'dart:ui';

import 'package:sport_plus/screens/map/models/coordinates.dart';

class FacilityCoords {
  final int facilityId;
  final String name;
  final String address;
  final Coordinates? cords;
  final Color pinColor;
  FacilityCoords(
      {required this.cords,
      required this.facilityId,
      required this.name,
      required this.address,
      required this.pinColor});
}
