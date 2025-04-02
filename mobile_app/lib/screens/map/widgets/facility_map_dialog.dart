import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/screens/facility_details/facility_details_screen.dart';
import 'package:sport_plus/screens/map/models/facility_coords.dart';
import 'package:sport_plus/widgets/generic_button.dart';

class FacilityMapDialog extends StatelessWidget {
  final FacilityCoords facility;
  const FacilityMapDialog({super.key, required this.facility});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${facility.name} - ${facility.address}",
              style: AppTypography.bigBoldTextStyle(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            GenericButton(
                onTap: () => Navigator.pushNamed(
                    context, FacilityDetailsScreen.route,
                    arguments: facility.facilityId),
                title: AppStrings.goToDetails)
          ],
        ),
      ),
    );
  }
}
