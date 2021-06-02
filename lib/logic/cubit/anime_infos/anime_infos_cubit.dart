import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:data/data_repository.dart';

part 'anime_infos_state.dart';

class AnimeInfosCubit extends Cubit<AnimeInfosState> {
  final DataRepository _dataRepository;

  AnimeInfosCubit(this._dataRepository) : super(AnimeInfosInitial());

  Future<void> fetchAnimeInfos(String id) async {
    emit(AnimeInfosLoading());
    try {
      AnimeInfos results = await _dataRepository.fetchAnimeInfos(id);
      emit(AnimeInfosSuccess(animeInfos: results));
    } on Exception {
      emit(AnimeInfosError());
    }
  }

  Future<void> fetchAnimeReviews(String id) async {
    emit(AnimeInfosLoading());
    try {
      List<Review> results = await _dataRepository.fetchAnimeReviews(id);
      emit(AnimeInfosReviewsSuccess(reviews: results));
    } on Exception {
      emit(AnimeInfosError());
    }
  }
}
