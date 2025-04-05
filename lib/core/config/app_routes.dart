import 'package:flutter/material.dart';
import 'package:myenglish/core/widgets/account_suspended_widget.dart';
import 'package:myenglish/features/attendance_details/data/models/home_attendance_model.dart';
import 'package:myenglish/features/attendance_details/presentation/screens/attendance_details_screen.dart';
import 'package:myenglish/features/home/data/models/student_dashboard_model.dart';
import 'package:myenglish/features/home/presentation/student/screens/my_plan_screen.dart';
import 'package:myenglish/features/home/presentation/student/screens/student_home_tab.dart';
import 'package:myenglish/features/home/presentation/tutor/screens/tutor_home_screen.dart';
import 'package:myenglish/features/onboarding/presentation/common/screens/login_screen.dart';
import 'package:myenglish/features/onboarding/presentation/common/screens/otp_screen.dart';
import 'package:myenglish/features/onboarding/presentation/common/screens/reset_password_screen.dart';
import 'package:myenglish/features/onboarding/presentation/common/screens/set_password_screen.dart';
import 'package:myenglish/features/onboarding/presentation/common/screens/splash_screen.dart';
import 'package:myenglish/features/onboarding/presentation/common/screens/user_selection_screen.dart';
import 'package:myenglish/features/onboarding/presentation/student/screens/choose_plan_screen.dart';
import 'package:myenglish/features/onboarding/presentation/student/screens/student_registration_screen.dart';
import 'package:myenglish/features/onboarding/presentation/student/screens/student_onboarding_screen.dart';
import 'package:myenglish/features/onboarding/presentation/tutor/screens/tutor_onboarding_screen.dart';
import 'package:myenglish/features/onboarding/presentation/tutor/screens/tutor_registration_screen.dart';
import 'package:myenglish/features/profile/presentation/screens/student_profile_screen.dart';
import 'package:myenglish/features/profile/presentation/screens/tutor_profile_screen.dart';
import 'package:myenglish/features/resources/presentation/screens/pdf_view.dart';
import 'package:myenglish/features/resources/presentation/screens/resources_screen.dart';
import 'package:myenglish/features/resources/presentation/screens/syllabus_screen.dart';
import 'package:myenglish/features/support/presentation/screens/help_and_support_screen.dart';

import '../../features/course_deatils/data/models/get_tutor_single_course_details_model.dart';
import '../../features/course_deatils/presentation/paypal/paypal_screen.dart';
import '../../features/course_deatils/presentation/tutor/screen/student_course_detail_screen.dart';
import '../../features/course_deatils/presentation/tutor/screen/tutor_course_detail_screen.dart';
import '../../features/course_deatils/presentation/tutor/screen/tutor_video_screen.dart';
import '../../features/course_syllabus/data/models/student_selected_course_model.dart';
import '../../features/course_syllabus/presentation/screen/edit_tutor_course_syllabus_screen.dart';
import '../../features/course_syllabus/presentation/screen/tutor_course_syllabus_screen.dart';
import '../../features/course_syllabus/presentation/screen/tutor_syllabus_list.dart';
import '../../features/home/data/models/get_student_purchased_course_details_model.dart';
import '../../features/home/presentation/tutor/screens/tutor_home_tap.dart';
import '../../features/intro_video/presentaion/tutor/screens/video_scr.dart';
import '../widgets/no_internet_screen.dart';

class AppRoutes {
  // static var mInternetProvider = internetProvider;
  static const String splash = '/';
  static const String userSelection = '/userSelection';
  static const String noInternetScreen = '/noInternetScreen';
  static const String studentOnboarding = '/studentOnboarding';
  static const String tutorOnboarding = '/tutorOnboarding';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String changePassword = '/changePassword';
  static const String resetPassword = '/resetPassword';
  static const String choosePlan = '/choosePlan';
  static const String studentRegister = '/studentRegister';
  static const String tutorRegister = '/tutorRegister';
  static const String studentProfile = '/studentProfile';
  static const String tutorProfile = '/tutorProfile';
  static const String studentCourseDetail = '/studentCourseDetail';
  static const String tutorCourseDetail = '/tutorCourseDetail';
  static const String editTutorCourseSyllabus = '/editTutorCourseSyllabus';
  static const String helpAndSupport = '/helpAndSupport';
  static const String myPlan = '/myPlan';
  static const String studentHome = '/studentHome';
  static const String tutorHomeTab = '/tutorHomeTab';
  static const String tutorHome = '/tutorHome';
  static const String resources = '/resources';
  static const String syllabus = '/syllabus';
  static const String pdfView = '/pdfView';
  static const String tutorCourseDetailsScreen = '/tutorCourseDetailsScreen';
  static const String attendanceDetails = '/attendanceDetails';
  static const String accountSuspended = '/accountSuspended';
  static const String courseSyllabus = '/course_syllabus';
  static const String videoScreen = '/videoScreen';
  static const String tutorVideoScreen = '/tutorVideoScreen';
  static const String payPalScreen = '/payPalScreen';

