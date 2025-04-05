import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:resize/resize.dart';

class AppTheme {
  final ThemeData themeData = ThemeData(
      fontFamily: 'Muli',
      scaffoldBackgroundColor: AppColors.white,
      iconTheme: const IconThemeData(color: AppColors.grey79),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black),
        elevation: 0,
        backgroundColor: AppColors.white,
        // iconTheme: Icon
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.disabledButton;
          }
          return AppColors.primary;
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return AppColors.primary; // Use the component's default.
        },
      ), textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) {
          return TextStyle(
              fontSize: 16.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w500); // Use the component's default.
        },
      ))),
      tabBarTheme: TabBarTheme(
          labelColor: AppColors.bottomNavIndicator,
          labelPadding: EdgeInsets.zero,
          labelStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.bottomNavIndicator,
              fontWeight: FontWeight.w600),
          unselectedLabelColor: AppColors.greyC3,
          unselectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.grey79,
              fontWeight: FontWeight.w300),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: UnderlineTabIndicator(
            borderSide: const BorderSide(
                color: AppColors.bottomNavIndicator, width: 3.0),
            insets: EdgeInsets.fromLTRB(10.w, 0.0, 10.w, 87.h),
          )));

  static List<BoxShadow> boxShadow1 = const [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 13,
      spreadRadius: 2,
      color: AppColors.boxShadow,
    ),
  ];
}
