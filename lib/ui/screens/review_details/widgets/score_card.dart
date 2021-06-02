import 'package:flutter/material.dart';

import 'package:data/data_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScoreCard extends StatelessWidget {
  final Scores _scores;

  ScoreCard(this._scores);

  Color _getScoreColor(int score) {
    if (score <= 5) return Colors.red;
    if (score > 5 && score < 8) return Colors.amber;
    return Colors.lightGreen;
  }

  Widget _buildOverallScore(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(FontAwesomeIcons.trophy, color: Colors.amber, size: 17.0),
        SizedBox(width: 10.0),
        Text('Overall: ',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        Text(_scores.overall.toString(),
            style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.bold,
                color: _getScoreColor(_scores.overall))),
        _scores.overall == 10
            ? Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(FontAwesomeIcons.meteor,
                    color: Colors.yellow, size: 20.0),
              )
            : Container(),
      ],
    );
  }

  Widget _buildScore(String title, String score, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$title ',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.bold)),
        Text(score,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
                color: _getScoreColor(int.parse(score)))),
      ],
    );
  }

  Widget _buildSubScore(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildScore("Story", _scores.story.toString(), context),
        _buildScore("Animation", _scores.animation.toString(), context),
        _buildScore("Character", _scores.character.toString(), context),
        _buildScore("Sound", _scores.sound.toString(), context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 100.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight,
              colors: <Color>[Colors.blue, Colors.purple],
            ),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(color: Colors.cyan, offset: Offset(1.0, 1.0)),
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _buildOverallScore(context),
            ),
            Divider(),
            _buildSubScore(context),
          ],
        ),
      ),
    );
  }
}
