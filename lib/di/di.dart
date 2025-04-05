import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myenglish/core/constants/app_strings.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/features/attendance_details/data/datasource/attendance_datasource.dart';
import 'package:myenglish/features/attendance_details/data/ds_impl/attendance_ds_impl.dart';
import 'package:myenglish/features/attendance_details/data/repository_impl/attendance_repository_impl.dart';
import 'package:myenglish/features/attendance_details/domain/repository/attendance_repository.dart';
import 'package:myenglish/features/attendance_details/domain/usecase/attendance_history_usecase.dart';
import 'package:myenglish/features/attendance_details/domain/usecase/attendance_log_usecase.dart';
import 'package:myenglish/features/attendance_details/domain/usecase_impl/attendance_history_usecase_impl.dart';
import 'package:myenglish/features/attendance_details/domain/usecase_impl/attendance_log_usecase_impl.dart';
import 'package:myenglish/features/attendance_details/presentation/provider/attendance_details_provider.dart';
import 'package:myenglish/features/breakout_room/data/datasource/breakout_room_datasource.dart';
import 'package:myenglish/features/breakout_room/data/ds_impl/breakout_room_ds_impl.dart';
import 'package:myenglish/features/breakout_room/data/repository_impl/breakout_room_repo_impl.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/breakoutroom_list_usecase.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/broom_enabled_list_usecase.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/get_roomusers_usecase.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/join_room_usecase.dart';
import 'package:myenglish/features/breakout_room/domain/usecase/report_user_usecase.dart';
import 'package:myenglish/features/breakout_room/domain/usecase_impl/breakoutroom_list_usecase_impl.dart';
import 'package:myenglish/features/breakout_room/domain/usecase_impl/broom_enabled_usecase_impl.dart';
import 'package:myenglish/features/breakout_room/domain/usecase_impl/get_roomusers_usecase_impl.dart';
import 'package:myenglish/features/breakout_room/domain/usecase_impl/join_room_usecase_impl.dart';
import 'package:myenglish/features/breakout_room/domain/usecase_impl/report_user_usecase_impl.dart';
import 'package:myenglish/features/breakout_room/presentation/providers/breakout_room_provider.dart';
import 'package:myenglish/features/classroom/data/datasource/classroom_datasource.dart';
import 'package:myenglish/features/classroom/data/ds_impl/classroom_ds_impl.dart';
import 'package:myenglish/features/classroom/data/repository_impl/classroom_repository_impl.dart';
import 'package:myenglish/features/classroom/domain/repository/classroom_repository.dart';
import 'package:myenglish/features/classroom/domain/usecase/send_delay_notification_usecase.dart';
import 'package:myenglish/features/classroom/domain/usecase/student_attendance_usecase.dart';
import 'package:myenglish/features/classroom/domain/usecase/tutor_attendance_usecase.dart';
import 'package:myenglish/features/classroom/domain/usecase_impl/send_delay_noitifcation_usecase_impl.dart';
import 'package:myenglish/features/classroom/domain/usecase_impl/student_attendance_usecase_impl.dart';
import 'package:myenglish/features/classroom/domain/usecase_impl/tutor_attendance_usecase_impl.dart';
import 'package:myenglish/features/course_deatils/data/datasource/tutor_course_datasource.dart';
import 'package:myenglish/features/home/data/datasource/home_datasource.dart';
import 'package:myenglish/features/home/data/ds_impl/home_ds_impl.dart';
import 'package:myenglish/features/home/data/repository_impl/home_repo_impl.dart';
import 'package:myenglish/features/home/domain/repository/home_repository.dart';
import 'package:myenglish/features/home/presentation/student/provider/student_home_provider.dart';
import 'package:myenglish/features/home/presentation/tutor/providers/tutor_home_provider.dart';
import 'package:myenglish/features/onboarding/data/datasource/authentication_datasource.dart';
import 'package:myenglish/features/onboarding/data/ds_impl/auth_ds_impl.dart';
import 'package:myenglish/features/onboarding/data/repository_impl/auth_repo_impl.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';
import 'package:myenglish/features/onboarding/domain/usecase/course_update_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/file_upload_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/reset_password_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/send_otp_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/student_login_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/student_register_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/tutor_login_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/tutor_register_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/update_devicetoken_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase/verify_otp_usecase.dart';
import 'package:myenglish/features/onboarding/domain/usecase_impl/course_update_usecase_impl.dart';
import 'package:myenglish/features/onboarding/domain/usecase_impl/file_upload_usecase_impl.dart';
import 'package:myenglish/features/onboarding/domain/usecase_impl/reset_password_usecase_impl.dart';
import 'package:myenglish/features/onboarding/domain/usecase_impl/send_otp_usecase_impl.dart';
import 'package:myenglish/features/onboarding/domain/usecase_impl/student_login_usecase_impl.dart';
import 'package:myenglish/features/onboarding/domain/usecase_impl/student_register_usecase_impl.dart';
import 'package:myenglish/features/onboarding/domain/usecase_impl/tutor_login_usecase_impl.dart';
import 'package:myenglish/features/onboarding/domain/usecase_impl/tutor_register_usecase_impl.dart';
import 'package:myenglish/features/onboarding/domain/usecase_impl/update_devicetoken_usecase_impl.dart';
import 'package:myenglish/features/onboarding/domain/usecase_impl/verify_otp_usecase_impl.dart';
import 'package:myenglish/features/onboarding/presentation/common/providers/login_provider.dart';
import 'package:myenglish/features/onboarding/presentation/common/providers/otp_provider.dart';
import 'package:myenglish/features/onboarding/presentation/common/providers/reset_password_provider.dart';
import 'package:myenglish/features/onboarding/presentation/student/providers/choose_plan_provider.dart';
import 'package:myenglish/features/onboarding/presentation/student/providers/razorpay_provider.dart';
import 'package:myenglish/features/onboarding/presentation/student/providers/student_registration_provider.dart';
import 'package:myenglish/features/onboarding/presentation/tutor/providers/tutor_registration_provider.dart';
import 'package:myenglish/features/profile/data/datasource/profile_datasource.dart';
import 'package:myenglish/features/profile/data/ds_impl/profile_ds_impl.dart';
import 'package:myenglish/features/profile/data/repository_impl/profile_repo_impl.dart';
import 'package:myenglish/features/profile/domain/repository/profile_repository.dart';
import 'package:myenglish/features/profile/domain/usecase/change_password_usecase.dart';
import 'package:myenglish/features/profile/domain/usecase/edit_student_profile.dart';
import 'package:myenglish/features/profile/domain/usecase/edit_tutor_profile.dart';
import 'package:myenglish/features/profile/domain/usecase/get_student_profile.dart';
import 'package:myenglish/features/profile/domain/usecase/get_tutor_profile.dart';
import 'package:myenglish/features/profile/domain/usecase_impl/change_password_usecase_impl.dart';
import 'package:myenglish/features/profile/domain/usecase_impl/edit_student_profile_impl.dart';
import 'package:myenglish/features/profile/domain/usecase_impl/edit_tutor_profile_impl.dart';
import 'package:myenglish/features/profile/domain/usecase_impl/get_student_profile_impl.dart';
import 'package:myenglish/features/profile/domain/usecase_impl/get_tutor_profile_impl.dart';
import 'package:myenglish/features/profile/presentation/providers/change_password_provider.dart';
import 'package:myenglish/features/profile/presentation/providers/student_profile_provider.dart';
import 'package:myenglish/features/profile/presentation/providers/tutor_profile_provider.dart';
import 'package:myenglish/features/resources/data/datasource/resource_datasource.dart';
import 'package:myenglish/features/resources/data/ds_impl/resource_ds_impl.dart';
import 'package:myenglish/features/resources/data/repository_impl/resource_repo_impl.dart';
import 'package:myenglish/features/resources/domain/repository/resource_repository.dart';
import 'package:myenglish/features/resources/domain/usecase/document_resource_usecase.dart';
import 'package:myenglish/features/resources/domain/usecase/get_syllabus_usecase.dart';
import 'package:myenglish/features/resources/domain/usecase/video_resource_usecase.dart';
import 'package:myenglish/features/resources/domain/usecase_impl/document_resource_usecase_impl.dart';
import 'package:myenglish/features/resources/domain/usecase_impl/get_syllabus_usecase_impl.dart';
import 'package:myenglish/features/resources/domain/usecase_impl/video_resource_usecase_impl.dart';
import 'package:myenglish/features/resources/presentation/provider/resources_provider.dart';
import 'package:myenglish/features/resources/presentation/provider/syllabus_provider.dart';
import 'package:myenglish/features/support/presentation/providers/support_provider.dart';

