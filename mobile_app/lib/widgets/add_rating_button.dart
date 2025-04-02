import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/models/rating/object_type.dart';
import 'package:sport_plus/screens/facility_details/bloc/facility_details_bloc.dart';
import 'package:sport_plus/widgets/generic_button.dart';
import 'package:sport_plus/widgets/rating_dialog.dart';

class AddRatingButton extends StatelessWidget {
  final int objectId;
  final ObjectType objectType;
  final bool canRate;
  const AddRatingButton(
      {super.key,
      required this.objectId,
      required this.objectType,
      required this.canRate});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: canRate,
      child: GenericButton(
          takeLessSpace: true,
          onTap: () async => await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const RatingDialog(),
              ).then((value) {
                if (value is int) {
                  context.read<FacilityDetailsBloc>().add(AddRatingEvent(
                      rating: value,
                      objectId: objectId,
                      objectType: objectType));
                }
              }),
          title: AppStrings.addRating),
    );
  }
}
