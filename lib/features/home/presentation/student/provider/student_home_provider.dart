import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myenglish/core/config/app_routes.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/home/data/models/get_student_purchased_course_details_model.dart';
import 'package:myenglish/features/home/data/models/student_dashboard_model.dart';
import 'package:myenglish/features/home/domain/usecase/add_rating_usecase.dart';
import 'package:myenglish/features/home/domain/usecase/student_dashboard_usecase.dart';
import 'package:myenglish/main.dart';
import 'package:omni_jitsi_meet/jitsi_meet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resize/resize.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../classroom/domain/usecase/student_attendance_usecase.dart';
import '../../../data/models/get_student_purchased_course_model.dart';
import '../../../domain/usecase/check_rating_usecase.dart';
import '../../../domain/usecase/get_student_purchased_course_details_usecase.dart';
import '../../../domain/usecase/get_student_purchased_useCase.dart';

class StudentHomeProvider extends ChangeNotifier {
  // final StudentDashboardUseCase _studentDashboardUseCase;
  final CheckRatingUseCase _checkRatingUseCase;
  final GetStudentPurchasedCourseDetailsUseCase _getStudentPurchasedCourseDetailsUseCase;
  final GetStudentPurchasedCourseUseCase _getStudentPurchasedCourseUseCase;
  final AddRatingUseCase _addRatingUseCase;
  final StudentAttendanceUseCase _studentAttendanceUseCase;

  StudentHomeProvider(
    // this._studentDashboardUseCase,
    this._checkRatingUseCase,
    this._getStudentPurchasedCourseDetailsUseCase,
    this._getStudentPurchasedCourseUseCase,
    this._addRatingUseCase,
    this._studentAttendanceUseCase,
  );

  bool loading = true;
  bool error = false;
  bool _disposed = false;
  bool enableJoinClass = false;

  List<GetStudentPurchasedCourseDetails> getPurchasedCourse = [];
  PurchasedCourseDetails? purchasedCourseDetailsData;

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  DashboardDetail? dashboardData;


  LiveDetail? liveDetail;
  bool paid = false;
  bool tutorAssigned = false;
  String selectedCourseId = '';

  bool accountSuspended = false;



  Future<void> getStudentPurchasedCourse()async{
    setLoading(true);
    var data = await _getStudentPurchasedCourseUseCase.getPurchasedCourse();
    setLoading(false);
    if(data.isLeft()){
      showToast(data.getLeft().error);
    }else{
      getPurchasedCourse.addAll(data.getRight().result!);
    }
  }

