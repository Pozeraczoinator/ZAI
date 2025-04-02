import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_colors.dart';

class AppTypography {
  static TextStyle defaultTextStyle = const TextStyle(fontSize: 16);
  static TextStyle defaultBoldTextStyle({Color? color}) => TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: color ?? Colors.black);
  static TextStyle bigTextStyle = const TextStyle(fontSize: 22);
  static TextStyle bigBoldTextStyle({Color? color}) => TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: color ?? Colors.black);
  static TextStyle littleTextStyle =
      const TextStyle(fontSize: 13, color: Colors.grey);
  static TextStyle titleStyle = const TextStyle(
      fontSize: 30, color: AppColors.mainColor, fontWeight: FontWeight.bold);
  static TextStyle detailTextStyle =
      const TextStyle(fontSize: 15, color: AppColors.mainColor);
}
