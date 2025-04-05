import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/profile/data/models/tutor_profile_model.dart';
import 'package:myenglish/features/profile/domain/repository/profile_repository.dart';
import 'package:myenglish/features/profile/domain/usecase/get_tutor_profile.dart';

class GetTutorProfileUseCaseImpl implements GetTutorProfileUseCase {
  final ProfileRepository _repository;
  GetTutorProfileUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, TutorProfileModel>> call() async {
    return await _repository.getTutorProfile();
  }
}
