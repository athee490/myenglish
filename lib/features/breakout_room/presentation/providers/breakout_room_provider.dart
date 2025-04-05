import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/breakout_room/data/models/breakout_room_data.dart';
import 'package:myenglish/features/breakout_room/data/models/breakout_room_user.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/breakoutroom_list_usecase.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/broom_enabled_list_usecase.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/get_roomusers_usecase.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/join_room_usecase.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/report_user_usecase.dart';
import 'package:myenglish/features/breakout_room/presentation/dialogs/report_dialog.dart';
import 'package:myenglish/features/breakout_room/presentation/dialogs/report_submitted_dialog.dart';
import 'package:myenglish/features/home/domain/usecase/student_dashboard_usecase.dart';
import 'package:myenglish/main.dart';
import 'package:omni_jitsi_meet/jitsi_meet.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../home/data/models/student_dashboard_model.dart';
import '../../data/models/broom_enabled_model.dart';

enum BreakoutStatus { beforeCall, inCall, callCompleted }

class BreakoutRoomProvider extends ChangeNotifier {
  // final StudentDashboardUseCase _studentDashboardUseCase;
  final BreakoutRoomListUseCase _breakoutRoomListUseCase;
  final JoinBreakoutRoomUseCase _joinBreakoutRoomUseCase;
  final GetRoomUsersUseCase _getRoomUsersUseCase;
  final ReportUserUseCase _reportUserUseCase;
  final BRoomEnabledListUseCase _bRoomEnabledListUseCase;

  BreakoutRoomProvider(
    // this._studentDashboardUseCase,
    this._breakoutRoomListUseCase,
    this._joinBreakoutRoomUseCase,
    this._getRoomUsersUseCase,
    this._reportUserUseCase,
    this._bRoomEnabledListUseCase,
  );

  bool isLoading = false;

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool isBreakoutRoomEnabled = false;
  BreakoutStatus status = BreakoutStatus.beforeCall;

  //before and after call
  final reportDesc = TextEditingController();
  BreakoutRoomData? breakoutRoomData;
  List<BreakoutRoomUser> roomUsers = [];
  String reportId = '';

  updateReportId(String id) {
    reportId = id;
    notifyListeners();
  }

  //api__________________

  bool accountSuspended = false;
  DashboardDetail? dashboardData;

  // Future<void> getDashboard() async {
  //   setLoader(true);
  //   var data = await _studentDashboardUseCase.call();
  //   setLoader(false);
  //   if (data.isLeft()) {
  //     print('212121 data ${data.getLeft().error.toString()}');
  //     if (data.getLeft().error.toString().toLowerCase().contains('suspended')) {
  //       accountSuspended = true;
  //       notifyListeners();
  //     } else {
  //       showToast(data.getLeft().error, type: ToastType.error);
  //     }
  //   } else {
  //     accountSuspended = false;
  //     dashboardData = data.getRight().dashboardDetails?.first;
  //     checkIfRoomEnabled();
  //   }
  // }

  ///check if user can join
  BRoomEnabledModel? bRoomEnabledModel;

