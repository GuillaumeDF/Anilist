part of 'top_cubit.dart';

abstract class TopState extends Equatable {
  final List<TopAnime> animes;

  const TopState({this.animes});

  @override
  List<Object> get props => [this.animes];
}

class TopInitial extends TopState {}

class TopLoading extends TopState {}

class TopSuccess extends TopState {
  final List<TopAnime> animes;

  const TopSuccess({this.animes});

  @override
  List<Object> get props => [this.animes];
}

class TopError extends TopState {}
