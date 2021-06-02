part of 'preferences_cubit.dart';

abstract class PreferencesState extends Equatable {
  const PreferencesState();

  @override
  List<Object> get props => [];
}

class PreferencesInitial extends PreferencesState {}

class PreferencesLoading extends PreferencesState {}

class PreferencesLoaded extends PreferencesState {}

class PreferencesError extends PreferencesState {}

class PreferencesTheme extends PreferencesState {
  final bool theme;

  PreferencesTheme(this.theme);
  @override
  List<Object> get props => [this.theme];
}
