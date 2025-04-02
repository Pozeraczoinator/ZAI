import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_plus/config/app_typography.dart';

class InfoLabel extends StatelessWidget {
  final String title;
  final Widget data;
  final bool showDivider;
  const InfoLabel(
      {super.key,
      required this.data,
      required this.title,
      this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  title,
                  style: AppTypography.defaultTextStyle,
                ),
              ),
              Flexible(
                flex: 2,
                child: Align(alignment: Alignment.centerRight, child: data),
              ),
            ],
          ),
          Visibility(
            visible: showDivider,
            child: const Divider(),
          ),
        ],
      ),
    );
  }
}
