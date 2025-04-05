import 'package:flutter/material.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/attendance_details/data/models/home_attendance_model.dart';
import 'package:myenglish/features/attendance_details/domain/usecase/attendance_log_usecase.dart';
import 'package:myenglish/features/home/data/models/tutor_dashboard_model.dart';
import 'package:myenglish/main.dart';
import 'package:omni_jitsi_meet/jitsi_meet.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../attendance_details/data/models/get_student_attendance_model.dart';
import '../../../../attendance_details/domain/usecase/get_student_attandance_data_usecase.dart';
import '../../../../classroom/domain/usecase/tutor_attendance_usecase.dart';
import '../../../data/models/get_tutor_statistics_model.dart';
import '../../../data/models/get_tutor_today_course_model.dart';
import '../../../domain/usecase/get_tutor_statistic_usecase.dart';
import '../../../domain/usecase/get_tutor_today_course_details_usecase.dart';

class TutorHomeProvider extends ChangeNotifier {
  final GetTutorStatisticUseCase _getTutorStatisticUseCase;
  final GetTutorTodayCourseUseCase _getTutorTodayCourseUseCase;
  final AttendanceLogUseCase _attendanceLogUseCase;
  final GetStudentAttendanceDataUseCase _getStudentAttendanceDataUseCase;
  final TutorAttendanceUseCase _tutorAttendanceUseCase;

  TutorHomeProvider(
    this._attendanceLogUseCase,
    this._getTutorStatisticUseCase,
    this._getStudentAttendanceDataUseCase,
    this._getTutorTodayCourseUseCase,
    this._tutorAttendanceUseCase,
  );

  bool loading = true;
  bool attendanceLoading = true;
  bool _disposed = false;
  bool error = false;

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  TutorDashboardDetail? dashboardData;
  List<TutorLiveDetail> liveDetail = [];
  List<HomeAttendanceModel> attendanceLog = [];
  List<TutorStatisticsData> tutorStatisticsData = [];

  List<GetStudentData> getStudentAttendanceData = [];

  List<TutorTodayCourseDetails> tutorTodayCourseDetails = [];
  bool accountSuspended = false;

  // Future<void> getDashboard() async {
  //   accountSuspended = false;
  //   setLoading(true);
  //   var data = await _tutorDashboardUseCase.call();
  //   setLoading(false);
  //   if (data.isLeft()) {
  //     if (data.getLeft().error.toString().toLowerCase().contains('suspended')) {
  //       accountSuspended = true;
  //       notifyListeners();
  //     } else {
  //       showToast(data.getLeft().error, type: ToastType.error);
  //     }
  //   } else {
  //     accountSuspended = false;
  //     dashboardData = data.getRight().dashboardDetails?.first;
  //     if (!checkNullOrEmptyList(data.getRight().liveDetails)) {
  //       liveDetail = data.getRight().liveDetails ?? [];
  //     }
  //     // if (liveDetail != null && liveDetail?.callId != null) {
  //     //   enableJoinClass = true;
  //     // }
  //     if (!checkNullOrEmptyString(dashboardData!.tutorImage)) {
  //       await urlToUInt8List(dashboardData!.tutorImage!, Prefs.profilePicture);
  //     }
  //     await Prefs().setString(Prefs.name, dashboardData!.tutorName ?? '');
  //     await Prefs()
  //         .setBool(Prefs.tutorVerified, dashboardData!.verified ?? false);
  //     notifyListeners();
  //   }
  // }

  Future<void> getTutorTodayCourse() async {
    setLoading(true);
    var data = await _getTutorTodayCourseUseCase.getTutorTodayCourse();
    setLoading(false);
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      tutorTodayCourseDetails.addAll(data.getRight().data!);
    }
    notifyListeners();
  }

  Future<void> getTutorStatistic() async {
    setLoading(true);
    var data = await _getTutorStatisticUseCase.getTutorStatistic();
    setLoading(false);
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      tutorStatisticsData.addAll(data.getRight().data!);
    }
    notifyListeners();
  }

  Future<void> getAttendanceLog() async {
    var data = await _attendanceLogUseCase.call();
    if (data.isLeft()) {
      // showToast(data.getLeft().error, type: ToastType.error);
    } else {
      attendanceLog = data.getRight();
    }
    attendanceLoading = false;
    notifyListeners();
  }

  Future<void> getStudentAttendanceDetails() async {
    var data = await _getStudentAttendanceDataUseCase.getAttendanceData();
    if (data.isLeft()) {
      // showToast(data.getLeft().error);
    } else {
      if (data.getRight().data != null && data.getRight().data!.isNotEmpty) {
        getStudentAttendanceData.addAll(data.getRight().data!);
      }
    }
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  toProfile() async {
    await Navigator.pushNamed(
            navigatorKey.currentContext!, AppRoutes.tutorProfile)
        .then((value) {
      print('212121 calling');
      // getDashboard();
      getAttendanceLog();
    });
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
              logTutorAttendance();
            },
            onConferenceTerminated: (url, error) {
              debugPrint(
                  "JitsiMeetingListener - onConferenceTerminated: url: $url, error: $error");
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

  Future<void> logTutorAttendance() async {
    var data = await _tutorAttendanceUseCase.call(liveDetail.first.callId!);
    if (data.isLeft()) {
      showToast(data.getLeft().error);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
