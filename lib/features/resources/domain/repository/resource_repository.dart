import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/resources/data/models/resource_model.dart';
import 'package:myenglish/features/resources/data/models/syllabus_model.dart';

abstract class ResourceRepository {
  Future<Either<Failure, ResourceModel>> getResources(
      CourseLevel courseType, Resource resourceType, int pageNo,
      {String? lanuguageFilter});
  Future<Either<Failure, List<SyllabusModel>>> getSyllabus(
      CourseLevel courseType);
}
