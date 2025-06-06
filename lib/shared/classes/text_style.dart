import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/appStrings.dart';

class AppTextStyle {
  static TextStyle textStyle({
    double? appFontSize,
    double? appFontHeight,
    Color? color,
    FontWeight appFontWeight = FontWeight.w400,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    Color? decorationColor,
    double? decorationThickness,
    double? letterSpacing,
    List<Shadow>? shadows,
  }) {
    return TextStyle(
      fontSize: appFontSize,
      fontWeight: appFontWeight,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      decorationStyle: decorationStyle,
      fontFamily: AppStrings.fontFamily,
      shadows: shadows,
      height:
          appFontHeight != null && appFontSize != null
              ? appFontHeight / appFontSize!
              : null, //appFontSize / appFontSize,
      letterSpacing: letterSpacing, //_getLetterSpacing(appFontSize),
    );
  }

  static double? _getLetterSpacing(double appFontSize) {
    switch (appFontSize) {
      case <= 13:
        return 0.005;
      case <= 19:
        return 0;
      case <= 29:
        return -0.005;
      case <= 47:
        return -0.01;
      case <= 71:
        return -0.015;
      case > 71:
        return -0.02;
      default:
        return null;
    }
  }
}

class AppFontWeight {
  static FontWeight get regular => FontWeight.w400;
  static FontWeight get medium => FontWeight.w500;
  static FontWeight get simBold => FontWeight.w600;
  static FontWeight get bold => FontWeight.w700;
}

class AppFontSize {
  ///font sized = 12.sp
  static double get textXXXS => 8.sp;

  static double get textXXS => 10.sp;

  ///font sized = 12.sp
  static double get textXS => 11.sp;

  ///font sized = 14.sp
  static double get textSM => 14.sp;

  ///font sized = 15.sp
  static double get textUs => 15.sp;

  ///font sized = 16.sp
  static double get textMD => 16.sp;

  ///font sized = 18.sp
  static double get textLG => 18.sp;

  ///font sized = 20.sp
  static double get textXL => 20.sp;
  static double get textXLL => 22.sp;

  ///font sized = 24.sp
  static double get displayXS => 24.sp;

  ///font sized = 30.sp
  static double get displaySM => 30.sp;

  ///font sized = 36.sp
  static double get displayMD => 36.sp;

  ///font sized = 48.sp
  static double get displayLG => 48.sp;

  ///font sized = 60.sp
  static double get displayXL => 60.sp;

  ///font sized = 72.sp
  static double get display2XL => 72.sp;

  ///font sized = 28.sp
  static double get login => 28.sp;
  static double get login1 => 13.sp;
}
