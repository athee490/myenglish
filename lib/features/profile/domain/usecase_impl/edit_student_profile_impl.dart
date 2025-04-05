import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/profile/domain/repository/profile_repository.dart';
import 'package:myenglish/features/profile/domain/usecase/edit_student_profile.dart';

class EditStudentProfileUseCaseImpl implements EditStudentProfileUseCase {
  final ProfileRepository _repository;

  EditStudentProfileUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call({
    required String name,
    required String enrollment,
    required String country,
    required String phoneCode,
  }) async {
    return await _repository.editStudentProfile(
      name: name,
      enrollment: enrollment,
      country: country,
      phoneCode: phoneCode,
    );
  }
}
