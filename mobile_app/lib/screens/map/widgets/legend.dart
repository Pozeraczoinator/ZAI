import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/models/sport_facility_type.dart';
import 'package:sport_plus/screens/map/widgets/legend_row.dart';

class Legend extends StatelessWidget {
  const Legend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.legend,
            style: AppTypography.defaultBoldTextStyle(),
          ),
          ...SportFacilityType.values.map((type) =>
              LegendRow(color: type.toColor(), text: type.toString())),
        ],
      ),
    );
  }
}
