import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/widgets/app_scaffold.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Center(
        child: Text(
          AppStrings.loadingError,
          style: AppTypography.bigTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
