import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/screens/facilities/bloc/all_facilities_bloc.dart';
import 'package:sport_plus/screens/facility_details/facility_details_screen.dart';
import 'package:sport_plus/widgets/app_scaffold.dart';

class AllFacilitiesLoadedView extends StatelessWidget {
  const AllFacilitiesLoadedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllFacilitiesBloc, AllFacilitiesState>(
      builder: (context, state) {
        return AppScaffold(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...state.facilities.map((element) => GestureDetector(
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
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