  Future<void> checkIfRoomEnabled() async {
    isBreakoutRoomEnabled = false;
    setLoader(true);

    var data = await _bRoomEnabledListUseCase.call();
    print('212121 data $data');
    setLoader(false);
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      var list = data.getRight();
      for (var element in list) {
        print(
            '212121 check ${element.days?.toLowerCase()} - ${DateFormat('EEEE').format(DateTime.now()).toLowerCase()}');
        if ((element.days?.toLowerCase() ?? '') ==
            DateFormat('EEEE').format(DateTime.now()).toLowerCase()) {
          isBreakoutRoomEnabled = element.enable ?? false;
          if (element.enable!) {
            bRoomEnabledModel = element;
          }
        }
      }
    }
    notifyListeners();
  }

  ///get room list api and join call
  Future<void> getRoomListAndJoin() async {
    var data = await _breakoutRoomListUseCase.call();
    if (data.isLeft()) {
      showToast(data.getLeft().error);
    } else {
      List<BreakoutRoomData> roomList = data.getRight();
      roomList = roomList.where((element) => element.userCount! < 3).toList();
      if (roomList.isEmpty) {
        showToast('No rooms available at the moment. Please try later',
            type: ToastType.error);
        return;
      }
      breakoutRoomData = roomList[0];
      // showToast(
      //     'callId: ${breakoutRoomData!.callId!.toString()}\nroomName: ${breakoutRoomData!.topic!.toString()}');
      joinMeeting(room: breakoutRoomData!.topic!.toString());
    }
  }

  joinMeeting({required String room}) async {
    try {
      await [Permission.microphone, Permission.camera].request();
      Map<FeatureFlagEnum, Object> featureFlags = {
        FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
        FeatureFlagEnum.AUDIO_FOCUS_DISABLED: false,
        FeatureFlagEnum.AUDIO_MUTE_BUTTON_ENABLED: true,
        FeatureFlagEnum.AUDIO_ONLY_BUTTON_ENABLED: false,
        FeatureFlagEnum.CALENDAR_ENABLED: false,
        FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
        FeatureFlagEnum.CAR_MODE_ENABLED: false,
        FeatureFlagEnum.CLOSE_CAPTIONS_ENABLED: false,
        FeatureFlagEnum.CONFERENCE_TIMER_ENABLED: true,
        FeatureFlagEnum.CHAT_ENABLED: true,
        FeatureFlagEnum.FILMSTRIP_ENABLED: false,
        FeatureFlagEnum.FULLSCREEN_ENABLED: true,
        FeatureFlagEnum.HELP_BUTTON_ENABLED: false,
        FeatureFlagEnum.INVITE_ENABLED: false,
        FeatureFlagEnum.IOS_RECORDING_ENABLED: true,
        FeatureFlagEnum.IOS_SCREENSHARING_ENABLED: true,
        FeatureFlagEnum.ANDROID_SCREENSHARING_ENABLED: true,
        FeatureFlagEnum.SPEAKERSTATS_ENABLED: false,
        FeatureFlagEnum.KICK_OUT_ENABLED: false,
        FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
        FeatureFlagEnum.LOBBY_MODE_ENABLED: false,
        FeatureFlagEnum.MEETING_NAME_ENABLED: true,
        FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
        FeatureFlagEnum.NOTIFICATIONS_ENABLED: true,
        FeatureFlagEnum.OVERFLOW_MENU_ENABLED: true,
        FeatureFlagEnum.PIP_ENABLED: false,
        FeatureFlagEnum.PIP_WHILE_SCREEN_SHARING_ENABLED: false,
        FeatureFlagEnum.PREJOIN_PAGE_ENABLED: false,
        FeatureFlagEnum.RAISE_HAND_ENABLED: true,
        FeatureFlagEnum.REACTIONS_ENABLED: true,
        FeatureFlagEnum.RECORDING_ENABLED: true,
        FeatureFlagEnum.REPLACE_PARTICIPANT: false,
        FeatureFlagEnum.SECURITY_OPTIONS_ENABLED: false,
        FeatureFlagEnum.SERVER_URL_CHANGE_ENABLED: false,
        FeatureFlagEnum.SETTINGS_ENABLED: false,
        FeatureFlagEnum.TILE_VIEW_ENABLED: true,
        FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: false,
        FeatureFlagEnum.TOOLBOX_ENABLED: true,
        FeatureFlagEnum.VIDEO_MUTE_BUTTON_ENABLED: false,
        FeatureFlagEnum.VIDEO_SHARE_BUTTON_ENABLED: true,
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };

      var options = JitsiMeetingOptions(
        serverURL: 'https://social.pyradev.com',
        room: room,
        audioOnly: false,
        audioMuted: true,
        videoMuted: false,
        userDisplayName: Prefs().getString(Prefs.name),
        featureFlags: featureFlags,
      );

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(
            onOpened: () {
              debugPrint("JitsiMeetingListener - onOpened");
            },
            onClosed: () {
              debugPrint("JitsiMeetingListener - onClosed");
              debugPrint("onClosed");
              joinOrLeave(false);
              notifyListeners();
            },
            onError: (error) {
              debugPrint("JitsiMeetingListener - onError: error: $error");
            },
            onConferenceWillJoin: (url) {
              debugPrint(
                  "JitsiMeetingListener - onConferenceWillJoin: url: $url");
            },
            onConferenceJoined: (url) {
              debugPrint("JitsiMeetingListener - onConferenceJoined: url:$url");
              joinOrLeave(true);
            },
            onConferenceTerminated: (url, error) {
              debugPrint(
                  "JitsiMeetingListener - onConferenceTerminated: url: $url, error: $error");
              joinOrLeave(false);
              notifyListeners();
            },
            onParticipantLeft: (participantId) {
              debugPrint(
                  "JitsiMeetingListener - onParticipantLeft: $participantId");
            },
            onParticipantJoined: (email, name, role, participantId) {
              debugPrint("JitsiMeetingListener - onParticipantJoined: "
                  "email: $email, name: $name, role: $role, "
                  "participantId: $participantId");
            },
            onAudioMutedChanged: (muted) {
              debugPrint(
                  "JitsiMeetingListener - onAudioMutedChanged: muted: $muted");
            },
            onVideoMutedChanged: (muted) {
              debugPrint(
                  "JitsiMeetingListener - onVideoMutedChanged: muted: $muted");
            },
            onScreenShareToggled: (participantId, isSharing) {
              debugPrint("JitsiMeetingListener - onScreenShareToggled: "
                  "participantId: $participantId, isSharing: $isSharing");
            },
            genericListeners: [
              JitsiGenericListener(
                  eventName: 'readyToClose',
                  callback: (dynamic message) {
                    debugPrint("JitsiMeetingListener - readyToClose callback");
                  }),
            ]),
      ).then((value) => null, onError: (error) {
        showToast(error);
      });
    } catch (e) {
      showToast(e.toString());
    }
  }

  Future<void> joinOrLeave(bool join) async {
    var data = await _joinBreakoutRoomUseCase.call(
        breakoutRoomData!.callId!.toString(), join ? 'login' : 'logout');
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      // showToast(join ? 'login entry success' : 'logout entry success');
    }
  }

  Future<void> getRoomUsers() async {
    reportDesc.clear();
    var data =
        await _getRoomUsersUseCase.call(breakoutRoomData!.callId!.toString());
    print('212121 room user response $data');
    if (data.isLeft()) {
      showToast(data.getLeft().error);
    } else {
      roomUsers = data.getRight();
      roomUsers.removeWhere((element) =>
          element.userId.toString() == Prefs().getString(Prefs.userId));
      ReportDialog().show();
    }
    notifyListeners();
  }

  ///report user api call
  Future<void> reportUser() async {
    if (reportId.isEmpty) {
      showToast('Please select user');
      return;
    }
    if (reportDesc.text.isEmpty) {
      showToast('Provide report description');
      return;
    }
    var data = await _reportUserUseCase.call(
        userId: reportId,
        callId: breakoutRoomData!.callId!.toString(),
        reason: reportDesc.text);
    if (data.isLeft()) {
      showToast(data.getLeft().error);
    } else {
      Navigator.pop(navigatorKey.currentContext!);
      ReportSubmittedDialog().show();
    }
  }

  //__________________________________________________________________

  //timer_____________________________________________________________
  Timer? timer;
  Duration timerDurtion = const Duration(seconds: 0);

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      timerDurtion = Duration(seconds: timerDurtion.inSeconds + 1);
      print('212121 ${timerDurtion.inSeconds}');
      notifyListeners();
    });
  }

  stopTimer() {
    print('212121 timer cancelled');
    timer?.cancel();
    timerDurtion = const Duration(seconds: 0);
  }

  //__________________________________________________________________

  @override
  void dispose() {
    if (breakoutRoomData != null) {
      joinOrLeave(false);
    }
    breakoutRoomData = null;
    bRoomEnabledModel = null;
    super.dispose();
  }
}
