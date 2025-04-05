import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:resize/resize.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;
  const AuthScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -50.h,
              left: -40.w,
              child: Container(
                height: 232.h,
                width: 232.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.bgYellow,
                ),
              ),
            ),
            Positioned(
              top: 50.vh,
              right: -50.w,
              child: Container(
                height: 127.h,
                width: 127.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.bgPink,
                ),
              ),
            ),
            Positioned(
              bottom: -90.h,
              right: -10.w,
              child: Container(
                height: 248.5.h,
                width: 248.5.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.bgBlue,
                ),
              ),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
