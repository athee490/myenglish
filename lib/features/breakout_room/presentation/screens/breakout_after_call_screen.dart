import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/features/breakout_room/presentation/widgets/join_room_button.dart';
import 'package:resize/resize.dart';

class BreakoutAfterCallScreen extends ConsumerWidget {
  const BreakoutAfterCallScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              AppStrings.wayToGo,
              textSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
            vHeight(24.h),
            Image.asset(
              AppImages.breakoutIllustration,
              height: 240.h,
            ),
            vHeight(30.h),
            AppText(
              AppStrings.whatweDo,
              textSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
            vHeight(6.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text:
                      'We help you to communicate better by having a conversation with ',
                  style: TextStyle(
                      color: AppColors.grey65, fontSize: 13.sp, height: 1.5),
                  children: const [
                    TextSpan(
                      text: '2 of your peers.',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ]),
            ),
            vHeight(9.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text:
                      'You’ll be given a topic with which you  can communicate in English for ',
                  style: TextStyle(
                      color: AppColors.grey65, fontSize: 13.sp, height: 1.5),
                  children: const [
                    // TextSpan(
                    //   text: '15 min',
                    //   style: TextStyle(fontWeight: FontWeight.w700),
                    // ),
                  ]),
            ),
            vHeight(20.h),
            const JoinBreakoutRoomButton(
              text: AppStrings.letsRockAgain,
            ),
            // vHeight(50.h),
            // AppText(
            //   AppStrings.breakoutRoomDisclamier,
            //   textSize: 13.sp,
            // ),
          ],
        ),
      ),
    );
  }
}
