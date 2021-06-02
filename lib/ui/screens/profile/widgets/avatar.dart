import 'dart:io';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String url;
  final double _avatarSize = 80.0;
  final File imageFile;

  const Avatar({Key key, this.url, this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: _avatarSize,
      backgroundImage: url != null
          ? NetworkImage(url)
          : imageFile != null
              ? FileImage(imageFile)
              : null,
      child: url == null && imageFile == null
          ? Icon(Icons.person_outline, size: _avatarSize)
          : null,
    );
  }
}
