import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/widgets/generic_button.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double rating = 5;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      title: Stack(
        alignment: Alignment.centerRight,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const Text(
              AppStrings.addRating,
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RatingStars(
            value: rating,
            onValueChanged: (value) {
              setState(() {
                rating = value;
              });
            },
          ),
          const SizedBox(height: 20),
          GenericButton(
              onTap: () => Navigator.pop(context, rating.toInt()),
              title: AppStrings.save),
        ],
      ),
    );
  }
}
