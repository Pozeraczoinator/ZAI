import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/config/app_strings.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/models/sport_facility_news.dart';

class NewsDialog extends StatelessWidget {
  final List<SportFacilityNews> news;
  const NewsDialog({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    AppStrings.news,
                    style: AppTypography.bigBoldTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close)),
                  )
                ],
              ),
              const SizedBox(height: 15),
              ...news.map(
                (element) => Card(
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
                              element.title,
                              style: AppTypography.bigBoldTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              element.description,
                              style: AppTypography.defaultTextStyle,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