import '../core/network/logger_interceptor.dart';
import '../features/attendance_details/domain/usecase/get_student_attandance_data_usecase.dart';
import '../features/attendance_details/domain/usecase_impl/get_student_attendance_usecase_impl.dart';
import '../features/course_deatils/data/ds_impl/tutor_course_ds_impl.dart';
import '../features/course_deatils/data/repository_impl/tutor_course_repo_impl.dart';
import '../features/course_deatils/domain/repository/tutor_course_repository.dart';
import '../features/course_deatils/domain/usecase/edit_tutor_course_usecase.dart';
import '../features/course_deatils/domain/usecase/get_tutor_course_details_usecase.dart';
import '../features/course_deatils/domain/usecase_impl/edit_tutor_course_usecase_impl.dart';
import '../features/course_deatils/domain/usecase_impl/get_tutor_course_details_usecase_impl.dart';
import '../features/course_deatils/presentation/tutor/providers/tutor_course_provider.dart';
import '../features/course_syllabus/data/data_source_impl/add_course_data_source_impl.dart';
import '../features/course_syllabus/data/datasource/add_course_data_source.dart';
import '../features/course_syllabus/data/repository_impl/add_course_repo_impl.dart';
import '../features/course_syllabus/domain/repository/add_course_repository.dart';
import '../features/course_syllabus/domain/usecase/add_course_usecase.dart';
import '../features/course_syllabus/domain/usecase/get_student_all_course_usecase.dart';
import '../features/course_syllabus/domain/usecase/student_selected_course_usecase.dart';
import '../features/course_syllabus/domain/usecase/tutor_course_details_usecase.dart';
import '../features/course_syllabus/domain/usecase_impl/add_course_usecase_impl.dart';
import '../features/course_syllabus/domain/usecase_impl/get_student_all_course_usecase_impl.dart';
import '../features/course_syllabus/domain/usecase_impl/student_selected_course_usecase_impl.dart';
import '../features/course_syllabus/domain/usecase_impl/tutor_course_details_usecase_impl.dart';
import '../features/course_syllabus/presentation/provider/student_course_syllabus_provider.dart';
import '../features/course_syllabus/presentation/provider/tutor_course_syllabus_provider.dart';
import '../features/home/domain/usecase/add_rating_usecase.dart';
import '../features/home/domain/usecase/check_rating_usecase.dart';
import '../features/home/domain/usecase/get_student_purchased_course_details_usecase.dart';
import '../features/home/domain/usecase/get_student_purchased_useCase.dart';
import '../features/home/domain/usecase/get_tutor_statistic_usecase.dart';
import '../features/home/domain/usecase/get_tutor_today_course_details_usecase.dart';
import '../features/home/domain/usecase_impl/add_rating_usecase_impl.dart';
import '../features/home/domain/usecase_impl/check_rating_usecase_impl.dart';
import '../features/home/domain/usecase_impl/get_student_purchased_course_details_usecase_impl.dart';
import '../features/home/domain/usecase_impl/get_student_purchased_course_usecase_impl.dart';
import '../features/home/domain/usecase_impl/get_tutor_statistic_usecase_impl.dart';
import '../features/home/domain/usecase_impl/get_tutor_today_course_details_usecase_impl.dart';
import '../internet_provider.dart';