  Future<void> getPurchasedCourseDetails()async{
    setLoading(true);
    var data = await _getStudentPurchasedCourseDetailsUseCase.getPurchasedCourseDetails(selectedCourseId);
    setLoading(false);
    if(data.isLeft()){
      showToast(data.getLeft().error);
    }else{
      purchasedCourseDetailsData = data.getRight().result?.first;
       Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.myPlan,
          arguments: purchasedCourseDetailsData);
    }
  }


  // Future<void> getDashboard() async {
  //   var data = await _studentDashboardUseCase.call();
  //   if (data.isLeft()) {
  //     error = true;
  //     print('212121 data ${data.getLeft().error.toString()}');
  //     if (data.getLeft().error.toString().toLowerCase().contains('suspended')) {
  //       accountSuspended = true;
  //       notifyListeners();
  //     } else {
  //       showToast(data.getLeft().error, type: ToastType.error);
  //     }
  //   } else {
  //     accountSuspended = false;
  //     error = false;
  //     dashboardData = data.getRight().dashboardDetails?.first;
  //     print(data.getRight().liveDetails);
  //     if (!checkNullOrEmptyList(data.getRight().liveDetails)) {
  //       liveDetail = data.getRight().liveDetails?.first;
  //     }
  //     if (liveDetail != null &&
  //         liveDetail?.callId != null &&
  //         liveDetail!.tutorActiveStatus == 1) {
  //       enableJoinClass = true;
  //     }
  //     paid = !checkNullOrEmptyString(dashboardData!.amountPaid);
  //     tutorAssigned = !checkNullOrEmptyString(dashboardData!.tutorName);
  //     if (!checkNullOrEmptyString(dashboardData!.profileImage)) {
  //       await urlToUInt8List(
  //           dashboardData!.profileImage!, Prefs.profilePicture);
  //     }
  //     await Prefs().setString(Prefs.name, dashboardData!.name ?? '');
  //     await Prefs().setString(Prefs.userId, dashboardData!.id.toString());
  //     await Prefs().setBool(Prefs.isPaidForResources, dashboardData!.paid == 1);
  //     await Prefs()
  //         .setString(Prefs.courseLevel, dashboardData!.courseLevel ?? '');
  //     await Prefs().setInt(Prefs.courseId, dashboardData!.courseId ?? 0);
  //   }
  //   setLoading(false);
  // }

  toProfile() async {
    await Navigator.pushNamed(
            navigatorKey.currentContext!, AppRoutes.studentProfile)
        .then((value) {
      // getDashboard();
    });
    notifyListeners();
  }

  showRatingDialog() {
    double rating = 0.0;
    TextEditingController ratingController = TextEditingController();
    showDialog(
        barrierDismissible: true,
        context: navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 8.vw),
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            content: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              padding: EdgeInsets.all(4.vw),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppText('Rating'),
                    SizedBox(
                      height: 1.vh,
                    ),
                    const AppText(
                        'Give us your honest feedback to help us improve ourselves:)'),
                    SizedBox(
                      height: 4.vh,
                    ),
                    const AppText(
                      'How would you rate today’s Class?',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 2.vh,
                    ),
                    RatingBar(
                      itemSize: 30,
                      initialRating: rating,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                        full: Image.asset(
                          AppImages.ratingFilled,
                        ),
                        half: Image.asset(
                          AppImages.ratingUnfilled,
                        ),
                        empty: Image.asset(
                          AppImages.ratingUnfilled,
                        ),
                      ),
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      onRatingUpdate: (r) {
                        rating = r;
                        print(r);
                      },
                    ),
                    SizedBox(
                      height: 2.vh,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: AppColors.grey79,
                          ),
                          color: AppColors.white),
                      child: TextFormField(
                        controller: ratingController,
                        maxLines: 10,
                        maxLength: 250,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(4.vw),
                          counterText: '',
                          hintText: 'Share us your feedback (optional)',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.vh,
                    ),
                    PrimaryAppButton(
                      onTap: () {
                        if (rating != 0) {
                          submitRating(liveDetail!.callId!, rating.toString(),
                              ratingController.text.trim());
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Select Rating'),
                          ));
                        }
                      },
                      title: 'SUBMIT RATING',
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> submitRating(
      String callId, String rating, String comment) async {
    var data = await _addRatingUseCase.call(callId, rating, comment);
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      Navigator.pop(navigatorKey.currentState!.context);
      thanksDialog();
    }
  }

  bool ratingGiven = false;

  Future<void> checkRating() async {
    setLoading(true);
    var data = await _checkRatingUseCase.call();
    setLoading(false);
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      if (data.getRight()) {
        ratingGiven = true;
        joinMeeting(room: liveDetail!.callId!);
      } else {
        ratingGiven = false;
        showRatingDialog();
      }
    }
  }

  thanksDialog() {
    showDialog(
        barrierDismissible: true,
        context: navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 8.vw),
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            content: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              padding: EdgeInsets.all(4.vw),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppImages.thumbsUp),
                    SizedBox(
                      height: 1.vh,
                    ),
                    const AppText(
                        'Thank you for your honest feedback.\nWe\'ll try our best to fulfil your needs.'),
                    SizedBox(
                      height: 2.vh,
                    ),
                    PrimaryAppButton(
                      onTap: () {
                        // !ratingGiven
                        //     ? joinMeeting(room: liveDetail!.callId!)
                        //     : getDashboard();
                        Navigator.pop(context);
                      },
                      title: !ratingGiven
                          ? 'GO TO LIVE CLASS'
                          : 'GO TO HOME SCREEN',
                    ),
                  ],
                ),
              ),
            ),
          );
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
              showRatingDialog();
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
              logStudentAttendance();
            },
            onConferenceTerminated: (url, error) {
              debugPrint(
                  "JitsiMeetingListener - onConferenceTerminated: url: $url, error: $error");
              showRatingDialog();
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

  Future<void> logStudentAttendance() async {
    var data = await _studentAttendanceUseCase.call(liveDetail!.callId!);
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
