import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:resize/resize.dart';

Widget yellowLabel([String? text]) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
    color: AppColors.primary,
    child: AppText(
      text ?? 'PROFESSIONAL',
      fontWeight: FontWeight.w700,
      textSize: 12.sp,
      textColor: AppColors.professional,
    ),
  );
}

Widget purpleLabel() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
    color: AppColors.lightPurple,
    child: AppText(
      'STUDENT',
      fontWeight: FontWeight.w700,
      textSize: 12.sp,
      textColor: AppColors.student,
    ),
  );
}
