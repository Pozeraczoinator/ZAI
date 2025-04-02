import 'package:sport_plus/models/sport_facility_type.dart';

class SportFacility {
  int id;
  String name;
  String description;
  String address;
  SportFacilityType type;
  bool membershipRequired;
  String imageUrl;

  SportFacility(
      {required this.id,
      required this.name,
      required this.description,
      required this.address,
      required this.type,
      required this.membershipRequired,
      required this.imageUrl});

  factory SportFacility.fromJson(Map<String, dynamic> json) {
    return SportFacility(
      id: json['id'] ?? -1,
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      address: json['address'] ?? "",
      type: SportFacilityType.fromString(json['type'] ?? ""),
      membershipRequired: json['membershipRequired'] ?? true,
      imageUrl: json['imageUrl'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['address'] = address;
    data['type'] = type.toString();
    data['membershipRequired'] = membershipRequired;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
