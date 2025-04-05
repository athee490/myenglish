import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/profile/domain/repository/profile_repository.dart';
import 'package:myenglish/features/profile/domain/usecase/edit_tutor_profile.dart';

class EditTutorProfileUseCaseImpl implements EditTutorProfileUseCase {
  final ProfileRepository _repository;

  EditTutorProfileUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call({
    required String name,
    required String occupation,
    required String country,
    required String bankName,
    required String ifsc,
    required String bankAccountNumber,
    required String userName,
  }) async {
    return await _repository.editTutorProfile(
        name: name,
        occupation: occupation,
        country: country,
        bankName: bankName,
        ifsc: ifsc,
        bankAccountNumber: bankAccountNumber,
        userName: userName);
  }
}