///dio
var dioProvider = Provider<Dio>((_) {
  var options = BaseOptions(
    baseUrl: '',
    connectTimeout: const Duration(milliseconds: 10000),
    receiveTimeout: const Duration(milliseconds: 10000),
  );
  var dio = Dio(options);
  dio.interceptors.add(LoggerInterceptor());
  return dio;
});

///no internet
var internetProvider =
    ChangeNotifierProvider.autoDispose((ref) => InternetProvider());

///firebase auth
var firebaseAuth = Provider<FirebaseAuth>((_) {
  return FirebaseAuth.instance;
});

AppUser get getAppUser {
  var user = Prefs().getString(Prefs.userType);
  switch (user) {
    case null:
      return AppUser.nil;
    case AppStrings.student:
      return AppUser.student;
    case AppStrings.tutor:
      return AppUser.tutor;
    default:
      return AppUser.nil;
  }
}

///authentication
var authenticationDataSource = Provider<AuthenticationDataSource>((ref) =>
    AuthDataSourceImpl(ref.watch(dioProvider), ref.watch(firebaseAuth)));
var authenticationRepository = Provider<AuthenticationRepository>(
    (ref) => AuthenticationRepositoryImpl(ref.watch(authenticationDataSource)));

///forgot password usecases
var sendOtpUseCase = Provider.autoDispose<SendOtpUseCase>(
    (ref) => SendOtpUseCaseImpl(ref.watch(authenticationRepository)));
