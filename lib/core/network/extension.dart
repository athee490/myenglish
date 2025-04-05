import 'dart:convert';
import 'package:dio/dio.dart';
import 'either.dart';
import 'error.dart';

extension NetworkInterceptor on Response<dynamic> {
  Future<Either<Failure, String>> getResult() async {
    var result = Either<Failure, String>();
    if (statusCode == 200) {
      if (data == null) {
        result.setLeft(ApiReturnNull());
      } else {
        result.setRight(json.encode(data));
      }
    } else {
      result.setLeft(statusCode.toString().getFailureType());
    }
    return result;
  }
}

extension ErrorCodeHandler on String? {
  Failure getFailureType() {
    Failure result = UnknownError();

    if ((this ?? "").contains(BadRequest().errorCode.toString())) {
      result = BadRequest();
    } else if ((this ?? "").contains(Forbidden().errorCode.toString())) {
      result = Forbidden();
    } else if ((this ?? "").contains(UrlNotFound().errorCode.toString())) {
      result = UrlNotFound();
    } else if ((this ?? "").contains(MethodNotAllowed().errorCode.toString())) {
      result = MethodNotAllowed();
    } else if ((this ?? "")
        .contains(InternalServerError().errorCode.toString())) {
      result = InternalServerError();
    } else if ((this ?? "").contains(BadGateway().errorCode.toString())) {
      result = BadGateway();
    } else if ((this ?? "")
        .contains(ServerUnavailable().errorCode.toString())) {
      result = ServerUnavailable();
    } else if ((this ?? "").contains(GatewayTimeout().errorCode.toString())) {
      result = GatewayTimeout();
    } else if ((this ?? "").contains('SocketException')) {
      result = NoInternetConnection();
    } else {
      result = UnknownError();
    }
    return result;
  }
}

extension DioErrorHandling on DioError {
  Failure getDioError() {
    Failure result = UnknownError();
    result = error.toString().getFailureType();
    return result;
  }
}
