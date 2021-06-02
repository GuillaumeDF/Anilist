import 'dart:convert';

BestTodayResult bestTodayResultFromJson(String str) =>
    BestTodayResult.fromJson(json.decode(str));

String bestTodayResultToJson(BestTodayResult data) =>
    json.encode(data.toJson());

class BestTodayResult {
  BestTodayResult({
    this.idAnime,
  });

  int idAnime;

  factory BestTodayResult.fromJson(Map<String, dynamic> json) =>
      BestTodayResult(
        idAnime: json["/top/anime"],
      );

  Map<String, dynamic> toJson() => {
        "/top/anime": idAnime,
      };
}
