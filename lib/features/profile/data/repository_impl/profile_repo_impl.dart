import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/profile/data/datasource/profile_datasource.dart';
import 'package:myenglish/features/profile/data/models/student_profile_model.dart';
import 'package:myenglish/features/profile/data/models/tutor_profile_model.dart';
import 'package:myenglish/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, StudentProfileModel>> getStudentProfile() async {
    var result = Either<Failure, StudentProfileModel>();
    var data = await _dataSource.getStudentProfile();
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, TutorProfileModel>> getTutorProfile() async {
    var result = Either<Failure, TutorProfileModel>();
    var data = await _dataSource.getTutorProfile();
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> editStudentProfile({
    required String name,
    required String enrollment,
    required String country,
    required String phoneCode,
  }) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.editStudentProfile(
      name: name,
      enrollment: enrollment,
      country: country,
      phoneCode: phoneCode,
    );
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> editTutorProfile({
    required String name,
    required String occupation,
    required String country,
    required String bankName,
    required String ifsc,
    required String bankAccountNumber,
    required String userName,
  }) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.editTutorProfile(
        name: name,
        occupation: occupation,
        country: country,
        bankName: bankName,
        ifsc: ifsc,
        bankAccountNumber: bankAccountNumber,
        userName: userName);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }
}
