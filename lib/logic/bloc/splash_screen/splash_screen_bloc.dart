import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ani_list/logic/cubit/cubit.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  TopCubit _topCubit;

  SplashScreenBloc(this._topCubit) : super(Initial());

  @override
  Stream<SplashScreenState> mapEventToState(
    SplashScreenEvent event,
  ) async* {
    if (event is LoadResources) {
      yield Loading();
      try {
        await _topCubit.fetchTopAnimes("tv", 1);
      } on Exception {
        yield Error();
      }
      await Future.delayed(Duration(
          seconds: 2)); // This is to simulate that above checking process
      yield Loaded();
    }
  }
}
