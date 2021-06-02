part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  final List<Anime> animes;

  const SearchState({this.animes});

  @override
  List<Object> get props => [this.animes];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Anime> animes;

  const SearchSuccess({this.animes});

  @override
  List<Object> get props => [this.animes];
}

class SearchError extends SearchState {}
