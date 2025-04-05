import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/home/data/models/tutor_dashboard_model.dart';

abstract class AddRatingUseCase {
  Future<Either<Failure, String>> call(
      String callId, String rating, String comment);
}
