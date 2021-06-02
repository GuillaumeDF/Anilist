part of 'storage_bloc.dart';

abstract class StorageEvent extends Equatable {
  const StorageEvent();

  @override
  List<Object> get props => [];
}

class UploadImage extends StorageEvent {
  final File image;
  final String path;

  const UploadImage(this.image, this.path);

  @override
  List<Object> get props => [this.image, this.path];
}

class DownloadImage extends StorageEvent {
  final String path;

  const DownloadImage(this.path);

  @override
  List<Object> get props => [this.path];
}
