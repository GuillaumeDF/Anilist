import 'package:data/models/best_anime_today.dart';

import 'models/anime.dart';
import 'models/top_anime.dart';
import 'models/anime_infos.dart';
import 'models/anime_reviews.dart';
import 'providers/jikan_provider.dart';

class DataRepository {
  JikanProvider _provider = JikanProvider();

  // Serch query based on user input
  Future<List<Anime>> searchAnime(String title, int page) =>
      _provider.searchAnime(title, page);

  // Fetch top animes based on type ie. airing, tv...
  Future<List<TopAnime>> fetchTopAnimes(String type, int page) =>
      _provider.fetchTopAnimes(type, page);

  // Fetch all informations on a given anime
  Future<AnimeInfos> fetchAnimeInfos(String id) =>
      _provider.fetchAnimeInfos(id);

  Future<BestTodayResult> fetchBestAnimeToday() =>
      _provider.fetchBestAnimeToday();

  // Fetch reviews on given anime
  Future<List<Review>> fetchAnimeReviews(String id) =>
      _provider.fetchAnimeReviews(id);
}
