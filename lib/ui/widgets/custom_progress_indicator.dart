import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:loading_indicator/loading_indicator.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 80.0,
      child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          color: Colors.amber[900]),
    );
  }
}