var verifyOtpUseCase = Provider.autoDispose<VerifyOtpUseCase>(
    (ref) => VerifyOtpUseCaseImpl(ref.watch(authenticationRepository)));
var resetPasswordUseCase = Provider.autoDispose<ResetPasswordUseCase>(
    (ref) => ResetPasswordUseCaseImpl(ref.watch(authenticationRepository)));
var verifyOtpProvider = ChangeNotifierProvider.autoDispose(
    (ref) => OtpProvider(ref.watch(verifyOtpUseCase)));
var resetPasswordProvider = ChangeNotifierProvider.autoDispose(
    (ref) => ResetPasswordProvider(ref.watch(resetPasswordUseCase)));

///student-login
var studentLoginUseCase = Provider.autoDispose<StudentLoginUseCase>(
    (ref) => StudentLoginUseCaseImpl(ref.watch(authenticationRepository)));
var updateDeviceTokenUseCase = Provider.autoDispose<UpdateDeviceTokenUseCase>(
    (ref) => UpdateDeviceTokenUseCaseImpl(ref.watch(authenticationRepository)));
var loginProvider = ChangeNotifierProvider.autoDispose((ref) => LoginProvider(
    ref.watch(studentLoginUseCase),
    ref.watch(tutorLoginUseCase),
    ref.watch(updateDeviceTokenUseCase),
    ref.watch(sendOtpUseCase)));

///student-register
var studentRegisterUseCase = Provider.autoDispose<StudentRegisterUseCase>(
    (ref) => StudentRegisterUseCaseImpl(ref.watch(authenticationRepository)));
var studentRegistrationProvider = ChangeNotifierProvider.autoDispose(
    (ref) => StudentRegistrationProvider(ref.watch(studentRegisterUseCase)));

///tutor-login
var tutorLoginUseCase = Provider.autoDispose<TutorLoginUseCase>(
    (ref) => TutorLoginUseCaseImpl(ref.watch(authenticationRepository)));

///tutor-register
var tutorRegisterUseCase = Provider.autoDispose<TutorRegisterUseCase>(
    (ref) => TutorRegisterUseCaseImpl(ref.watch(authenticationRepository)));
var tutorRegistrationProvider = ChangeNotifierProvider.autoDispose((ref) =>
    TutorRegistrationProvider(
        ref.watch(tutorRegisterUseCase), ref.watch(fileUploadUseCase)));

var tutorCourseSyllabusProvider = ChangeNotifierProvider.autoDispose((ref) =>
    TutorCourseSyllabusProvider(
        ref.watch(fileUploadUseCase),
        ref.watch(tutorCourseRegistrationUseCase),
        ref.watch(tutorCourseDetailsUseCase)));

var tutorCourseDetailsProvider = ChangeNotifierProvider.autoDispose(
  (ref) => TutorCourseDetailsProvider(ref.watch(editTutorCourseUseCase),
      ref.watch(getTutorCourseDetailsUseCase), ref.watch(fileUploadUseCase)),
);

var studentCourseSyllabusProvider = ChangeNotifierProvider.autoDispose((ref) =>
    StudentCourseSyllabusProvider(ref.watch(getStudentAllCourseDetailsUseCase),
        ref.watch(getStudentSelectedCourseUseCase)));

///file upload
var fileUploadUseCase = Provider<FileUploadUseCase>(
    (ref) => FileUploadUseCaseImpl(ref.watch(authenticationRepository)));

///StudentCourseRegistration
var getStudentAllCourseDetailsUseCase =
    Provider.autoDispose<GetStudentAllCourseDetailsUseCase>((ref) =>
        GetStudentAllCourseUseCaseImpl(ref.watch(tutorCourseRegistrationRepo)));

