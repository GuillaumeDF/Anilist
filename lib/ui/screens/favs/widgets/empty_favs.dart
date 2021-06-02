import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class EmptyFavs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Material(
            elevation: 20.0,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text('  Emptiness...',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Center(
                    child: Text(
                        'Double tap an anime to add it to your favorites!',
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
              height: 400.0,
              child: FlareActor(
                "assets/animations/Cosmos.flr",
                animation: "Untitled",
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ))
        ]);
  }
}
