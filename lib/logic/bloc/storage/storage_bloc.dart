import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'package:storage/storage_repository.dart';

import 'package:ani_list/constants/constants.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final StorageRepository _storageRepository;

  StorageBloc({@required StorageRepository storageRepository})
      : assert(storageRepository != null),
        _storageRepository = storageRepository,
        super(StorageState.initial());

  @override
  Stream<StorageState> mapEventToState(
    StorageEvent event,
  ) async* {
    yield StorageState.loading();
    if (event is UploadImage) {
      yield* _mapUploadImageToState(event.image, event.path);
    } else if (event is DownloadImage) {
      yield* _mapDownloadImageToState(event.path);
    }
  }

  Stream<StorageState> _mapUploadImageToState(File image, String path) async* {
    try {
      String url = await _storageRepository.uploadImage(ImageModel(
          name: 'profile-picture', type: '.jpeg', data: image, path: path));
      yield StorageState.uploadSuccess(url);
    } on Exception {
      yield StorageState.error();
    }
  }

  Stream<StorageState> _mapDownloadImageToState(String path) async* {
    try {
      ImageModel image = await _storageRepository.downloadImage(path);
      yield StorageState.downloadSuccess(image);
    } on Exception {
      yield StorageState.error();
    }
  }
}
