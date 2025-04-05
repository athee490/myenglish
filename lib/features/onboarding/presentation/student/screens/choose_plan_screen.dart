import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/checkbox.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/onboarding/presentation/common/widgets/auth_scaffold.dart';
import 'package:myenglish/features/onboarding/presentation/student/providers/choose_plan_provider.dart';
import 'package:myenglish/features/onboarding/presentation/student/widgets/plan_card.dart';
import 'package:resize/resize.dart';

class ChoosePlanScreen extends ConsumerStatefulWidget {
  final bool? extend;

  const ChoosePlanScreen({super.key, this.extend = false});

  @override
  ConsumerState<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends ConsumerState<ChoosePlanScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(choosePlanProvider).extend = widget.extend ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var mProvider = ref.watch(choosePlanProvider);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AuthScaffold(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    vHeight(46.h),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              AppStrings.chooseYourPlan,
                              fontWeight: FontWeight.w700,
                              textSize: 20.sp,
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            onPressed: () => mProvider.skip(),
                            icon: Icon(
                              Icons.close,
                              color: AppColors.greyC3,
                              size: 22.5.h,
                            ),
                          ),
                        )
                      ],
                    ),
                    vHeight(5.h),
                    AppText(
                      AppStrings.forQueriesContactUs,
                      textSize: 12.sp,
                    ),
                    vHeight(50.h),
                    Container(
                      padding: EdgeInsets.all(8.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.primary)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedAlign(
                            alignment:
                                mProvider.selectedPlanTab == Plans.fortyMins
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.elasticOut,
                            child: Container(
                              height: 54.h,
                              width: 40.vw,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.primary),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      mProvider.togglePlansTab(Plans.fortyMins),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15.h,
                                    ),
                                    child: AppText(
                                      '40 mins/day',
                                      textColor: mProvider.selectedPlanTab ==
                                              Plans.fortyMins
                                          ? AppColors.white
                                          : AppColors.grey79,
                                      fontWeight: mProvider.selectedPlanTab ==
                                              Plans.fortyMins
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      mProvider.togglePlansTab(Plans.sixtyMins),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 0.h),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AnimatedCrossFade(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          crossFadeState:
                                              mProvider.selectedPlanTab ==
                                                      Plans.fortyMins
                                                  ? CrossFadeState.showFirst
                                                  : CrossFadeState.showSecond,
                                          secondChild: Container(),
                                          firstChild: FittedBox(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 2),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w,
                                                  vertical: 2.h),
                                              decoration: BoxDecoration(
                                                  color: AppColors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(AppImages.crown),
                                                  width(5.w),
                                                  AppText(
                                                    AppStrings.recommended,
                                                    textSize: 10.sp,
                                                    textColor: AppColors.white,
                                                    fontWeight: FontWeight.w700,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        AppText(
                                          '60 mins/day',
                                          textColor:
                                              mProvider.selectedPlanTab ==
                                                      Plans.sixtyMins
                                                  ? AppColors.white
                                                  : AppColors.grey79,
                                          fontWeight:
                                              mProvider.selectedPlanTab ==
                                                      Plans.sixtyMins
                                                  ? FontWeight.w700
                                                  : FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              vHeight(22.h),
              AnimatedCrossFade(
                firstChild: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  shrinkWrap: true,
                  itemCount: mProvider.basicPlan.length,
                  itemBuilder: (context, index) {
                    return PlanCard(
                      plan: mProvider.basicPlan[index],
                      color: index % 2 == 0
                          ? AppColors.choosePlanBlue
                          : AppColors.choosePlanYellow,
                    );
                  },
                  separatorBuilder: (context, index) => vHeight(21.h),
                ),
                secondChild: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  shrinkWrap: true,
                  itemCount: mProvider.extendedPlan.length,
                  itemBuilder: (context, index) {
                    return PlanCard(
                      plan: mProvider.extendedPlan[index],
                      color: index % 2 == 0
                          ? AppColors.choosePlanBlue
                          : AppColors.choosePlanYellow,
                    );
                  },
                  separatorBuilder: (context, index) => vHeight(21.h),
                ),
                crossFadeState: mProvider.selectedPlanTab == Plans.fortyMins
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 500),
                sizeCurve: Curves.elasticOut,
              ),
              vHeight(26.h),
              if (mProvider.selectedPlan != null) summarySection(),
              vHeight(60.h),
              // const Spacer(),
              _termsAndConditions(mProvider),
              vHeight(10.h),
              PrimaryAppButton(
                title: AppStrings.cont,
                onTap: mProvider.accept && mProvider.selectedPlan != null
                    ? () => mProvider.submit()
                    : null,
              ),
              vHeight(40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget summarySection() {
    return Consumer(builder: (context, ref, _) {
      var mProvider = ref.watch(choosePlanProvider);
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                AppStrings.planSummary,
                textSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            vHeight(18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  'Original Monthly Price (x${mProvider.selectedPlan?.months ?? 1})',
                  textSize: 13.sp,
                  textColor: AppColors.grey65,
                ),
                AppText(
                  '${AppStrings.rupee} ${formatter.format(mProvider.selectedPlan!.monthlyPrice)}',
                  textSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            vHeight(5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  '${mProvider.selectedPlan?.planDuration} subscription',
                  textSize: 13.sp,
                  textColor: AppColors.grey65,
                ),
                AppText(
                  ' ${mProvider.selectedPlan!.percentageOff.toInt()}% off',
                  textSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.green,
                ),
                const Spacer(),
                AppText(
                  '- ${AppStrings.rupee} ${formatter.format(mProvider.selectedPlan!.amountDiscounted)}',
                  textSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.green,
                ),
              ],
            ),
            vHeight(12.h),
            horizontalSeparatorWidget(),
            vHeight(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  'Total Charges',
                  textSize: 13.sp,
                  textColor: AppColors.grey65,
                ),
                AppText(
                  '${AppStrings.rupee} ${formatter.format(mProvider.selectedPlan!.totalPrice)}',
                  textSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Row _termsAndConditions(ChoosePlanProvider mProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppCheckBox(
          value: mProvider.accept,
          onChanged: (s) => mProvider.toggleAcceptButton(),
        ),
        AppText(
          AppStrings.iAcceptThe,
          textSize: 12.sp,
        ),
        width(6.w),
        AppText(
          AppStrings.termsAndCnditions,
          textDecoration: TextDecoration.underline,
          textSize: 12.sp,
        )
      ],
    );
  }
}
