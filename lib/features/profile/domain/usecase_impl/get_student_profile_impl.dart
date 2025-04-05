import 'package:myenglish/features/profile/data/models/student_profile_model.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/profile/domain/repository/profile_repository.dart';
import 'package:myenglish/features/profile/domain/usecase/get_student_profile.dart';

class GetStudentProfileUseCaseImpl implements GetStudentProfileUseCase {
  final ProfileRepository _repository;
  GetStudentProfileUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, StudentProfileModel>> call() async {
    return await _repository.getStudentProfile();
  }
}