  static String? previousScreen;
  static String? currentScreen;

  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    return MaterialPageRoute(builder: (context) {
      previousScreen = currentScreen;
      currentScreen = setting.name;

      final args = setting.arguments;
      switch (setting.name) {
        case splash:
          return const SplashScreen();
        case noInternetScreen:
          return const NoInternetScreen();
        case userSelection:
          return const UserSelectionScreen();
        case studentOnboarding:
          return const StudentOnboardingScreen();
        case tutorOnboarding:
          return const TutorOnboardingScreen();
        case login:
          return const LoginScreen();
        case otp:
          {
            var argument = args as Map<String, dynamic>;
            return OtpScreen(
              email: argument['email'],
              otp: argument['otp'],
            );
          }
        case resetPassword:
          {
            var argument = args as Map<String, dynamic>;
            return ResetPasswordScreen(
              email: argument['email'],
            );
          }
        case changePassword:
          return SetPasswordScreen(reset: (args ?? false) as bool);
        case choosePlan:
          return ChoosePlanScreen(extend: args as bool?);
        case studentRegister:
          return const StudentRegistrationScreen();
        case tutorRegister:
          return const TutorRegistrationScreen();
        case tutorCourseDetailsScreen:
          return const TutorCourseListScreen();
        case studentProfile:
          return const StudentProfileScreen();
        case tutorProfile:
          return const TutorProfileScreen();
        case courseSyllabus:
          return const TutorCourseSyllabus();
        case editTutorCourseSyllabus:
          return const EditTutorCourseSyllabus();
        case studentCourseDetail:
          return const StudentCourseDetailScreen();
        case tutorCourseDetail:
          return const TutorCourseDetailScreen();
        case videoScreen:
          return IntroVideoScreen(studentVideoUrl: args as SingleCourseDetails);
        case tutorVideoScreen:
          return TutorIntroVideoScreen(
              tutorVideoUrl: args as TutorSingleCourseData);
        case helpAndSupport:
          return const HelpAndSupportScreen();
        case myPlan:
          return MyPlanScreen(
            data: args as PurchasedCourseDetails,
          );
        case studentHome:
          return const StudentHomeTab();
        case tutorHomeTab:
          return const TutorHomeTab();
        case tutorHome:
          return const TutorHomeScreen();
        case resources:
          return const ResourcesScreen();
        case syllabus:
          return const SyllabusScreen();
        case payPalScreen:
          return const PayPalCheckoutScreen();
        // case classroom:
        //   var argument = args as Map<String, dynamic>;
        //   return ClassRoomScreen(
        //     channelId: argument['channelId'],
        //     token: argument['token'],
        //     remoteUserId: argument['remoteUserId'],
        //   );
        // case breakoutRoom:
        //   var argument = args as Map<String, dynamic>;
        //   return BreakoutRoomScreen(
        //     channelId: argument['channelId'],
        //     token: argument['token'],
        //   );
        case pdfView:
          var argument = args as Map<String, dynamic>;
          return PdfView(
            title: argument['title'],
            url: argument['url'],
          );
        case attendanceDetails:
          return AttendanceDetailsScreen(
            studentData: args as HomeAttendanceModel,
          );
        case accountSuspended:
          var argument = args as Map<String, dynamic>;
          return AccountSuspendedWidget(
            isFromLogin: argument['isFromLogin'],
          );
        default:
          return const SplashScreen();
      }
    });
  }
}
