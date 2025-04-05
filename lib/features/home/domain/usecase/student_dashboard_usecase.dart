import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/home/data/models/student_dashboard_model.dart';

abstract class StudentDashboardUseCase {
  Future<Either<Failure, StudentDashboardModel>> call();
}
