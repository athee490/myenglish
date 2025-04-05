import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/appbar.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/loading_widget.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/resources/presentation/provider/syllabus_provider.dart';
import 'package:resize/resize.dart';

import '../../../../core/widgets/account_suspended_widget.dart';

class SyllabusScreen extends ConsumerStatefulWidget {
  const SyllabusScreen({super.key});

  @override
  ConsumerState<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends ConsumerState<SyllabusScreen> {
  @override
  void initState() {
    super.initState();
    if (getAppUser == AppUser.student) {
      ref.read(syllabusProvider).courseLevel =
          (Prefs().getInt(Prefs.courseId) == 0
              ? CourseLevel.all
              : Prefs().getInt(Prefs.courseId) == 1
                  ? CourseLevel.student
                  : CourseLevel.professional);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (getAppUser == AppUser.student) {
        // ref.read(syllabusProvider).getDashboard();
      } else {
        ref.read(syllabusProvider).getSyllabus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mProvider = ref.watch(syllabusProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Course Syllabus',
              showBackButton: (getAppUser == AppUser.student ? false : true),
            ),
            mProvider.accountSuspended
                ? Expanded(
                    child: AccountSuspendedWidget(),
                  )
                : (mProvider.dashboardData != null &&
                        mProvider.dashboardData!.paid == 0)
                    ? const Expanded(
                        child: Center(
                          child: AppText('Make Payment to access the modules'),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            if (getAppUser == AppUser.tutor)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.filter_list,
                                      // size: 30,
                                    ),
                                    width(10.w),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            _filter(mProvider, CourseLevel.all),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            _filter(
                                                mProvider, CourseLevel.student),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            _filter(mProvider,
                                                CourseLevel.professional),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Expanded(
                              child: mProvider.isLoading
                                  ? const LoaderWidget()
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 25.h, horizontal: 24.w),
                                      child: ListView.separated(
                                        // controller: mProvider.documentScrollController,
                                        shrinkWrap: true,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount:
                                            mProvider.documentList.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              String url = mProvider
                                                      .documentList[index]
                                                      .syllabus ??
                                                  '';
                                              String title = mProvider
                                                      .documentList[index]
                                                      .name ??
                                                  '';
                                              if (checkNullOrEmptyString(url)) {
                                                return;
                                              }
                                              print(url);
                                              Navigator.pushNamed(
                                                  context, AppRoutes.pdfView,
                                                  arguments: {
                                                    'title': title,
                                                    'url': url
                                                  });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.h),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      AppImages.document),
                                                  width(16.5.w),
                                                  Expanded(
                                                      child: AppText(
                                                    '${mProvider.documentList[index].name}',
                                                    textAlign: TextAlign.left,
                                                    fontWeight: FontWeight.w600,
                                                  ))
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (c, i) =>
                                            horizontalSeparatorWidget(),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  InkWell _filter(SyllabusProvider mProvider, CourseLevel value) {
    return InkWell(
      onTap: () => mProvider.updateFilter(value),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
        decoration: BoxDecoration(
            color: mProvider.courseLevel == value
                ? AppColors.red
                : AppColors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: AppColors.red)),
        child: Center(
          child: AppText(
            value.name,
            textColor: mProvider.courseLevel == value
                ? AppColors.white
                : AppColors.red,
            fontWeight: FontWeight.w600,
            textSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
