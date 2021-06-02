import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:data/data_repository.dart';

import 'package:ani_list/logic/bloc/bloc.dart';
import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:ani_list/constants/constants.dart';
import 'package:ani_list/ui/screens/favs/favs_screen.dart';
import 'package:ani_list/ui/screens/home/home_screen.dart';
import 'package:ani_list/logic/cubit/favs/favs_cubit.dart';
import 'package:ani_list/ui/screens/search/search_screen.dart';
import 'package:ani_list/ui/screens/profile/profile_screen.dart';
import 'package:ani_list/ui/screens/animes_list/animes_list_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

import 'nav_bar.dart';

class Frame extends StatefulWidget {
  Frame();

  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> with SingleTickerProviderStateMixin {
  final double iconSize = 20.0;
  PageController pageController;
  final Color iconColor = Colors.white;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: TabScreens.Home.index,
    );
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      _launchInBrowser(receivedNotification.summary);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  navBarChangePage(TabScreens tab) {
    BlocProvider.of<TabBloc>(context).add(TabUpdated(tab));
    pageController.animateToPage(tab.index,
        duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabScreens>(
      builder: (context, activeTab) {
        return Scaffold(
          key: _scaffoldKey,
          body: PageView(
            children: <Widget>[
              BlocProvider.value(
                value: context.read<AnimesListCubit>(),
                child: AnimesListScreen(),
              ),
              BlocProvider.value(
                value: context.read<FavsCubit>(),
                child: FavsScreen(),
              ),
              BlocProvider.value(
                value: context.read<TopCubit>(),
                child: HomeScreen(),
              ),
              BlocProvider(
                create: (context) =>
                    SearchCubit(context.read<DataRepository>()),
                child: SearchScreen(),
              ),
              ProfileScreen(),
            ],
            controller: pageController,
            onPageChanged: (pageIndex) => BlocProvider.of<TabBloc>(context)
                .add(TabUpdated(TabScreens.values[pageIndex])),
          ),
          bottomNavigationBar: NavBar(
            bottomNavigationKey: _bottomNavigationKey,
            activeTab: activeTab,
            onTabSelected: navBarChangePage,
          ),
        );
      },
    );
  }
}
