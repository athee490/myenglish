import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/enums.dart';

void showToast(String message,
    {ToastType type = ToastType.defaul,
    Color? backgroundColor,
    Color? textColor,
    ToastGravity? gravity,
    Toast? length}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: length ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor ??
          (type == ToastType.success
              ? AppColors.green
              : type == ToastType.error
                  ? AppColors.red
                  : null),
      textColor: textColor);
}
