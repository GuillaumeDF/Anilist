import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:image_picker/image_picker.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final _picker = ImagePicker();

  ImageCubit() : super(ImageInitial());

  Future<void> pickImage(bool fromCamera) async {
    emit(ImageLoading());
    try {
      final pickedFile = await _picker.getImage(
          source: fromCamera ? ImageSource.camera : ImageSource.gallery);
      if (pickedFile == null) {
        emit(ImageCanceled());
        return;
      }
      emit(ImageLoaded(File(pickedFile.path)));
    } on Exception {
      emit(ImageError());
    }
  }
}
