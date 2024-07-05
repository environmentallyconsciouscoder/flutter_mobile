import 'dart:math';
import 'package:flutter/material.dart';

class UI {
  static const double _minuteSize = 3.0;
  static const double _tinySize = 5.0;
  static const double _extraSmallSize = 10.0;
  static const double _smallSize = 15.0;
  static const double _mediumSize = 25.0;
  static const double _largeSize = 50.0;
  static const double _extraLargeSize = 120.0;
  static const double _massiveSize = 260.0;

  static const Widget horizontalSpaceMinute = SizedBox(width: _minuteSize);
  static const Widget horizontalSpaceTiny = SizedBox(width: _tinySize);
  static const Widget horizontalSpaceExtraSmall = SizedBox(width: _extraSmallSize);
  static const Widget horizontalSpaceSmall = SizedBox(width: _smallSize);
  static const Widget horizontalSpaceMedium = SizedBox(width: _mediumSize);
  static const Widget horizontalSpaceLarge = SizedBox(width: _largeSize);
  static const Widget horizontalSpaceExtraLarge = SizedBox(width: _extraLargeSize);
  static const Widget horizontalSpaceMassive = SizedBox(width: _massiveSize);

  static const Widget verticalSpaceMinute = SizedBox(height: _minuteSize);
  static const Widget verticalSpaceTiny = SizedBox(height: _tinySize);
  static const Widget verticalSpaceExtraSmall = SizedBox(height: _extraSmallSize);
  static const Widget verticalSpaceSmall = SizedBox(height: _smallSize);
  static const Widget verticalSpaceMedium = SizedBox(height: _mediumSize);
  static const Widget verticalSpaceLarge = SizedBox(height: _largeSize);
  static const Widget verticalSpaceExtraLarge = SizedBox(height: _extraLargeSize);
  static const Widget verticalSpaceMassive = SizedBox(height: _massiveSize);

  static Widget spacedDivider = Column(
    children: const <Widget>[
      verticalSpaceMedium,
      Divider(height: 5.0, thickness: 2.0),
      verticalSpaceMedium,
    ],
  );

  static Widget verticalSpace(double height) => SizedBox(height: height);

  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static double screenHeightPercentage(BuildContext context, {double percentage = 1}) => screenHeight(context) * percentage;
  static double screenWidthPercentage(BuildContext context, {double percentage = 1}) => screenWidth(context) * percentage;

  static double screenHeightFraction(BuildContext context, {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
      min((screenHeight(context) - offsetBy) / dividedBy, max);

  static double screenWidthFraction(BuildContext context, {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
      min((screenWidth(context) - offsetBy) / dividedBy, max);

  static double halfScreenWidth(BuildContext context) => screenWidthFraction(context, dividedBy: 2);
  static double thirdScreenWidth(BuildContext context) => screenWidthFraction(context, dividedBy: 3);
  static double quarterScreenWidth(BuildContext context) => screenWidthFraction(context, dividedBy: 4);
  static double eighthScreenWidth(BuildContext context) => screenWidthFraction(context, dividedBy: 8);

  static double halfScreenHeight(BuildContext context) => screenHeightFraction(context, dividedBy: 2);
  static double thirdScreenHeight(BuildContext context) => screenHeightFraction(context, dividedBy: 3);
  static double quarterScreenHeight(BuildContext context) => screenHeightFraction(context, dividedBy: 4);
  static double eighthScreenHeight(BuildContext context) => screenHeightFraction(context, dividedBy: 8);

  static double getResponsiveHorizontalSpaceMedium(BuildContext context) => screenWidthFraction(context, dividedBy: 10);

  static double getResponsiveSmallFontSize(BuildContext context) => getResponsiveFontSize(context, fontSize: 14, max: 15);
  static double getResponsiveMediumFontSize(BuildContext context) => getResponsiveFontSize(context, fontSize: 16, max: 17);
  static double getResponsiveLargeFontSize(BuildContext context) => getResponsiveFontSize(context, fontSize: 21, max: 31);
  static double getResponsiveExtraLargeFontSize(BuildContext context) => getResponsiveFontSize(context, fontSize: 25);
  static double getResponsiveMassiveFontSize(BuildContext context) => getResponsiveFontSize(context, fontSize: 30);

  static double getResponsiveFontSize(BuildContext context, {double? fontSize, double? max}) {
    max ??= 100;

    var responsiveSize = min(screenWidthFraction(context, dividedBy: 10) * ((fontSize ?? 100) / 100), max);
    return responsiveSize;
  }
}
