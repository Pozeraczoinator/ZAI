import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/screens/home/models/news.dart';

class NewsSlider extends StatelessWidget {
  final String title;
  final List<News> news;
  const NewsSlider({super.key, required this.news, required this.title});

  @override
  Widget build(BuildContext context) {
    if (news.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            title,
            style: AppTypography.bigTextStyle,
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
              enableInfiniteScroll: false, disableCenter: true, height: 300),
          items: news.map((element) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            "${AppConsts.imageContainerUrl}${element.imageUrl}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox(),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              element.facilityName,
                              style: AppTypography.titleStyle,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
