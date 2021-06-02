import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String path;
  final Function onTap;

  SocialButton({@required this.path, @required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(path),
              )),
        ),
      );
}
