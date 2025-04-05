import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/resources/data/models/resource_model.dart';

abstract class VideoResourceUseCase {
  Future<Either<Failure, ResourceModel>> call(
      CourseLevel courseType, int pageNo, String languageFilter);
}
