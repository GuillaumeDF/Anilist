import 'package:bloc/bloc.dart';
import 'package:data/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:users/users_repository.dart';

part 'animes_list_state.dart';

class AnimesListCubit extends Cubit<AnimesListState> {
  final UsersRepository _usersRepository;
  List<AnimesList> _animes = [];

  AnimesListCubit(this._usersRepository) : super(AnimesListInitial());

  Future<void> addToList(User user, AnimeInfos anime, String status) async {
    emit(AnimesListLoading());
    try {
      String id = anime.malId.toString();
      AnimesList list = AnimesList(
        id: id,
        imageUrl: anime.imageUrl,
        title: anime.title,
        episodes: anime.episodes.toString(),
        watched: "0",
        status: status,
      );
      await _usersRepository.addToAnimesList(user, list);
      _animes.add(list);
      emit(AnimesListSuccess(animes: _animes));
    } on Exception {
      throw AnimesListError();
    }
  }

  Future<void> removeFromList(User user, AnimeInfos anime) async {
    emit(AnimesListLoading());
    try {
      String id = anime.malId.toString();
      await _usersRepository.removeFromAnimesList(
          user,
          _animes.firstWhere((element) => element.id == anime.malId.toString(),
              orElse: null));
      _animes.removeWhere((item) => item.id == id);
      emit(AnimesListSuccess(animes: _animes));
    } on Exception {
      throw AnimesListError();
    }
  }

  Future<void> fetchList(String id) async {
    emit(AnimesListLoading());
    try {
      User user = await _usersRepository.getUser(id);
      List<AnimesList> results = user.animesList;
      _animes = results;
      emit(AnimesListSuccess(animes: _animes));
    } on Exception {
      emit(AnimesListError());
    }
  }

  bool isInList(String malId) {
    var r = false;
    state.animes?.forEach((element) {
      if (element.id == malId) r = true;
    });
    return r;
  }
}
