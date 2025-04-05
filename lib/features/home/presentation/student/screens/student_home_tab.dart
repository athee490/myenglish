import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/widgets/will_pop.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/home/presentation/student/screens/student_home_screen.dart';
import 'package:resize/resize.dart';

import '../../../../course_syllabus/presentation/screen/student_course_syllabus_screen.dart';
import '../../../../resources/presentation/screens/syllabus_screen.dart';

class StudentHomeTab extends ConsumerStatefulWidget {
  const StudentHomeTab({super.key});

  @override
  ConsumerState<StudentHomeTab> createState() => _StudentHomeTabState();
}

class _StudentHomeTabState extends ConsumerState<StudentHomeTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mBreakoutRoomProvider = ref.watch(breakoutRoomProvider);
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              StudentHomeScreen(),
              CourseScreen(),
              // mBreakoutRoomProvider.status == BreakoutStatus.beforeCall
              //     ? BreakoutIntroScreen()
              //     : BreakoutAfterCallScreen(),
              SyllabusScreen(),
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
                text: 'Course',
              ),
              Tab(
                icon: ImageIcon(
                  const AssetImage(
                    AppImages.resources,
                  ),
                  size: 25.h,
                ),
                iconMargin: EdgeInsets.only(bottom: 5.h),
                text: AppStrings.modules,
              ),
            ],
            onTap: (index) {},
            isScrollable: false,
          ),
        ),
      ),
    );
  }
}
