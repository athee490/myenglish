import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/dialog.dart';
import 'package:myenglish/main.dart';
import 'package:resize/resize.dart';

class ReportSubmittedDialog extends CustomDialog {
  ReportSubmittedDialog();

  @override
  Widget getChild() {
    return Consumer(builder: (context, ref, _) {
      return Container(
        // width: 90.vw,
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.reportSubmitted,
              height: 116.h,
            ),
            AppText(
              AppStrings.reportSubmitted,
              fontWeight: FontWeight.w700,
              textSize: 16.sp,
            ),
            AppText(
              AppStrings.reportSubmittedDesc,
              textSize: 12.sp,
              textAlign: TextAlign.center,
              lineHeight: 1.5,
            ),
            vHeight(30.h),
            PrimaryAppButton(
              title: 'CLOSE',
              onTap: () {
                Navigator.pop(context);
                // ref.read(breakoutRoomProvider).leave();
              },
            ),
            vHeight(5.h),
          ],
        ),
      );
    });
  }

  @override
  void show() {
    super.showDialog(navigatorKey.currentContext!);
  }
}
