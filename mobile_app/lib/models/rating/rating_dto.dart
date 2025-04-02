import 'package:sport_plus/models/rating/object_type.dart';

class RatingDto {
  int rate;
  ObjectType objectType;
  int objectId;

  RatingDto({
    required this.rate,
    required this.objectType,
    required this.objectId,
  });

  factory RatingDto.fromJson(Map<String, dynamic> json) {
    return RatingDto(
      rate: json['rate'],
      objectType: json['objectType']?.toObjectType(),
      objectId: json['objectId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'objectType': objectType.name,
      'objectId': objectId,
    };
  }
}
