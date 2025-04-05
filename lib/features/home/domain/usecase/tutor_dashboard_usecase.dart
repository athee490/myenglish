import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/home/data/models/tutor_dashboard_model.dart';

abstract class TutorDashboardUseCase {
  Future<Either<Failure, TutorDashboardModel>> call();
}
