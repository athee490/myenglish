import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/resources/data/models/syllabus_model.dart';

abstract class GetSyllabusUseCase {
  Future<Either<Failure, List<SyllabusModel>>> call(CourseLevel courseType);
}
