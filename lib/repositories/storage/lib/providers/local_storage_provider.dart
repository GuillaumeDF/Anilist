import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:storage/models/image.dart';

import 'provider.dart';

class LocalStorageProvider extends AProvider {
  @override
  Future<File> downloadImage(String path) async {
    return File(path);
  }

  @override
  Future<String> uploadImage(ImageModel image) async {
    final appDir = await getExternalStorageDirectory();
    final savedImage =
        await image.data.copy('${appDir.path}/${image.name}${image.type}');
    return savedImage.path;
  }
}
