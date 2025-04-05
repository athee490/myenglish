import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/dialog.dart';
import 'package:myenglish/main.dart';
import 'package:resize/resize.dart';

class SaveChangesDialog extends CustomDialog {
  final void Function()? onTap;
  SaveChangesDialog(this.onTap);

  @override
  Widget getChild() {
    return Container(
      width: 90.vw,
      padding: EdgeInsets.all(35.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.noteRemove,
            height: 60.h,
          ),
          vHeight(10.h),
          AppText(
            AppStrings.doYouWantToSaveChanges,
            fontWeight: FontWeight.w700,
            textSize: 16.sp,
          ),
          vHeight(30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(navigatorKey.currentContext!, true);
                  Navigator.pop(navigatorKey.currentContext!);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    AppStrings.noDontSave,
                    textSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              PrimaryAppButton(
                title: AppStrings.yesSaveChanges,
                onTap: () {
                  onTap?.call();
                  Navigator.pop(navigatorKey.currentContext!);
                },
                fontWeight: FontWeight.w600,
                textSize: 10.sp,
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void show() {
    super.showDialog(navigatorKey.currentContext!);
  }
}
