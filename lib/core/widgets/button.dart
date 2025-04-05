import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:resize/resize.dart';

class PrimaryAppButton extends StatelessWidget {
  final String title;
  Widget? suffix;
  void Function()? onTap;
  final double? textSize;
  bool isLoading;
  final FontWeight? fontWeight;
  PrimaryAppButton({
    Key? key,
    required this.title,
    this.onTap,
    this.suffix,
    this.fontWeight,
    this.isLoading = false,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          elevation: 0,
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.disabledButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: FittedBox(
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 20.5.h,
                    width: 30,
                    child: const LoadingIndicator(
                      indicatorType: Indicator.ballSpinFadeLoader,
                      colors: [AppColors.white],
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        title,
                        textColor: AppColors.white,
                        textSize: textSize,
                        fontWeight: fontWeight ?? FontWeight.w600,
                      ),
                      suffix ?? Container(),
                    ],
                  ),
          ),
        ));
  }
}

class AppTextButton extends StatelessWidget {
  final String text;
  void Function()? onTap;
  AppTextButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 1.vw),
        ),
        onPressed: onTap,
        child: AppText(
          text,
          textColor: AppColors.primary,
          fontWeight: FontWeight.w700,
          textSize: 16.sp,
        ));
  }
}
