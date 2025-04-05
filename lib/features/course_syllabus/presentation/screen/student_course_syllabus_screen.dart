import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/textfield.dart';
import 'package:myenglish/main.dart';
import 'package:resize/resize.dart';
import '../../../../core/config/app_routes.dart';
import '../../../../core/config/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/appbar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../di/di.dart';
import '../provider/student_course_syllabus_provider.dart';

class CourseScreen extends ConsumerStatefulWidget {
  const CourseScreen({super.key});

  @override
  ConsumerState<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends ConsumerState<CourseScreen> {
  late StudentCourseSyllabusProvider mStudentCourseSyllabusProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mStudentCourseSyllabusProvider = ref.read(studentCourseSyllabusProvider);
      mStudentCourseSyllabusProvider.getAllCourseList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mStudentCourseSyllabusProvider = ref.watch(studentCourseSyllabusProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: 'Course',
              showBackButton: false,
            ),
            Expanded(
              child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: SearchTextField(
                                    hint: 'Search',
                                    controller: mStudentCourseSyllabusProvider
                                        .searchCourseController,
                                    onChanged: (value) {
                                      setState(() {
                                        mStudentCourseSyllabusProvider.search =
                                            value.toString();
                                        if (mStudentCourseSyllabusProvider
                                            .search.isEmpty) {
                                          mStudentCourseSyllabusProvider
                                              .getAllCourseList();
                                        } else {
                                          mStudentCourseSyllabusProvider
                                              .searchCourseKey();
                                        }
                                      });
                                    },
                                    prefixIcon:
                                        const Icon(Icons.search_rounded),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 5.w),
                                  )),
                              SizedBox(
                                width: 7.w,
                              ),
                              Expanded(
                                flex: 2,
                                child: CustomDropdown(
                                  isFullScreen: false,
                                  showSuffixIcon: true,
                                  suffixIcon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFF777474),
                                  ),
                                  items: mStudentCourseSyllabusProvider
                                      .listOfGrades,
                                  onGradeChanged: (selectedGrade) {
                                    setState(() {
                                      print(
                                          '212121 Selected Grade from UI : $selectedGrade Grade');
                                      mStudentCourseSyllabusProvider
                                              .selectedGrade =
                                          selectedGrade.toString();
                                      if (mStudentCourseSyllabusProvider
                                          .selectedGrade.isEmpty) {
                                        mStudentCourseSyllabusProvider
                                            .getAllCourseList();
                                      } else {
                                        // mStudentCourseSyllabusProvider.searchGradeCourseKey();
                                        mStudentCourseSyllabusProvider
                                            .searchCourseKey();
                                      }
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          vHeight(5.h),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: ref
                                  .read(studentCourseSyllabusProvider)
                                  .courseListScrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  vHeight(5.h),
                                  horizontalSeparatorWidget(),
                                  vHeight(10.h),
                                  AppText(
                                    'List of Course',
                                    fontWeight: FontWeight.w700,
                                    textSize: 17.sp,
                                  ),
                                  vHeight(10.h),
                                  ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: mStudentCourseSyllabusProvider
                                        .courseDetails.length,
                                    itemBuilder: (c, index) {
                                      var data = mStudentCourseSyllabusProvider
                                          .courseDetails[index];
                                      return Container(
                                        padding: EdgeInsets.all(16.w),
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: AppTheme.boxShadow1),
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              mStudentCourseSyllabusProvider
                                                      .selectedCourseId =
                                                  data.id.toString();
                                            });
                                            mStudentCourseSyllabusProvider
                                                .getSingleCourse();
                                            // mStudentCourseSyllabusProvider.generateThumbnail();
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              AppText(
                                                                '${data.title}',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              AppText(
                                                                '${data.keyword}',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                textSize: 11.sp,
                                                                textColor:
                                                                    AppColors
                                                                        .grey79,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          navigatorKey
                                                              .currentContext!,
                                                          AppRoutes
                                                              .payPalScreen);
                                                      // Navigator.pushNamed(
                                                      //     context,
                                                      //     AppRoutes
                                                      //         .studentCourseDetail);
                                                      // setState(() {
                                                      //   mStudentCourseSyllabusProvider
                                                      //       .selectedCourseId =
                                                      //       data.id.toString();
                                                      // });
                                                      //  mStudentCourseSyllabusProvider.getSingleCourse();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      elevation: 0,
                                                      backgroundColor:
                                                          AppColors.primary,
                                                      disabledBackgroundColor:
                                                          AppColors
                                                              .disabledButton,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        AppText(
                                                          'Buy Now',
                                                          textColor:
                                                              AppColors.white,
                                                          textSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              vHeight(2.5.h),
                                              horizontalSeparatorWidget(),
                                              vHeight(10.h),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      AppText(
                                                        'From ${data.startDate} to ${data.endDate}',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        textSize: 12.sp,
                                                        textColor:
                                                            AppColors.grey79,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              vHeight(5.h),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    AppText(
                                                      '3/5',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textSize: 14.sp,
                                                      textColor:
                                                          AppColors.grey79,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    width(5.w),
                                                    for (int i = 0; i < 5; i++)
                                                      (i <= 2)
                                                          ? Image.asset(
                                                              'assets/images/rating_filled.png',
                                                              height: 13,
                                                            )
                                                          : Image.asset(
                                                              'assets/images/rating_unfilled.png',
                                                              height: 13,
                                                            ),
                                                  ],
                                                ),
                                              ),
                                              vHeight(5.h),
                                              Column(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AppText(
                                                        'Description',
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        textSize: 13.sp,
                                                        textColor:
                                                            AppColors.black,
                                                      ),
                                                      vHeight(0.5.h),
                                                      AppText(
                                                        '${data.longDescription}',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        textSize: 10.sp,
                                                        textColor:
                                                            AppColors.grey79,
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (c, i) => vHeight(12.h),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: mStudentCourseSyllabusProvider
                                .paginationLoading,
                            child: CircularProgressIndicator(),
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
