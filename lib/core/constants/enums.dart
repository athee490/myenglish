enum AppUser {
  student,
  tutor,
  nil,
}

enum ToastType { success, error, defaul, info }

///resources and types
enum Resource {
  document('application/pdf'),
  video('video/mp4');

  const Resource(this.type);
  final String type;
}

///course and types
enum CourseLevel {
  all,
  student,
  professional,
}

///resource filter
// ignore: constant_identifier_names
enum ResourceFilter { All, Tamil, English }
