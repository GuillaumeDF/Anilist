import 'package:data/models/anime_reviews.dart';
import 'package:data/models/best_anime_today.dart';

import 'provider.dart';
import 'package:http/http.dart' as http;

import 'package:data/models/anime.dart';
import 'package:data/models/search.dart';
import 'package:data/models/top_anime.dart';
import 'package:data/models/anime_infos.dart';
import 'package:data/constants/constants.dart' as constants;

class JikanProvider extends AProvider {
  _getApiCall(String url, Map<String, String> queryParams) async {
    Uri uri = Uri.https(constants.endpoint, url, queryParams);
    http.Response response = await http.get(uri);
    if (response.statusCode != 200) throw Exception();
    return (response.body);
  }

  @override
  Future<List<Anime>> searchAnime(String title, int page) async {
    Map<String, String> queryParams = {
      "q": title,
      "page": page.toString(),
    };

    final searchResult =
        searchResultFromJson(await _getApiCall(constants.search, queryParams));
    return searchResult.results;
  }

  @override
  Future<List<TopAnime>> fetchTopAnimes(String type, int page) async {
    final topResult = topResultFromJson(
        await _getApiCall(constants.top + '/${page.toString()}/$type', {}));
    return topResult.top;
  }

  @override
  Future<AnimeInfos> fetchAnimeInfos(String id) async {
    final result = animeInfosFromJson(
        await _getApiCall(constants.animeInfos + '$id/', null));
    return result;
  }

  @override
  Future<BestTodayResult> fetchBestAnimeToday() async {
    final result =
        bestTodayResultFromJson(await _getApiCall(constants.bestToday, null));
    return result;
  }

  Future<List<Review>> fetchAnimeReviews(String id) async {
    final result = animeReviewsFromJson(
        await _getApiCall(constants.animeInfos + '$id/reviews', null));
    return result.reviews;
  }
}
