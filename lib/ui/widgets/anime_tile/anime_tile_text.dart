import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ani_list/ui/widgets/anime_tile/anime_tile.dart';

class AnimeTileText extends StatelessWidget {
  final AnimeTile widget;

  const AnimeTileText({@required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        gradient: LinearGradient(
            colors: [Colors.white.withOpacity(0.1), Colors.grey],
            begin: FractionalOffset.centerRight,
            end: FractionalOffset.centerLeft),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(FontAwesomeIcons.trophy, color: Colors.amber, size: 12.0),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(widget.score,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
