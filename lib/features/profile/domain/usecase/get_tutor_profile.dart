import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/profile/data/models/tutor_profile_model.dart';

abstract class GetTutorProfileUseCase {
  Future<Either<Failure, TutorProfileModel>> call();
}
