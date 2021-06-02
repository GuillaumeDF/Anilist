import 'package:storage/models/image.dart';
import 'package:storage/providers/firebase_storage_provider.dart';

class StorageRepository {
  FirebaseStorageProvider _provider = FirebaseStorageProvider();

  Future<ImageModel> downloadImage(String path) async {
    var rawData = await _provider.downloadImage(path);
    return ImageModel(
        name: 'image', type: 'jpeg', data: rawData, path: rawData.path);
  }

  Future<String> uploadImage(ImageModel image) async =>
      await _provider.uploadImage(image);

  Future<List<String>> fetchFavList(String id) async =>
      await _provider.fetchFavList(id);
}
