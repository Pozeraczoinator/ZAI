import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_colors.dart';

enum SportFacilityType {
  silownia,
  basen,
  fitness,
  boisko,
  hala,
  stadion,
  tenis,
  sauna,
  squash,
  other;

  static SportFacilityType fromString(String value) {
    switch (value.toLowerCase()) {
      case "siłownia":
        return SportFacilityType.silownia;
      case "basen":
        return SportFacilityType.basen;
      case "fitness":
        return SportFacilityType.fitness;
      case "boisko":
        return SportFacilityType.boisko;
      case "hala sportowa":
        return SportFacilityType.hala;
      case "stadion":
        return SportFacilityType.stadion;
      case "kort tenisowy":
        return SportFacilityType.tenis;
      case "sauna":
        return SportFacilityType.sauna;
      case "kort do squasha":
        return SportFacilityType.squash;
      default:
        return SportFacilityType.other;
    }
  }

  @override
  String toString() {
    switch (this) {
      case SportFacilityType.silownia:
        return "Siłownia";
      case SportFacilityType.basen:
        return "Basen";
      case SportFacilityType.fitness:
        return "Fitness";
      case SportFacilityType.boisko:
        return "Boisko";
      case SportFacilityType.hala:
        return "Hala sportowa";
      case SportFacilityType.stadion:
        return "Stadion";
      case SportFacilityType.tenis:
        return "Kort tenisowy";
      case SportFacilityType.sauna:
        return "Sauna";
      case SportFacilityType.squash:
        return "Kort do squasha";
      case SportFacilityType.other:
      default:
        return "Inny";
    }
  }

  Color toColor() {
    switch (this) {
      case SportFacilityType.silownia:
        return AppColors.gym;
      case SportFacilityType.basen:
        return AppColors.basen;
      case SportFacilityType.fitness:
        return AppColors.fitness;
      case SportFacilityType.boisko:
        return AppColors.boisko;
      case SportFacilityType.hala:
        return AppColors.hala;
      case SportFacilityType.stadion:
        return AppColors.stadion;
      case SportFacilityType.tenis:
        return AppColors.tenis;
      case SportFacilityType.sauna:
        return AppColors.sauna;
      case SportFacilityType.squash:
        return AppColors.squash;
      case SportFacilityType.other:
      default:
        return AppColors.otherType;
    }
  }
}
