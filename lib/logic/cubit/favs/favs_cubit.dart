import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:users/users_repository.dart';
import 'package:ani_list/ui/widgets/anime_tile/anime_tile.dart';

part 'favs_state.dart';

class FavsCubit extends Cubit<FavsState> {
  final UsersRepository _usersRepository;
  List<Favorites> _animes = [];

  FavsCubit(this._usersRepository) : super(FavsInitial());

  Future<void> addFav(User user, AnimeTile anime) async {
    emit(UpdatingFav());
    try {
      String id = anime.malId.toString();
      Favorites fav = Favorites(
          id: id,
          imageUrl: anime.imageUrl,
          title: anime.title,
          score: anime.score.toString());
      await _usersRepository.addFav(user, fav);
      _animes.add(fav);
      emit(FavsSuccess(animes: _animes));
    } on Exception {
      throw UpdateFavFailure();
    }
  }

  Future<void> removeFav(User user, AnimeTile anime) async {
    emit(UpdatingFav());
    try {
      String id = anime.malId.toString();
      Favorites fav = Favorites(
          id: id,
          imageUrl: anime.imageUrl,
          title: anime.title,
          score: anime.score.toString());
      await _usersRepository.removeFav(user, fav);
      _animes.removeWhere((item) => item.id == id);
      emit(FavsSuccess(animes: _animes));
    } on Exception {
      throw UpdateFavFailure();
    }
  }

  Future<void> fetchFavs(String id) async {
    emit(FavsLoading());
    try {
      User user = await _usersRepository.getUser(id);
      List<Favorites> results = user.favs;
      _animes = results;
      emit(FavsSuccess(animes: _animes));
    } on Exception {
      emit(FavsError());
    }
  }

  bool isFav(String malId) {
    var r = false;
    state.animes?.forEach((element) {
      if (element.id == malId) r = true;
    });
    return r;
  }
}
