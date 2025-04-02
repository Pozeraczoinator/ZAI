import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/models/sport_facility.dart';
import 'package:sport_plus/screens/facility_details/facility_details_screen.dart';

class SportFacilitiesSlider extends StatelessWidget {
  final String title;
  final List<SportFacility> facilities;
  const SportFacilitiesSlider(
      {super.key, required this.facilities, required this.title});

  @override
  Widget build(BuildContext context) {
    if (facilities.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            title,
            style: AppTypography.bigTextStyle,
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
              enableInfiniteScroll: false, disableCenter: true, height: 230),
          items: facilities.map((element) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, FacilityDetailsScreen.route,
                  arguments: element.id),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: Image.network(
                          "${AppConsts.imageContainerUrl}${element.imageUrl}",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            element.name,
                            style: AppTypography.bigBoldTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            element.address,
                            style: AppTypography.defaultTextStyle,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
