import 'dart:convert';

import 'anime.dart';

SearchResult searchResultFromJson(String str) =>
    SearchResult.fromJson(json.decode(str));

String searchResultToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
  SearchResult({
    this.requestHash,
    this.requestCached,
    this.requestCacheExpiry,
    this.results,
  });

  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  List<Anime> results;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        requestHash: json["request_hash"],
        requestCached: json["request_cached"],
        requestCacheExpiry: json["request_cache_expiry"],
        results:
            List<Anime>.from(json["results"].map((x) => Anime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "request_hash": requestHash,
        "request_cached": requestCached,
        "request_cache_expiry": requestCacheExpiry,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
