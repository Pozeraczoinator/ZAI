import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_colors.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.mainColor,
      ),
    );
  }
}
