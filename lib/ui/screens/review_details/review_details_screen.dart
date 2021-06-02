import 'package:flutter/material.dart';

import 'package:data/data_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/score_card.dart';

class ReviewDetailsScreen extends StatelessWidget {
  final Review _review;

  const ReviewDetailsScreen(this._review);

  Widget _buildAppBar(textTheme, context) => AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.chevronLeft, color: Colors.white),
            onPressed: () => Navigator.of(context).pop()),
        centerTitle: true,
        title: Text(_review.reviewer.username,
            style: textTheme.headline5.copyWith(color: Colors.white)),
      );
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: _buildAppBar(textTheme, context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: EdgeInsets.only(left: 5.0, top: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      _review.reviewer.imageUrl,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ScoreCard(_review.reviewer.scores),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(_review.content.replaceAll("\\n", " "),
                    style: Theme.of(context).textTheme.subtitle1),
              ),
            ],
          ),
        ));
  }
}
