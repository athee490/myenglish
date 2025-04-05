import 'dart:io';

import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';
import 'package:myenglish/features/onboarding/domain/usecase/file_upload_usecase.dart';

class FileUploadUseCaseImpl implements FileUploadUseCase {
  final AuthenticationRepository _repository;
  FileUploadUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, String>> call(File file) async {
    return await _repository.fileUpload(file);
  }
}
