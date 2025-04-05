class UrlConstants {
  // static const String baseUrl = 'http://188.166.228.50:8081';
  static const String baseUrl = 'http://152.67.164.255:3001';

  //authentication
  static const String deviceToken = '$baseUrl/web/deviceToken';
  static const String sendOTP = '$baseUrl/web/sendOtp';
  static const String verifyOTP = '$baseUrl/web/verifyOtp';
  static const String resetPassword = '$baseUrl/web/resetPassword';

  //student auth
  static const String loginStudent = '$baseUrl/web/loginStudent';
  static const String registerStudent = '$baseUrl/web/registerStudent';

  //tutor auth
  static const String loginTutor = '$baseUrl/web/tutorlogin';
  static const String registerTutor = '$baseUrl/web/registerTutor';

  //file upload
  static const String fileUpload = '$baseUrl/web/fileUpload';

  //update course details
  static const String studentCourseUpdate = '$baseUrl/web/studentCourseUpdate';
  static const String studentCourseExtend = '$baseUrl/web/studentCourseExtend';

  //profile
  static const String getStudentProfile = '$baseUrl/web/viewStudentProfile';
  static const String editStudentProfile = '$baseUrl/web/editStudentProfile';
  static const String getTutorProfile = '$baseUrl/web/viewTutorDetails';
  static const String edittutorProfile = '$baseUrl/web/editTutor';
  static const String comparePassword = '$baseUrl/web/comparePassword';

  //home
  static const String studentDashboard = '$baseUrl/web/dashboardWeb';
  static const String tutorDashboard = '$baseUrl/web/tutorDashboardWeb';
  static const String addRating = '$baseUrl/web/addRating';
  static const String checkRating = '$baseUrl/web/checkRating';

  //resources
  static const String courseMaterials = '$baseUrl/web/courseMaterialsWeb';
  static const String getSyllabus = '$baseUrl/web/course_syllabus';

  //attendance
  static const String studentAttendance = '$baseUrl/web/studentAttendance';
  static const String tutorAttendance = '$baseUrl/web/tutorAttendance';
  static const String getAttendanceLogDetails =
      '$baseUrl/web/getAttendanceLogDetails';
  static const String getAttendanceHistoryDetails =
      '$baseUrl/web/getAttendanceHistoryDetails';

  //notification
  static const String sendDelayNotification =
      '$baseUrl/web/sendDelayNotification';

  //breakout room
  static const String breakoutRoomList = '$baseUrl/web/breakoutRoomList';
  static const String joinBreakoutRoom = '$baseUrl/web/joinBreakoutRoom';
  static const String usersInRoom = '$baseUrl/web/usersInRoom';
  static const String breakOutRoomEnableList =
      '$baseUrl/web/breakOutRoomEnableList';

  //report
  static const String reportUser = '$baseUrl/web/reportUser';

  ///TutorCourseRegistration
  static const String tutorCourseRegistration = '$baseUrl/web/add/course';
  static const String getTutorCourseDetails = '$baseUrl/web/courseDetails';
  static const String getTutorTodayCourseDetails = '$baseUrl/web/today/courseDetails';
  static const String getTutorStatistic = '$baseUrl/web/tutor/statistics';
  static const String editTutorCourse = '$baseUrl/web/edit/course';


  ///StudentCourseDetails
  static String getAllCourseList = '$baseUrl/web/student/getCourseDetails';
  static String getSingleCourseDetails = '$baseUrl/web/student/getCourseDetails';
  static String getStudentPurchasedCourse = '$baseUrl/web/student/purchasedCourses';
  static String getStudentPurchasedCourseDetails = '$baseUrl/web/student/purchasedCourses';

  ///payments
  static String payment ='$baseUrl/web/user/payment/';

  //reference
  static const String url = '$baseUrl/';
}
