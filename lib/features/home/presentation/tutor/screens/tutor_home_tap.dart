import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/widgets/will_pop.dart';
import 'package:myenglish/features/home/presentation/tutor/screens/tutor_home_screen.dart';
import 'package:resize/resize.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../course_syllabus/presentation/screen/tutor_course_syllabus_screen.dart';
import '../../../../course_syllabus/presentation/screen/tutor_syllabus_list.dart';

class TutorHomeTab extends ConsumerStatefulWidget {
  const TutorHomeTab({super.key});

  @override
  ConsumerState<TutorHomeTab> createState() => _TutorHomeTabState();
}

class _TutorHomeTabState extends ConsumerState<TutorHomeTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              TutorHomeScreen(),
              TutorCourseListScreen(),
              TutorCourseSyllabus()
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 90.h,
          width: 100.w,
          color: AppColors.white,
          child: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                icon: ImageIcon(
                  const AssetImage(
                    AppImages.home,
                  ),
                  size: 25.h,
                ),
                iconMargin: EdgeInsets.only(bottom: 5.h),
                text: AppStrings.home,
              ),
              Tab(
                icon: ImageIcon(
                  const AssetImage(
                    AppImages.videos,
                  ),
                  size: 25.h,
                ),
                iconMargin: EdgeInsets.only(bottom: 5.h),
                text: AppStrings.myClasses,
              ),
              Tab(
                icon: ImageIcon(
                  const AssetImage(AppImages.resources),
                  size: 25.h,
                ),
                iconMargin: EdgeInsets.only(bottom: 5.h),
                text: AppStrings.eEnrollToTeach,
              )
            ],
            onTap: (index) {},
            isScrollable: false,
          ),
        ),
      ),
    );
  }
}
