import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:resize/resize.dart';

Widget profileImageWidget(String? url, String? name) {
  var image = Image.network(
    url ?? '',
    fit: BoxFit.cover,
    width: 50.w,
    height: 50.w,
    errorBuilder: (context, url, error) {
      return AppText(
        '$name '.substring(0, 1).toUpperCase(),
        textColor: AppColors.primary,
        fontWeight: FontWeight.w700,
        textSize: 22.sp,
      );
    },
  );
  return !checkNullOrEmptyString(url)
      ? CircleAvatar(
          radius: 25.w,
          backgroundColor: AppColors.lightBlueBg,
          child: ClipOval(child: image),
        )
      : AppText(
          '$name '.substring(0, 1).toUpperCase(),
          textColor: AppColors.primary,
          fontWeight: FontWeight.w700,
          textSize: 22.sp,
        );
}
