import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ani_list/logic/cubit/cubit.dart';
import 'widgets/search_bar.dart';
import 'widgets/anime_card.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Container(
              child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                if (state is SearchLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchError) {
                  return Center(child: Text("Search failed"));
                } else if (state is SearchSuccess) {
                  return AnimeCard(animes: state.animes);
                }
                return Container();
              }),
            ),
          ),
          BlocProvider.value(
            value: context.read<SearchCubit>(),
            child: CustomSearchBar(),
          ),
        ],
      ),
    );
  }
}
