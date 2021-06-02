part of 'storage_bloc.dart';

class StorageState extends Equatable {
  final StorageStatus status;
  final String path;
  final ImageModel image;

  const StorageState._(
      {this.path, this.image, this.status = StorageStatus.Initial});

  const StorageState.initial() : this._();

  const StorageState.loading() : this._(status: StorageStatus.Loading);

  const StorageState.uploadSuccess(String path)
      : this._(path: path, status: StorageStatus.UploadSuccess);

  const StorageState.downloadSuccess(ImageModel image)
      : this._(image: image, status: StorageStatus.DownloadSuccess);

  const StorageState.error() : this._(status: StorageStatus.Error);

  @override
  List<Object> get props => [this.status, this.path, this.image];
}
