import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class StudentRegisterUseCase {
  Future<Either<Failure, String>> call({
    required String name,
    required String email,
    required String phoneNumber,
    required String phoneCode,
    required String password,
    required String enrollment,
    required String grade,
    required String country,


    // required String dob,
    // required String startDate,
    // required String firebaseId,
    // required String deviceToken,
    // required int paid,
    // required String reason,
    // required String language,
    // required String occupation,
    // required String qualification,
    // required String goalToJoin,
    // required String fromTime,
    // required String toTime,
  });
}
