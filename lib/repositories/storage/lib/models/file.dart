import 'dart:io';

import 'package:flutter/material.dart';

const defaultPath = './';

abstract class FileModel {
  final String name;
  final String type;
  final File data;
  final String path;

  FileModel(
      {@required this.name,
      @required this.type,
      @required this.data,
      this.path = defaultPath});
}
