import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/di/di.dart';
import 'package:resize/resize.dart';
import 'package:video_player/video_player.dart';

class VideoResourceTab extends ConsumerWidget {
  const VideoResourceTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var mProvider = ref.watch(resourcesProvider);
    print(mProvider.videoList.length);
    return mProvider.isLoading
        ? Center(
            child: Padding(
              padding: EdgeInsets.only(top: 0.vh),
              child: SizedBox(
                height: 50.h,
                child: const LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader),
              ),
            ),
          )
        : mProvider.videoList.isEmpty
            ? const Center(child: AppText('No data found'))
            : ListView.separated(
                controller: mProvider.videoScrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 0.h),
                shrinkWrap: true,
                itemCount: mProvider.videoList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.greyB1),
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.white,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 165.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.greyB1,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                      onTap: () {
                                        // mProvider
                                        //     .playPause(mProvider.videoList[index]);
                                      },
                                      child: VideoPlayer(mProvider
                                          .videoList[index]
                                          .videoPlayerController!))),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 18.h, horizontal: 12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    timeAgoSinceDate(
                                        mProvider.videoList[index].createdAt ??
                                            DateTime.now()),
                                    textSize: 12.sp,
                                    textColor: AppColors.grey79,
                                  ),
                                  vHeight(2.h),
                                  AppText(
                                    '${mProvider.videoList[index].title}',
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.left,
                                    lineHeight: 1.2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: (165 - 17.5).h,
                          right: 12.5.w,
                          child: InkWell(
                            onTap: () => mProvider.redirectVideo(
                                mProvider.videoList[index].file ?? ''),
                            child: Image.asset(
                              AppImages.playVideo,
                              height: 35.h,
                              width: 35.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (c, i) => vHeight(20.h),
              );
  }
}
