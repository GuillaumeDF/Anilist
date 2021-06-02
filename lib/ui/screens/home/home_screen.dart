import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:ani_list/ui/widgets/anime_tile/anime_tile.dart';

import 'widgets/tab_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildGrid() {
    var animes = context.read<TopCubit>().state.animes;
    return Container(
      child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 10.0, maxCrossAxisExtent: 200.0),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          children: List.generate(animes.length, (index) {
            return GridTile(
                child: AnimeTile(
              title: animes[index].title,
              score: animes[index].score.toString(),
              malId: animes[index].malId.toString(),
              imageUrl: animes[index].imageUrl,
            ));
          })),
    );
  }

  Widget _buildAnimes() {
    return BlocBuilder<TopCubit, TopState>(
      builder: (context, state) {
        if (state is TopLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TopError) {
          return Center(child: Text("Top failed"));
        } else if (state is TopSuccess) {
          return _buildGrid();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildTop() {
    return Stack(children: [
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text("Top animes",
                    style: Theme.of(context).textTheme.headline5),
              ),
              _buildAnimes(),
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: CustomTabBar(),
        body: TabBarView(children: <Widget>[
          _buildTop(),
          _buildTop(),
          _buildTop(),
        ]),
      ),
    );
  }
}
