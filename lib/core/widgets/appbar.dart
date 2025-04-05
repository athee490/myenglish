import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:resize/resize.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final void Function()? willPop;
  const CustomAppBar({
    Key? key,
    this.willPop,
    required this.title,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showBackButton)
            InkWell(
              onTap: willPop ?? () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
              ),
            ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: IconButton(
          //     padding: const EdgeInsets.fromLTRB(0, 10, 8, 8),
          //     onPressed: willPop ?? () => Navigator.pop(context),
          //     icon: const Icon(
          //       Icons.arrow_back_ios,
          //       color: AppColors.black,
          //     ),
          //   ),
          // ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: AppText(
                title,
                textSize: 20.sp,
                fontWeight: FontWeight.w700,
                textColor: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
