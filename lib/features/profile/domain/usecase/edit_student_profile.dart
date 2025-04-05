import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class EditStudentProfileUseCase {
  Future<Either<Failure, bool>> call({
    required String name,
    required String enrollment,
    required String country,
    required String phoneCode,
  });
}
