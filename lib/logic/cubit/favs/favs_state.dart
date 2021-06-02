part of 'favs_cubit.dart';

abstract class FavsState extends Equatable {
  final bool isFav;
  final List<Favorites> animes;

  const FavsState({this.animes, this.isFav});

  @override
  List<Object> get props => [this.animes];
}

class UpdatingFav extends FavsState {}

class UpdateFavFailure extends FavsState {}

class FavsInitial extends FavsState {}

class FavsLoading extends FavsState {}

class FavsSuccess extends FavsState {
  final List<Favorites> animes;

  const FavsSuccess({this.animes});

  @override
  List<Object> get props => [this.animes];
}

class FavsError extends FavsState {}
