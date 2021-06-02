import 'package:data/models/anime.dart';
import 'package:data/models/best_anime_today.dart';
import 'package:data/models/top_anime.dart';
import 'package:data/models/anime_infos.dart';
import 'package:data/models/anime_reviews.dart';

abstract class AProvider {
  // Serch query based on user input
  Future<List<Anime>> searchAnime(String title, int page);

  // Fetch top animes based on type ie. airing, tv...
  Future<List<TopAnime>> fetchTopAnimes(String type, int page);

  // Fetch all informations on a given anime
  Future<AnimeInfos> fetchAnimeInfos(String id);

  // Fetch best anime of the day
  Future<BestTodayResult> fetchBestAnimeToday();

  // Fetch reviews on given anime
  Future<List<Review>> fetchAnimeReviews(String id);
}
