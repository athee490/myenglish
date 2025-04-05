import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:resize/resize.dart';

import '../../../../../core/constants/app_images.dart';

class TutorUnverifiedWidget extends StatelessWidget {
  const TutorUnverifiedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          vHeight(113.h),
          Image.asset(AppImages.timer),
          AppText(
            AppStrings.profileSubmittedSucessfully,
            textSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          AppText(
            AppStrings.pleaseWaitTillVerification,
            textSize: 12.sp,
            textColor: AppColors.greyB1,
          ),
        ],
      ),
    );
  }
}
