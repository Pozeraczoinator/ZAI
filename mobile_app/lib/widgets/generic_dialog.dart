import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/widgets/generic_button.dart';

class GenericDialog extends StatelessWidget {
  final String title;
  const GenericDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: GenericButton(
          onTap: () => Navigator.pop(context), title: AppStrings.agree),
    );
  }
}
