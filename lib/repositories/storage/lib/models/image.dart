import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'file.dart';

class ImageModel extends FileModel {
  ImageModel(
      {@required String name,
      @required String type,
      @required File data,
      String path})
      : super(name: name, type: type, data: data, path: path) {
    if (type != '.jpeg') throw Exception();
  }
}
