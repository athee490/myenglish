import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/profile/data/models/student_profile_model.dart';
import 'package:myenglish/features/profile/data/models/tutor_profile_model.dart';

abstract class ProfileDataSource {
  Future<Either<Failure, TutorProfileModel>> getTutorProfile();

  Future<Either<Failure, StudentProfileModel>> getStudentProfile();

  Future<Either<Failure, bool>> editTutorProfile({
    required String name,
    required String occupation,
    required String country,
    required String bankName,
    required String ifsc,
    required String bankAccountNumber,
    required String userName,
  });

  Future<Either<Failure, bool>> editStudentProfile({
    required String name,
    required String enrollment,
    required String country,
    required String phoneCode,
  });

  Future<Either<Failure, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
