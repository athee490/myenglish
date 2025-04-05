import 'dart:io';

import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class FileUploadUseCase {
  Future<Either<Failure, String>> call(File file);
}
