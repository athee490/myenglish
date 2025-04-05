import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/widgets/button.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/di/di.dart';

class JoinBreakoutRoomButton extends StatelessWidget {
  final String text;

  const JoinBreakoutRoomButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      var mbreakoutRoomProvider = ref.watch(breakoutRoomProvider);
      return PrimaryAppButton(
        title: text,
        onTap: () async {
          print(
              '212121 courseLevel ${mbreakoutRoomProvider.dashboardData!.courseLevel}');
          if (!checkNullOrEmptyString(
              mbreakoutRoomProvider.dashboardData!.courseLevel)) {
            if (mbreakoutRoomProvider.isBreakoutRoomEnabled &&
                mbreakoutRoomProvider.bRoomEnabledModel!.isClassTimeNow!) {
              mbreakoutRoomProvider.getRoomListAndJoin();
            } else {
              if (mbreakoutRoomProvider.bRoomEnabledModel != null &&
                  !mbreakoutRoomProvider.bRoomEnabledModel!.isClassTimeNow!) {
                showToast('Breakout Room not enabled at this time',
                    type: ToastType.error);
              } else {
                showToast('Breakout room not enabled today',
                    type: ToastType.error);
              }
            }
          } else {
            showToast('Level is not updated by admin');
          }
        },
      );
    });
  }
}
