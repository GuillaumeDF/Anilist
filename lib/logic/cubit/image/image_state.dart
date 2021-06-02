part of 'image_cubit.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final File image;

  const ImageLoaded(this.image);

  @override
  List<Object> get props => [this.image];
}

class ImageCanceled extends ImageState {}

class ImageError extends ImageState {}
