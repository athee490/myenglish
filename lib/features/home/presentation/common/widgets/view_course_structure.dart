import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:resize/resize.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../di/di.dart';

class ViewModules extends ConsumerWidget {
  const ViewModules({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        await Navigator.pushNamed(context, AppRoutes.syllabus).then((value) {
          if (getAppUser == AppUser.student) {
            ref.read(studentProfileProvider).getProfile();
            // ref.read(studentHomeProvider).getDashboard();
          } else {
            // ref.read(tutorHomeProvider).getDashboard();
            ref.read(tutorHomeProvider).getAttendanceLog();
          }
        });
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: [
              Container(
                height: 78.h,
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                decoration: BoxDecoration(
                  color: AppColors.profileAvatarBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(children: [
                  const AppText(
                    AppStrings.viewModules,
                    fontWeight: FontWeight.w600,
                  ),
                  Icon(Icons.arrow_forward_ios,
                      color: AppColors.greyC3, size: 15.h),
                  const Spacer(),
                ]),
              ),
              vHeight(10.h),
            ],
          ),
          Positioned(
              right: 18.w,
              // bottom: -10,
              child: Image.asset(AppImages.bookShelf))
        ],
      ),
    );
  }
}
