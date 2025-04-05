import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/widgets/account_suspended_widget.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/appbar.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/resources/presentation/provider/resources_provider.dart';
import 'package:myenglish/features/resources/presentation/screens/document_resource_tab.dart';
import 'package:myenglish/features/resources/presentation/screens/video_resource_tab.dart';
import 'package:resize/resize.dart';

class ResourcesScreen extends ConsumerStatefulWidget {
  const ResourcesScreen({super.key});

  @override
  ConsumerState<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends ConsumerState<ResourcesScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      ref.read(resourcesProvider).setState();
    });
    if (ref.read(resourcesProvider).paid ||
        ref.read(resourcesProvider).tutorVerified) {
      // ref.read(resourcesProvider).getDashboard();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var mResourceProvider = ref.watch(resourcesProvider);
    return Scaffold(
      body: SafeArea(
        child: mResourceProvider.accountSuspended
            ? AccountSuspendedWidget()
            : Column(
                children: [
                  if (getAppUser == AppUser.tutor)
                    const CustomAppBar(title: 'Course Resources'),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: !(mResourceProvider.paid ||
                              mResourceProvider.tutorVerified)
                          ? const Center(
                              child: AppText(
                                  'Enroll in a course to access resources'),
                            )
                          : Column(
                              children: [
                                vHeight(30.h),
                                Container(
                                  height: 70.h,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 25.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.resourceTabBarBg,
                                  ),
                                  child: TabBar(
                                    controller: tabController,
                                    tabs: [
                                      Tab(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AnimatedCrossFade(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              crossFadeState:
                                                  tabController.index == 0
                                                      ? CrossFadeState.showFirst
                                                      : CrossFadeState
                                                          .showSecond,
                                              firstChild: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(AppImages.videos),
                                                  width(8.w),
                                                ],
                                              ),
                                              secondChild: Container(),
                                            ),
                                            const AppText(AppStrings.videos)
                                          ],
                                        ),
                                      ),
                                      Tab(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AnimatedCrossFade(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              crossFadeState:
                                                  tabController.index == 1
                                                      ? CrossFadeState.showFirst
                                                      : CrossFadeState
                                                          .showSecond,
                                              firstChild: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                      AppImages.documentTab),
                                                  width(8.w),
                                                ],
                                              ),
                                              secondChild: Container(),
                                            ),
                                            const AppText(AppStrings.resources)
                                          ],
                                        ),
                                      ),
                                    ],
                                    indicatorPadding: const EdgeInsets.all(10),
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                vHeight(25.h),
                                Row(
                                  children: [
                                    // if (getAppUser == AppUser.tutor)
                                    // filterCourseLevelWidget(mResourceProvider),
                                    // if (getAppUser == AppUser.tutor) const Spacer(),
                                    if (tabController.index == 0)
                                      Row(
                                          children: ResourceFilter.values
                                              .map(
                                                (e) => InkWell(
                                                    onTap: () => mResourceProvider
                                                        .updateLanguageFilter(
                                                            e),
                                                    child: Container(
                                                        margin: const EdgeInsets.symmetric(
                                                            horizontal: 3.5),
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: 5.h,
                                                            horizontal: 13.w),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    16),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: e == mResourceProvider.languageFilter
                                                                    ? AppColors.bottomNavIndicator
                                                                    : AppColors.greyC3)),
                                                        child: AppText(e.name, textSize: 13.sp, textColor: e == mResourceProvider.languageFilter ? AppColors.bottomNavIndicator : AppColors.black))),
                                              )
                                              .toList()),
                                  ],
                                ),
                                vHeight(15.h),
                                Expanded(
                                  child: TabBarView(
                                      controller: tabController,
                                      children: const [
                                        VideoResourceTab(),
                                        DocumentResourceTab(),
                                      ]),
                                ),
                                if (mResourceProvider.paginationLoading)
                                  const SizedBox(
                                      height: 20,
                                      child: Center(
                                          child: CircularProgressIndicator()))
                              ],
                            ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget filterCourseLevelWidget(ResourcesProvider mResourceProvider) {
    return Row(
      children: [
        AppText(
          'Course:',
          textColor: AppColors.grey79,
          textSize: 12.sp,
        ),
        PopupMenuButton(
          position: PopupMenuPosition.under,
          constraints: BoxConstraints(maxWidth: 50.vw),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                toTitleCase(mResourceProvider.courseLevel.name),
                textSize: 13.sp,
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: AppColors.black,
                size: 18,
              )
            ],
          ),
          itemBuilder: (c) => ['Student', 'Professional']
              .map((e) => PopupMenuItem<String>(
                    value: e.toString(),
                    onTap: () => mResourceProvider.updateCourseLevel(e),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(toTitleCase(e)),
                        if (toTitleCase(mResourceProvider.courseLevel.name) ==
                            e)
                          const Icon(
                            Icons.done,
                            color: AppColors.bottomNavIndicator,
                          )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => false;
}
