import 'package:myenglish/features/home/data/models/student_dashboard_model.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/home/domain/repository/home_repository.dart';
import 'package:myenglish/features/home/domain/usecase/student_dashboard_usecase.dart';

// class StudentDashboardUseCaseImpl implements StudentDashboardUseCase {
//   final HomeRepository _repository;
//   StudentDashboardUseCaseImpl(this._repository);
//   @override
//   Future<Either<Failure, StudentDashboardModel>> call() async {
//     return await _repository.studentDashboard();
//   }
// }
