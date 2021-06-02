import 'dart:io';

import 'package:storage/models/image.dart';

class UploadDataFailure implements Exception {}

abstract class AProvider {
  Future<File> downloadImage(String path);

  Future<String> uploadImage(ImageModel image);
}
