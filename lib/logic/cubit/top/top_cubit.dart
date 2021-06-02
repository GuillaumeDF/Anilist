import 'package:bloc/bloc.dart';
import 'package:data/data_repository.dart';
import 'package:equatable/equatable.dart';

part 'top_state.dart';

class TopCubit extends Cubit<TopState> {
  final DataRepository _dataRepository;

  TopCubit(this._dataRepository) : super(TopInitial());

  Future<void> fetchTopAnimes(String type, int page) async {
    emit(TopLoading());
    try {
      List<TopAnime> results = await _dataRepository.fetchTopAnimes(type, page);
      emit(TopSuccess(animes: results));
    } on Exception {
      emit(TopError());
    }
  }
}
