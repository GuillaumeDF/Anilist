import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:data/data_repository.dart';
import 'package:users/users_repository.dart';
import 'package:ani_list/logic/bloc/bloc.dart';
import 'package:ani_list/logic/cubit/cubit.dart';

class StatusDialog extends StatefulWidget {
  final AnimeInfos anime;

  StatusDialog({Key key, this.anime}) : super(key: key);

  @override
  _StatusDialogState createState() => _StatusDialogState();
}

enum Status { Watching, PlanToWatch }

class _StatusDialogState extends State<StatusDialog> {
  bool _isInList = false;
  AnimesListCubit _animesListCubit;

  @override
  void initState() {
    super.initState();
    _animesListCubit = BlocProvider.of<AnimesListCubit>(context);
    _isInList = _animesListCubit.isInList(widget.anime.malId.toString());
  }

  Future<void> _onPressedAddToList(User user) async {
    switch (await showDialog<Status>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select status'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Status.PlanToWatch);
              },
              child: const Text('Plan to watch'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Status.Watching);
              },
              child: const Text('Currently watching'),
            ),
          ],
        );
      },
    )) {
      case Status.PlanToWatch:
        _animesListCubit.addToList(user, widget.anime, "plan");
        break;
      case Status.Watching:
        _animesListCubit.addToList(user, widget.anime, "watching");
        break;
      default:
        return;
    }
    _isInList = !_isInList;
  }

  _onPressedRmFromList(User user) {
    _animesListCubit.removeFromList(user, widget.anime);
    _isInList = !_isInList;
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.select((UserBloc bloc) => bloc.state.user);

    return IconButton(
        icon: Icon(_isInList ? FontAwesomeIcons.check : FontAwesomeIcons.plus,
            color: Colors.amber),
        onPressed: () {
          !_isInList ? _onPressedAddToList(user) : _onPressedRmFromList(user);
        });
  }
}
