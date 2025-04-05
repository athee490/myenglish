import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/home/data/models/get_tutor_today_course_model.dart';
import 'package:myenglish/features/home/domain/repository/home_repository.dart';

import '../usecase/get_tutor_today_course_details_usecase.dart';

class GetTutorTodayCourseUseCaseImpl extends GetTutorTodayCourseUseCase {
  final HomeRepository _homeRepository;

  GetTutorTodayCourseUseCaseImpl(this._homeRepository);

  @override
  Future<Either<Failure, GetTutorTodayCourseModel>>
      getTutorTodayCourse() async {
    return await _homeRepository.getTutorTodayCourse();
  }
}
