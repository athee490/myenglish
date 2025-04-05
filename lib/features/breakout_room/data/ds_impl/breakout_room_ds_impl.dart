import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:myenglish/core/constants/app_urls.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/extension.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/features/breakout_room/data/datasource/breakout_room_datasource.dart';
import 'package:myenglish/features/breakout_room/data/models/breakout_room_user.dart';
import 'package:myenglish/features/breakout_room/data/models/breakout_room_data.dart';
import 'package:myenglish/features/breakout_room/data/models/broom_enabled_model.dart';

class BreakoutRoomDataSourceImpl implements BreakoutRoomDataSource {
  final Dio dio;

  BreakoutRoomDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, List<BreakoutRoomUser>>> getBreakoutRoomUsers(
      String callId) async {
    var result = Either<Failure, List<BreakoutRoomUser>>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'callId': callId,
    };
    print(body);
    try {
      var rawResponse = await dio.post(UrlConstants.usersInRoom,
          data: body,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      log('212121 getBreakoutRoomUsers $rawResponse');
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          result.setRight(List<BreakoutRoomUser>.from(
              jsonData['data'].map((x) => BreakoutRoomUser.fromJson(x))));
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, List<BreakoutRoomData>>> getBreakoutRooms() async {
    var result = Either<Failure, List<BreakoutRoomData>>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var params = {
      'courseLevel':
          Prefs().getString(Prefs.courseLevel)!.toLowerCase() == 'student'
              ? 'beginner'
              : 'intermediate'
    };

    print('212121 getBreakoutRooms header $header');
    print('212121 getBreakoutRooms params $params');
    try {
      var rawResponse = await dio.post(UrlConstants.breakoutRoomList,
          data: params,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      log('212121 getBreakoutRooms $rawResponse');
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          result.setRight(List<BreakoutRoomData>.from(
              jsonData['data'].map((x) => BreakoutRoomData.fromJson(x))));
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> joinOrLeaveRoom(
      String callId, String logg) async {
    var result = Either<Failure, bool>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var params = {
      'callId': callId,
      'log': logg,
    };
    print('212121 joinOrLeaveRoom header $header');
    print('212121 joinOrLeaveRoom params $params');
    try {
      var rawResponse = await dio.post(UrlConstants.joinBreakoutRoom,
          data: params,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      log('212121 joinOrLeaveRoom $rawResponse');

      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else if (jsonData['data'].toString() == 'wait for 24 hours') {
          result.setLeft(CustomError((jsonData['data']).toString()));
        } else {
          result.setRight(true);
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> reportUser(
      {required String userId,
      required String callId,
      required String reason}) async {
    var result = Either<Failure, bool>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'roomId': callId,
      'description': reason,
      'complaintUserId': userId,
    };
    print(body);
    try {
      var rawResponse = await dio.post(UrlConstants.reportUser,
          data: body,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      log('212121 reportUser $rawResponse');
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          result.setRight(true);
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, List<BRoomEnabledModel>>>
      breakoutRoomEnableList() async {
    var result = Either<Failure, List<BRoomEnabledModel>>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};

    try {
      var rawResponse = await dio.get(UrlConstants.breakOutRoomEnableList,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      log('212121 breakoutRoomEnableList response $rawResponse');
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          List<BRoomEnabledModel> list = [];
          if (jsonData['data'] != null) {
            list = List<BRoomEnabledModel>.from(
                jsonData["data"].map((x) => BRoomEnabledModel.fromJson(x)));
          }
          result.setRight(list);
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }
}
