import 'package:equatable/equatable.dart';

///abstract class for Failure
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [error, errorCode];

  String get error;

  int get errorCode;
}

///400
class BadRequest extends Failure {
  @override
  String get error => "BAD REQUEST";

  @override
  int get errorCode => 400;
}

///403
class Forbidden extends Failure {
  @override
  String get error => "FORBIDDEN";

  @override
  int get errorCode => 403;
}

///404
class UrlNotFound extends Failure {
  @override
  String get error => "NOT FOUND";

  @override
  int get errorCode => 404;
}

///405
class MethodNotAllowed extends Failure {
  @override
  String get error => "METHOD NOT ALLOWED";

  @override
  int get errorCode => 405;
}

///500
class InternalServerError extends Failure {
  @override
  String get error => "SERVER ERROR";

  @override
  int get errorCode => 500;
}

///502
class BadGateway extends Failure {
  @override
  String get error => "BAD GATEWAY";

  @override
  int get errorCode => 502;
}

//503
class ServerUnavailable extends Failure {
  @override
  String get error => "SERVICE UNAVAILABLE";

  @override
  int get errorCode => 503;
}

///504
class GatewayTimeout extends Failure {
  @override
  String get error => "GATEWAY TIMEOUT";

  @override
  int get errorCode => 504;
}

///something went wrong
class UnknownError extends Failure {
  @override
  String get error => "Something Went Wrong";

  @override
  int get errorCode => 0;
}

///No internet connection
class NoInternetConnection extends Failure {
  @override
  String get error => "No Internet Connection";

  @override
  int get errorCode => 1;
}

class ApiReturnNull extends Failure {
  @override
  String get error => "Api Return Null Value";

  @override
  int get errorCode => 2;
}

///Customizable error class with [errorMessage]
class CustomError extends Failure {
  final String? errorMessage;

  CustomError(this.errorMessage);

  @override
  String get error => errorMessage ?? "";

  @override
  int get errorCode => 5;
}
