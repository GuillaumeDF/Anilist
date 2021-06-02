import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'package:ani_list/logic/cubit/search/search_cubit.dart';

class CustomSearchBar extends StatefulWidget {
  CustomSearchBar({Key key}) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  SearchCubit _searchCubit;
  FloatingSearchBarController _controller;
  // NOTE Fake data
  final List<String> _topAnimes = [
    "Fate/Zero",
    "One Piece",
    "Steins Gate",
  ];

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    _searchCubit = BlocProvider.of<SearchCubit>(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: FloatingSearchBar(
        elevation: 10,
        controller: _controller,
        hint: 'Search animes...',
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: 0.0,
        openAxisAlignment: 0.0,
        width: MediaQuery.of(context).size.width * 0.9,
        debounceDelay: const Duration(milliseconds: 500),
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction.searchToClear(showIfClosed: false),
        ],
        onSubmitted: (query) {
          _searchCubit.searchAnime(query, 1);
          _controller.close();
        },
        builder: (context, transition) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: _topAnimes.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                height: 50,
                child: Center(
                  child: Text('${_topAnimes[index]}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.88,
                  color: Color(0xFFEEEEFC));
            },
          );
        },
      ),
    );
  }
}
