import 'package:myenglish/features/resources/data/models/syllabus_model.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/features/resources/domain/repository/resource_repository.dart';
import 'package:myenglish/features/resources/domain/usecase/get_syllabus_usecase.dart';

class GetSyllabusUseCaseImpl implements GetSyllabusUseCase {
  final ResourceRepository _repository;
  GetSyllabusUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, List<SyllabusModel>>> call(
      CourseLevel courseType) async {
    return await _repository.getSyllabus(courseType);
  }
}
