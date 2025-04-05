import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/account_suspended_widget.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/core/widgets/loading_widget.dart';
import 'package:myenglish/features/breakout_room/presentation/widgets/join_room_button.dart';
import 'package:resize/resize.dart';

import '../../../../di/di.dart';

class BreakoutIntroScreen extends ConsumerStatefulWidget {
  const BreakoutIntroScreen({super.key});

  @override
  ConsumerState<BreakoutIntroScreen> createState() =>
      _BreakoutIntroScreenState();
}

class _BreakoutIntroScreenState extends ConsumerState<BreakoutIntroScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ref.read(breakoutRoomProvider).breakoutRoomData = null;
    print(
        '212121 paid ${!checkNullOrEmptyString(Prefs().getString(Prefs.courseLevel))}');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.read(breakoutRoomProvider).getDashboard();
    });
    // ref.read(breakoutRoomProvider).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var mBreakoutRoomProvider = ref.read(breakoutRoomProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Stack(
            children: [
              mBreakoutRoomProvider.accountSuspended
                  ? AccountSuspendedWidget()
                  : (mBreakoutRoomProvider.dashboardData != null &&
                          mBreakoutRoomProvider.dashboardData!.paid == 0)
                      ? const Center(
                          child: AppText(
                              'Make Payment to access the breakout room'),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              AppStrings.welcomeToBreakoutRoom,
                              textSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            vHeight(24.h),
                            Image.asset(
                              AppImages.breakoutWelcomeIllustratoin,
                              height: 240.h,
                            ),
                            vHeight(30.h),
                            AppText(
                              AppStrings.whatweDo,
                              textSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            vHeight(6.h),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text:
                                      'We help you to communicate better by having a conversation with ',
                                  style: TextStyle(
                                      color: AppColors.grey65,
                                      fontSize: 13.sp,
                                      height: 1.5),
                                  children: const [
                                    TextSpan(
                                      text: '2 of your peers.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ]),
                            ),
                            vHeight(9.h),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text:
                                      'You’ll be given a topic with which you  can communicate in English',
                                  style: TextStyle(
                                      color: AppColors.grey65,
                                      fontSize: 13.sp,
                                      height: 1.5),
                                  children: const [
                                    // TextSpan(
                                    //   text: '15 min',
                                    //   style: TextStyle(fontWeight: FontWeight.w700),
                                    // ),
                                  ]),
                            ),
                            vHeight(20.h),
                            const JoinBreakoutRoomButton(
                              text: AppStrings.letsDoThis,
                            ),
                            vHeight(20.h),
                            if (mBreakoutRoomProvider.bRoomEnabledModel != null)
                              AppText(
                                  'Breakout room will be available from ${mBreakoutRoomProvider.bRoomEnabledModel!.fromTime!} to ${mBreakoutRoomProvider.bRoomEnabledModel!.toTime!}'),
                            SizedBox(
                              height: 8.vw,
                            ),
                            if (mBreakoutRoomProvider.breakoutRoomData != null)
                              InkWell(
                                onTap: () {
                                  mBreakoutRoomProvider.getRoomUsers();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AppText(
                                          'Report user from ${mBreakoutRoomProvider.breakoutRoomData!.topic!}'),
                                      SizedBox(
                                        width: 2.vw,
                                      ),
                                      const Icon(
                                        Icons.report,
                                        color: AppColors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
              if (mBreakoutRoomProvider.isLoading) const LoaderWidget()
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
