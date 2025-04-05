import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/di/di.dart';
import 'package:resize/resize.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var mStudentHomeProvider = ref.watch(studentHomeProvider);
    var mTutorHomeProvider = ref.watch(tutorHomeProvider);
    bool loading = getAppUser == AppUser.student
        ? mStudentHomeProvider.loading
        : mTutorHomeProvider.loading;
    return Row(
      children: [
        Image.asset(
          AppImages.logo,
          height: 70.h,
        ),
        const Spacer(),
        InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.helpAndSupport),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.greyC3,
                )),
            child: Image.asset(AppImages.helpSupport),
          ),
        ),
        width(18.w),
        // if (!loading)
        InkWell(
          onTap: () => getAppUser == AppUser.tutor
              ? mTutorHomeProvider.toProfile()
              : mStudentHomeProvider.toProfile(),
          child:
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
                color: AppColors.profileAvatarBg,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                )),
            child: Center(
              child: !checkNullOrEmptyString(
                      Prefs().getString(Prefs.profilePicture))
                  ? CircleAvatar(
                      backgroundImage: MemoryImage(base64Decode(
                          '${Prefs().getString(Prefs.profilePicture)}')),
                    )
                  : AppText(
                      '${Prefs().getString(Prefs.name)} '
                          .substring(0, 1)
                          .toUpperCase(),
                      textColor: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      textSize: 21.sp,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
