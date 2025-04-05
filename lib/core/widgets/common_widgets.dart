import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/app_colors.dart';

///custom widget for providing vertical height. Provide [height] as percentage (1 to 100)
Widget vHeight([double? height]) => SizedBox(
      height: (height ?? 10),
    );

///custom widget for providing horizontal width. Provide [width] as percentage (1 to 100)
Widget width([double? width]) => SizedBox(
      width: (width ?? 10),
    );

Widget verticalSeparatorWidget(
    {double width = 1,
    Color color = AppColors.greyDC,
    double verticalMargin = 0}) {
  return Container(
    color: color,
    width: width,
    margin: EdgeInsets.symmetric(vertical: verticalMargin),
  );
}

Widget horizontalSeparatorWidget(
    {double height = 1,
    Color color = AppColors.greyDC,
    double horizontalMargin = 0}) {
  return Container(
    width: double.infinity,
    height: height,
    color: color,
    margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
  );
}
