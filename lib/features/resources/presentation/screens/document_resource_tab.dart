import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/di/di.dart';
import 'package:resize/resize.dart';

class DocumentResourceTab extends ConsumerWidget {
  const DocumentResourceTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var mProvider = ref.watch(resourcesProvider);
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
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h),
            child: mProvider.documentList.isEmpty
                ? const Center(child: AppText('No data found'))
                : ListView.separated(
                    controller: mProvider.documentScrollController,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: mProvider.documentList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          String url = mProvider.documentList[index].file ?? '';
                          String title =
                              mProvider.documentList[index].title ?? '';
                          if (checkNullOrEmptyString(url)) return;
                          print(url);
                          Navigator.pushNamed(context, AppRoutes.pdfView,
                              arguments: {'title': title, 'url': url});
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            children: [
                              Image.asset(AppImages.document),
                              width(16.5.w),
                              Expanded(
                                  child: AppText(
                                '${mProvider.documentList[index].title}',
                                textAlign: TextAlign.left,
                                fontWeight: FontWeight.w600,
                              ))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (c, i) => horizontalSeparatorWidget(),
                  ),
          );
  }
}