var getStudentSelectedCourseUseCase =
    Provider.autoDispose<StudentSelectedCourseUseCase>((ref) =>
        StudentSelectedCourseUseCaseImpl(
            ref.watch(tutorCourseRegistrationRepo)));

///tutorCourseRegistration
var tutorCourseRegistrationUseCase =
    Provider.autoDispose<TutorCourseRegistrationUseCase>((ref) =>
        TutorCourseRegistrationUseCaseImpl(
            ref.watch(tutorCourseRegistrationRepo)));

var tutorCourseDetailsUseCase = Provider.autoDispose<TutorCourseDetailsUseCase>(
    (ref) =>
        TutorCourseDetailsUseCaseImpl(ref.watch(tutorCourseRegistrationRepo)));

var getTutorCourseDetailsUseCase =
    Provider.autoDispose<GetTutorCourseDetailsUseCase>((ref) =>
        GetTutorCourseDetailsUseCaseImpl(ref.watch(tutorCourseRepository)));

var editTutorCourseUseCase = Provider.autoDispose<EditTutorCourseUseCase>(
    (ref) => EditTutorCourseUseCaseImpl(ref.watch(tutorCourseRepository)));

var tutorCourseRegistrationRepo =
    Provider.autoDispose<TutorCourseRegistrationRepo>((ref) =>
        TutorCourseRegistrationRepoImpl(
            ref.watch(tutorCourseRegistrationDataSource)));

var tutorCourseRepository = Provider.autoDispose<TutorCourseRepository>(
    (ref) => TutorCourseRepositoryImpl(ref.watch(tutorDataSource)));

var tutorCourseRegistrationDataSource =
    Provider.autoDispose<TutorCourseRegistrationDataSource>(
        (ref) => TutorCourseRegistrationDataSourceImpl(ref.watch(dioProvider)));

var tutorDataSource = Provider.autoDispose<TutorDataSource>(
    (ref) => TutorCourseDataSourceImpl(ref.watch(dioProvider)));

///choose plan
var courseUpdateUseCase = Provider.autoDispose<CourseUpdateUseCase>(
    (ref) => CourseUpdateUseCaseImpl(ref.watch(authenticationRepository)));
var choosePlanProvider = ChangeNotifierProvider.autoDispose(
    (ref) => ChoosePlanProvider(ref.watch(courseUpdateUseCase)));

///razorpay
var razorpayProvider =
    ChangeNotifierProvider.autoDispose((ref) => RazorpayProvider());

///help and support
var supportProvider =
    ChangeNotifierProvider.autoDispose((ref) => SupportProvider());

///profile
var profileDataSource = Provider.autoDispose<ProfileDataSource>(
    (ref) => ProfileDataSourceImpl(ref.watch(dioProvider)));
var profileRepository = Provider.autoDispose<ProfileRepository>(
    (ref) => ProfileRepositoryImpl(ref.watch(profileDataSource)));
var getStudentProfileUseCase = Provider.autoDispose<GetStudentProfileUseCase>(
    (ref) => GetStudentProfileUseCaseImpl(ref.watch(profileRepository)));
var getTutorProfileUseCase = Provider.autoDispose<GetTutorProfileUseCase>(
    (ref) => GetTutorProfileUseCaseImpl(ref.watch(profileRepository)));
var editStudentProfileUseCase = Provider.autoDispose<EditStudentProfileUseCase>(
    (ref) => EditStudentProfileUseCaseImpl(ref.watch(profileRepository)));
var editTutorProfileUseCase = Provider.autoDispose<EditTutorProfileUseCase>(
    (ref) => EditTutorProfileUseCaseImpl(ref.watch(profileRepository)));

var tutorProfileProvider = ChangeNotifierProvider.autoDispose(
  (ref) => TutorProfileProvider(
    // ref.watch(tutorDashboardUseCase),
    ref.watch(getTutorProfileUseCase),
    ref.watch(editTutorProfileUseCase),
    ref.watch(fileUploadUseCase),
  ),
);
var studentProfileProvider = ChangeNotifierProvider.autoDispose(
  (ref) => StudentProfileProvider(
    // ref.watch(studentDashboardUseCase),
    ref.watch(getStudentProfileUseCase),
    ref.watch(editStudentProfileUseCase),
    ref.watch(fileUploadUseCase),
  ),
);

