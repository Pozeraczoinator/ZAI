import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_colors.dart';
import 'package:sport_plus/config/app_typography.dart';

class ProfilInfoLabel extends StatelessWidget {
  final String value;
  final String label;
  const ProfilInfoLabel({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.bigBoldTextStyle(color: AppColors.mainColor),
          ),
          Text(
            value,
            style: AppTypography.bigTextStyle,
          )
        ],
      ),
    );
  }
}
