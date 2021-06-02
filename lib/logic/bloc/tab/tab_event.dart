part of 'tab_bloc.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class TabUpdated extends TabEvent {
  final TabScreens tabScreen;
  TabUpdated(this.tabScreen);
  
  @override
  List<Object> get props => [this.tabScreen];
}
