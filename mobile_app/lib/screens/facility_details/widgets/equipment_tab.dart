import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/models/details/sport_equipment.dart';

class EquipmentTab extends StatelessWidget {
  final List<SportEquipment> equipment;
  const EquipmentTab({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...equipment.map(
            (eq) => Card(
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
                      "${AppConsts.imageContainerUrl}${eq.imageUrl}",
                      width: MediaQuery.of(context).size.width * 0.35,
                      errorBuilder: (context, error, stackTrace) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: const Icon(
                          Icons.fitness_center,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eq.type ?? "",
                            style: AppTypography.bigBoldTextStyle(),
                          ),
                          Text(
                            "${eq.brand} ${eq.model}",
                            style: AppTypography.defaultTextStyle,
                          ),
                          Text(
                            eq.description ?? "",
                            style: AppTypography.littleTextStyle,
                          ),
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
