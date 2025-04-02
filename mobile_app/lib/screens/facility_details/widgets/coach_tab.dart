import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/models/rating/object_type.dart';
import 'package:sport_plus/screens/facility_details/models/facility_data.dart';
import 'package:sport_plus/screens/trainings/trainings_screen.dart';
import 'package:sport_plus/widgets/add_rating_button.dart';

class CoachTab extends StatelessWidget {
  final FacilityData facility;
  const CoachTab({super.key, required this.facility});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...facility.coaches.map(
            (coach) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    child: Image.network(
                      "${AppConsts.imageContainerUrl}${coach.imageUrl}",
                      width: MediaQuery.of(context).size.width * 0.35,
                      errorBuilder: (context, error, stackTrace) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: const Icon(
                          Icons.person,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                Visibility(
                                  visible: coach.averageRating != null,
                                  child: RatingStars(
                                    value: coach.averageRating ?? 0,
                                    valueLabelVisibility: false,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: AddRatingButton(
                                      canRate: facility.canRate,
                                      objectId: coach.id,
                                      objectType: ObjectType.COACH),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "${coach.name} ${coach.surname}",
                            style: AppTypography.bigBoldTextStyle(),
                          ),
                          TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, TrainingsScreen.route,
                                  arguments: facility.trainings
                                      .where((element) =>
                                          element.coachesId == coach.id)
                                      .toList()),
                              child: const Text(AppStrings.checkTrainings)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
