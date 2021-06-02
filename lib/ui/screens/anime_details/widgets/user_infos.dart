import 'package:flutter/material.dart';

import 'package:data/data_repository.dart';

class UserInfos extends StatelessWidget {
  final Reviewer reviewer;

  const UserInfos(this.reviewer);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.only(left: 5.0, top: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              reviewer.imageUrl,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(
            reviewer.username,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 10.0),
          child: Text(
            "Overall score: ${reviewer.scores.overall}",
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
