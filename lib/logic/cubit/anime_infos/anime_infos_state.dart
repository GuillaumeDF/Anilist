part of 'anime_infos_cubit.dart';

abstract class AnimeInfosState extends Equatable {
  final AnimeInfos animeInfos;

  const AnimeInfosState({this.animeInfos});

  @override
  List<Object> get props => [this.animeInfos];
}

class AnimeInfosInitial extends AnimeInfosState {}

class AnimeInfosLoading extends AnimeInfosState {}

class AnimeInfosSuccess extends AnimeInfosState {
  final AnimeInfos animeInfos;

  const AnimeInfosSuccess({this.animeInfos});

  @override
  List<Object> get props => [this.animeInfos];
}

class AnimeInfosReviewsSuccess extends AnimeInfosState {
  final List<Review> reviews;

  const AnimeInfosReviewsSuccess({this.reviews});

  @override
  List<Object> get props => [this.reviews];
}

class AnimeInfosError extends AnimeInfosState {}
