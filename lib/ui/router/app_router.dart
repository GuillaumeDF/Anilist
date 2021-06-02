import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'package:data/data_repository.dart';
import 'package:authentication/authentication.dart';

import 'package:ani_list/logic/bloc/bloc.dart';
import 'package:ani_list/ui/widgets/frame.dart';
import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:ani_list/constants/constants.dart';
import 'package:ani_list/ui/screens/login/login_screen.dart';
import 'package:ani_list/ui/screens/splash/splash_screen.dart';
import 'package:ani_list/ui/screens/profile/profile_screen.dart';
import 'package:ani_list/ui/screens/settings/settings_screen.dart';
import 'package:ani_list/ui/screens/register/register_screen.dart';
import 'package:ani_list/ui/screens/profile_edit/profile_edit_screen.dart';
import 'package:ani_list/ui/screens/anime_details/anime_details_screen.dart';
import 'package:ani_list/ui/screens/review_details/review_details_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SplashScreenBloc>(
            create: (_) => SplashScreenBloc(BlocProvider.of<TopCubit>(_)),
            child: SplashScreen(),
          ),
        );
      case loginRoute:
        return PageTransition(
          child: BlocProvider(
            create: (_) => LoginCubit(_.read<AuthenticationRepository>()),
            child: LoginScreen(),
          ),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 400),
        );
      case registerRoute:
        return PageTransition(
          child: BlocProvider(
            create: (_) => RegisterCubit(_.read<AuthenticationRepository>()),
            child: RegisterScreen(),
          ),
          type: PageTransitionType.bottomToTop,
          duration: Duration(milliseconds: 400),
        );
      case detailsRoute:
        return PageTransition(
          child: AnimeDetailsScreen(),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 400),
        );
      case reviewDetailsRoute:
        final Review review = settings.arguments as Review;
        return PageTransition(
          child: ReviewDetailsScreen(review),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 400),
        );
      case profileRoute:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case profileEditRoute:
        return PageTransition(
          child: BlocProvider(
            create: (_) => ImageCubit(),
            child: ProfileEditScreen(),
          ),
          type: PageTransitionType.bottomToTop,
          duration: Duration(milliseconds: 400),
        );
      case settingsRoute:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TabBloc(),
            child: Frame(),
          ),
        );
      default:
        return null;
    }
  }
}
