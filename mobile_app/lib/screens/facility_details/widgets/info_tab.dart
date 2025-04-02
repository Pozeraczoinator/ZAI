import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sport_plus/config/app_colors.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/screens/facility_details/models/facility_data.dart';
import 'package:sport_plus/screens/facility_details/widgets/info_label.dart';
import 'package:sport_plus/screens/facility_details/widgets/news_dialog.dart';
import 'package:sport_plus/screens/trainings/trainings_screen.dart';

class InfoTab extends StatelessWidget {
  final FacilityData facility;
  const InfoTab({super.key, required this.facility});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              facility.name,
              style: AppTypography.bigBoldTextStyle(),
            ),
            Text(
              facility.description,
              style: AppTypography.defaultTextStyle,
            ),
            const SizedBox(height: 20),
            InfoLabel(
                data: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      facility.address,
                      style: AppTypography.defaultBoldTextStyle(),
                    ),
                    facility.address.isNotEmpty
                        ? GestureDetector(
                            onTap: () async {
                              await MapsLauncher.launchQuery(facility.address);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.mainColor,
                                ),
                                Text(
                                  AppStrings.facilityMap,
                                  style: AppTypography.detailTextStyle,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                title: AppStrings.address),
            InfoLabel(
                data: facility.membershipRequired
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                title: AppStrings.membershipRequired),
            Visibility(
              visible: facility.openHours.isNotEmpty,
              child: Text(
                AppStrings.openHours,
                style: AppTypography.defaultBoldTextStyle(),
              ),
            ),
            ...facility.openHours.entries.map(
              (hour) => InfoLabel(
                showDivider: false,
                data: Text(
                  hour.value,
                  style: AppTypography.defaultBoldTextStyle(),
                ),
                title: hour.key,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(
                        context, TrainingsScreen.route,
                        arguments: facility.trainings),
                    child: const Text(AppStrings.checkTrainings),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => NewsDialog(news: facility.news),
                    ),
                    child: const Text(AppStrings.whatsNew),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
