import 'package:flutter/material.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';

DayNightAnimationController animationController = DayNightAnimationController();
AnimationStates _currentAnimationState = AnimationStates.night_idle;

AnimationStates get currentAnimationState => _currentAnimationState;
set currentAnimationState(AnimationStates value) {
  _currentAnimationState = value;
  animationController.changeAnimationState(value);
}

Function(bool) onSelectionChange;

class ThemeSwitcher extends StatefulWidget {
  final double height, width;
  ThemeSwitcher(
      {this.height = 0.0, this.width = 0.0, Function(bool) onSelection}) {
    onSelectionChange = onSelection;
  }
  @override
  State<StatefulWidget> createState() => ThemeSwitcherState();
}

enum AnimationStates { day_idle, switch_day, night_idle, switch_night }

extension on AnimationStates {
  String getName() {
    return this.toString().split('.').last;
  }
}

class ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: GestureDetector(
        child: FlareActor(
          "assets/animations/switch_theme.flr",
          controller: animationController,
        ),
        onTap: () {
          if (currentAnimationState == AnimationStates.day_idle) {
            currentAnimationState = AnimationStates.switch_night;
          } else {
            currentAnimationState = AnimationStates.switch_day;
          }
        },
      ),
    );
  }
}

class DayNightAnimationController extends FlareControls {
  @override
  void onCompleted(String name) {
    if (name == AnimationStates.switch_night.getName()) {
      play(AnimationStates.night_idle.getName());
      currentAnimationState = AnimationStates.night_idle;
      onSelectionChange(false);
    }
    if (name == AnimationStates.switch_day.getName()) {
      play(AnimationStates.day_idle.getName());
      currentAnimationState = AnimationStates.day_idle;
      onSelectionChange(true);
    }
    super.onCompleted(name);
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
    play(AnimationStates.night_idle.getName());
  }

  void changeAnimationState(AnimationStates states) {
    play(states.getName());
  }
}
