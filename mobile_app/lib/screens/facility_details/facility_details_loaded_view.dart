import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_colors.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/models/rating/object_type.dart';
import 'package:sport_plus/screens/facility_details/models/facility_data.dart';
import 'package:sport_plus/screens/facility_details/widgets/coach_tab.dart';
import 'package:sport_plus/screens/facility_details/widgets/equipment_tab.dart';
import 'package:sport_plus/screens/facility_details/widgets/info_tab.dart';
import 'package:sport_plus/screens/facility_details/widgets/rating_row.dart';
import 'package:sport_plus/widgets/app_scaffold.dart';

class FacilityDetailsLoadedView extends StatelessWidget {
  final FacilityData facility;
  const FacilityDetailsLoadedView({super.key, required this.facility});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      setPadding: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.network(
                  fit: BoxFit.cover,
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  "${AppConsts.imageContainerUrl}${facility.imageUrl}",
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox()),
              RatingRow(
                canRate: facility.canRate,
                rating: facility.rating,
                objectId: facility.id,
                objectType: ObjectType.SPORT_FACILITY,
              )
            ],
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: <Widget>[
                  Container(
                    color: AppColors.backgroundColor,
                    child: const TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: AppColors.mainColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(text: AppStrings.infoTab),
                        Tab(text: AppStrings.trainersTab),
                        Tab(text: AppStrings.equipmentTab),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        InfoTab(
                          facility: facility,
                        ),
                        CoachTab(
                          facility: facility,
                        ),
                        EquipmentTab(
                          equipment: facility.equipment,
                        ),
                      ],
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
