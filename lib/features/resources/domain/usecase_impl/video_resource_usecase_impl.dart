import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/resources/data/models/resource_model.dart';
import 'package:myenglish/features/resources/domain/repository/resource_repository.dart';
import 'package:myenglish/features/resources/domain/usecase/video_resource_usecase.dart';

class VideoResourceUseCaseImpl implements VideoResourceUseCase {
  final ResourceRepository _repository;
  VideoResourceUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, ResourceModel>> call(
      CourseLevel courseType, int pageNo, String languageFilter) async {
    return await _repository.getResources(courseType, Resource.video, pageNo,
        lanuguageFilter: languageFilter);
  }
}
