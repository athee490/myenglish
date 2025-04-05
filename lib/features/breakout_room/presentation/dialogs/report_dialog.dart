import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/dialog.dart';
import 'package:myenglish/core/widgets/textfield.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/main.dart';
import 'package:resize/resize.dart';

import '../../../../core/constants/app_colors.dart';

class ReportDialog extends CustomDialog {
  ReportDialog();

  @override
  Widget getChild() {
    return Consumer(builder: (context, ref, _) {
      var mBreakoutProvider = ref.watch(breakoutRoomProvider);
      return Container(
        // width: 90.vw,
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    AppStrings.report,
                    fontWeight: FontWeight.w700,
                    textSize: 16.sp,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: AppColors.greyC3,
                  ),
                )
              ],
            ),
            vHeight(4.vw),
            AppText(
              AppStrings.reportDesc,
              textSize: 12.sp,
              textAlign: TextAlign.center,
              lineHeight: 1.5,
            ),
            vHeight(30.h),
            const Align(
                alignment: Alignment.centerLeft,
                child: AppText(AppStrings.selectUsers)),
            vHeight(10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: mBreakoutProvider.roomUsers
                  .map(
                    (e) => InkWell(
                      onTap: () =>
                          mBreakoutProvider.updateReportId(e.userId.toString()),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 30,
                            child: Radio(
                              value: e.userId.toString(),
                              groupValue: mBreakoutProvider.reportId,
                              onChanged: (s) =>
                                  mBreakoutProvider.updateReportId(s!),
                            ),
                          ),
                          AppText(e.studentName.toString(), textSize: 12.sp),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            vHeight(10.h),
            PrimaryTextField(
              label: AppStrings.description,
              controller: mBreakoutProvider.reportDesc,
              maxLines: 4,
              maxLength: 250,
            ),
            vHeight(30.h),
            PrimaryAppButton(
              title: AppStrings.submitReport.toUpperCase(),
              onTap: () {
                mBreakoutProvider.reportUser();
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