///change password
var changePasswordUseCase = Provider.autoDispose<ChangePasswordUseCase>(
    (ref) => ChangePasswordUseCaseImpl(ref.watch(profileRepository)));
var changePasswordProvider = ChangeNotifierProvider.autoDispose(
    (ref) => ChangePasswordProvider(ref.watch(changePasswordUseCase)));

///home
var homeDataSource = Provider.autoDispose<HomeDataSource>(
    (ref) => HomeDataSourceImpl(ref.watch(dioProvider)));
var homeRepository = Provider.autoDispose<HomeRepository>(
    (ref) => HomeRepositoryImpl(ref.watch(homeDataSource)));
// var studentDashboardUseCase = Provider.autoDispose<StudentDashboardUseCase>(
//     (ref) => StudentDashboardUseCaseImpl(ref.watch(homeRepository)));
//
// var tutorDashboardUseCase = Provider.autoDispose<TutorDashboardUseCase>(
//     (ref) => TutorDashboardUseCaseImpl(ref.watch(homeRepository)));

var addRatingUseCase = Provider.autoDispose<AddRatingUseCase>(
    (ref) => AddRatingUseCaseImpl(ref.watch(homeRepository)));
var checkRatingUseCase = Provider.autoDispose<CheckRatingUseCase>(
    (ref) => CheckRatingUseCaseImpl(ref.watch(homeRepository)));

var getStudentPurchasedCourseUseCase =
    Provider.autoDispose<GetStudentPurchasedCourseUseCase>((ref) =>
        GetStudentPurchasedCourseUseCaseImpl(ref.watch(homeRepository)));

var getStudentPurchasedCourseDetailsUseCase =
    Provider.autoDispose<GetStudentPurchasedCourseDetailsUseCase>((ref) =>
        GetStudentPurchasedCourseDetailsUseCaseImpl(ref.watch(homeRepository)));

var studentHomeProvider =
    ChangeNotifierProvider.autoDispose((ref) => StudentHomeProvider(
          // ref.watch(studentDashboardUseCase),
          ref.watch(checkRatingUseCase),
          ref.watch(getStudentPurchasedCourseDetailsUseCase),
          ref.watch(getStudentPurchasedCourseUseCase),
          ref.watch(addRatingUseCase),
          ref.watch(studentAttendanceUseCase),
        ));
var tutorHomeProvider =
    ChangeNotifierProvider.autoDispose((ref) => TutorHomeProvider(
          // ref.watch(tutorDashboardUseCase),
          ref.watch(attendanceLogUseCase),
          ref.watch(getTutorStatisticUseCase),
          ref.watch(getStudentAttendanceUseCase),
          ref.watch(tutorTodayCourseDetailsUseCase),
          ref.watch(tutorAttendanceUseCase),
        ));

///classroom
var classroomDataSource = Provider.autoDispose<ClassRoomDataSource>(
    (ref) => ClassRoomDataSourceImpl(ref.watch(dioProvider)));
var classRoomRepository = Provider.autoDispose<ClassRoomRepository>(
    (ref) => ClassRoomRepositoryImpl(ref.watch(classroomDataSource)));
var studentAttendanceUseCase = Provider.autoDispose<StudentAttendanceUseCase>(
    (ref) => StudentAttendanceUseCaseImpl(ref.watch(classRoomRepository)));
var tutorTodayCourseDetailsUseCase =
    Provider.autoDispose<GetTutorTodayCourseUseCase>(
        (ref) => GetTutorTodayCourseUseCaseImpl(ref.watch(homeRepository)));

var getTutorStatisticUseCase = Provider.autoDispose<GetTutorStatisticUseCase>(
    (ref) => GetTutorStatisticUseCaseImpl(ref.watch(homeRepository)));

var tutorAttendanceUseCase = Provider.autoDispose<TutorAttendanceUseCase>(
    (ref) => TutorAttendanceUseCaseImpl(ref.watch(classRoomRepository)));
var sendDelayNotificationUseCase =
    Provider.autoDispose<SendDelayNotificationUseCase>((ref) =>
        SendDelayNotificationUseCaseImpl(ref.watch(classRoomRepository)));

///breakout room
var breakoutRoomDataSource = Provider.autoDispose<BreakoutRoomDataSource>(
    (ref) => BreakoutRoomDataSourceImpl(ref.watch(dioProvider)));
