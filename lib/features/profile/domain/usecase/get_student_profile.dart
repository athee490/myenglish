import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/profile/data/models/student_profile_model.dart';

abstract class GetStudentProfileUseCase {
  Future<Either<Failure, StudentProfileModel>> call();
}
