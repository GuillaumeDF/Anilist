part of 'animes_list_cubit.dart';

abstract class AnimesListState extends Equatable {
  final bool isInList;
  final List<AnimesList> animes;

  const AnimesListState({this.animes, this.isInList});

  @override
  List<Object> get props => [this.animes];
}

class AnimesListInitial extends AnimesListState {}

class AnimesListLoading extends AnimesListState {}

class AnimesListSuccess extends AnimesListState {
  final List<AnimesList> animes;

  const AnimesListSuccess({this.animes});

  @override
  List<Object> get props => [this.animes];
}

class AnimesListError extends AnimesListState {}