var breakoutRoomRepository = Provider.autoDispose<BreakoutRoomRepositoryImpl>(
    (ref) => BreakoutRoomRepositoryImpl(ref.watch(breakoutRoomDataSource)));
var breakoutRoomListUseCase = Provider.autoDispose<BreakoutRoomListUseCase>(
    (ref) => BreakoutRoomListUseCaseImpl(ref.watch(breakoutRoomRepository)));
var joinRoomUseCase = Provider.autoDispose<JoinBreakoutRoomUseCase>(
    (ref) => JoinBreakoutRoomUseCaseImpl(ref.watch(breakoutRoomRepository)));
var reportUserUseCase = Provider.autoDispose<ReportUserUseCase>(
    (ref) => ReportUserUseCaseImpl(ref.watch(breakoutRoomRepository)));
var getRoomUsersUseCase = Provider.autoDispose<GetRoomUsersUseCase>(
    (ref) => GetRoomUsersUseCaseImpl(ref.watch(breakoutRoomRepository)));
var getBRoomEnabledListUseCase = Provider.autoDispose<BRoomEnabledListUseCase>(
    (ref) => BRoomEnabledUseCaseImpl(ref.watch(breakoutRoomRepository)));
var breakoutRoomProvider =
    ChangeNotifierProvider.autoDispose((ref) => BreakoutRoomProvider(
          // ref.watch(studentDashboardUseCase),
          ref.watch(breakoutRoomListUseCase),
          ref.watch(joinRoomUseCase),
          ref.watch(getRoomUsersUseCase),
          ref.watch(reportUserUseCase),
          ref.watch(getBRoomEnabledListUseCase),
        ));

///resources
var resourceDataSource = Provider.autoDispose<ResourceDataSource>(
    (ref) => ResourceDataSourceImpl(ref.watch(dioProvider)));
var resourceRepository = Provider.autoDispose<ResourceRepository>(
    (ref) => ResourceRepositoryImpl(ref.watch(resourceDataSource)));
var videoResourceUseCase = Provider.autoDispose<VideoResourceUseCase>(
    (ref) => VideoResourceUseCaseImpl(ref.watch(resourceRepository)));
var documentResourceUseCase = Provider.autoDispose<DocumentResourceUseCase>(
    (ref) => DocumentResourceUseCaseImpl(ref.watch(resourceRepository)));
var resourcesProvider =
    ChangeNotifierProvider.autoDispose((ref) => ResourcesProvider(
          // ref.watch(studentDashboardUseCase),
          ref.watch(documentResourceUseCase),
          ref.watch(videoResourceUseCase),
        ));

///syllabus
var getSyllabusUseCase = Provider.autoDispose<GetSyllabusUseCase>(
    (ref) => GetSyllabusUseCaseImpl(ref.watch(resourceRepository)));

var syllabusProvider =
    ChangeNotifierProvider.autoDispose((ref) => SyllabusProvider(
          // ref.watch(studentDashboardUseCase),
          ref.watch(getSyllabusUseCase),
        ));

///attendance details
var attendanceDataSource = Provider.autoDispose<AttendanceDataSource>(
    (ref) => AttendanceDataSourceImpl(ref.watch(dioProvider)));
var attendanceRepository = Provider.autoDispose<AttendanceRepository>(
    (ref) => AttendanceRepositoryImpl(ref.watch(attendanceDataSource)));
var attendanceLogUseCase = Provider.autoDispose<AttendanceLogUseCase>(
    (ref) => AttendanceLogUseCaseImpl(ref.watch(attendanceRepository)));
var attendanceHistoryUseCase = Provider.autoDispose<AttendanceHistoryUseCase>(
    (ref) => AttendanceHistoryUseCaseImpl(ref.watch(attendanceRepository)));
var getStudentAttendanceUseCase =
    Provider.autoDispose<GetStudentAttendanceDataUseCase>((ref) =>
        GetStudentAttendanceDataUseCaseImpl(ref.watch(attendanceRepository)));
var attendanceProvider = ChangeNotifierProvider.autoDispose((ref) =>
    AttendanceDetailsProvider(ref.watch(attendanceHistoryUseCase),
        ref.watch(getStudentAttendanceUseCase)));
