import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';
import 'package:myenglish/features/onboarding/domain/usecase/student_register_usecase.dart';

class StudentRegisterUseCaseImpl implements StudentRegisterUseCase {
  final AuthenticationRepository _repository;

  StudentRegisterUseCaseImpl(this._repository);

  @override
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
    // required String reason,
    // required String language,
    // required String occupation,
    // required String qualification,
    // required String goalToJoin,
    // required String fromTime,
    // required String toTime
  }) async {
    return await _repository.studentRegister(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      phoneCode: phoneCode,
      password: password,
      enrollment: enrollment,
      grade: grade,
      country: country,


      // dob: dob,
      // startDate: startDate,
      // firebaseId: firebaseId,
      // deviceToken: deviceToken,
      // pincode: pincode,
      // reason: reason,
      // language: language,
      // occupation: occupation,
      // qualification: qualification,
      // goalToJoin: goalToJoin,
      // fromTime: fromTime,
      // toTime: toTime
    );
  }
}
