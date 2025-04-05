import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:resize/resize.dart';

class LoaderWidget extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  const LoaderWidget({super.key, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: SizedBox(
          height: 50.h,
          child: const LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            colors: [AppColors.primary],
          ),
        ),
      ),
    );
  }
}
