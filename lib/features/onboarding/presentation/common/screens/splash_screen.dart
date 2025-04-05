import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/di/di.dart';

import '../../../../../internet_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late InternetProvider mInternetProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var mInternetProvider = ref.watch(internetProvider);
      bool isConnected =
          mInternetProvider.connectionStatus != ConnectivityResult.none;

      if (!isConnected) {
        do {
          await Future.delayed(const Duration(seconds: 3));
          mInternetProvider = ref.watch(internetProvider);
          isConnected =
              mInternetProvider.connectionStatus != ConnectivityResult.none;
        } while (!isConnected);
      }

      if (Prefs().getBool(Prefs.isLoggedIn)) {
        switch (getAppUser) {
          case AppUser.student:
            Navigator.pushReplacementNamed(context, AppRoutes.studentHome);
            break;
          case AppUser.tutor:
            Navigator.pushReplacementNamed(context, AppRoutes.tutorHomeTab);
            break;
          default:
            showToast('No user found');
        }
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.userSelection);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF173148),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Image.asset(AppImages.splashBg),
              ),
              // splashBg(),
              // Positioned(
              //   // top: 34.vh,
              //   child: SvgPicture.asset(
              //     AppImages.logo,
              //   ),
              // ),
            ],
          )),
    );
  }
}
