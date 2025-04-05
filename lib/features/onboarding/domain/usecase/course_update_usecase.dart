import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class CourseUpdateUseCase {
  Future<Either<Failure, bool>> call(
      {required String planDuration,
      required String amount,
      required String classDuration,
      required String razorpayId,
      required bool extend});
}
