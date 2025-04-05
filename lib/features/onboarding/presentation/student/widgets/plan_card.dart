import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/onboarding/presentation/student/models/payment_plan_ui_model.dart';
import 'package:resize/resize.dart';

class PlanCard extends ConsumerWidget {
  final Plan plan;
  final Color color;
  const PlanCard({
    Key? key,
    required this.plan,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var mProvider = ref.watch(choosePlanProvider);
    return InkWell(
      onTap: () => mProvider.choosePlan(plan),
      child: Container(
        height: 98.h,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
                width: 0.8,
                color: mProvider.selectedPlan == plan
                    ? AppColors.green
                    : AppColors.greyC3),
            borderRadius: BorderRadius.circular(15),
            boxShadow: mProvider.selectedPlan == plan
                ? const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 13,
                      spreadRadius: 2,
                      color: AppColors.boxShadow,
                    ),
                  ]
                : null),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      plan.planDuration,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    if (plan.percentageOff > 0)
                      Container(
                        margin: EdgeInsets.only(top: 1.h),
                        color: AppColors.discount,
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 4.w),
                        child: AppText(
                          '${formatter.format(plan.percentageOff)}% OFF',
                          textSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          textColor: AppColors.green,
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(
                        '${AppStrings.rupee} ${formatter.format(plan.discountedMonthlyPrice)}',
                        textSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      const AppText(
                        '/mo.',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
