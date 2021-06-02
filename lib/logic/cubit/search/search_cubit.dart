import 'package:bloc/bloc.dart';
import 'package:data/data_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final DataRepository _dataRepository;

  SearchCubit(this._dataRepository) : super(SearchInitial());

  Future<void> searchAnime(String title, int page) async {
    emit(SearchLoading());
    try {
      List<Anime> results = await _dataRepository.searchAnime(title, page);
      emit(SearchSuccess(animes: results));
    } on Exception {
      emit(SearchError());
    }
  }
}
