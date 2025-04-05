import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/profile/domain/repository/profile_repository.dart';
import 'package:myenglish/features/profile/domain/usecase/change_password_usecase.dart';

class ChangePasswordUseCaseImpl implements ChangePasswordUseCase {
  final ProfileRepository _repository;
  ChangePasswordUseCaseImpl(this._repository);
  @override
  Future<Either<Failure, bool>> call(
      {required String oldPassword, required String newPassword}) async {
    return await _repository.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }
}
