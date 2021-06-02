import 'dart:convert';

TopResult topResultFromJson(String str) => TopResult.fromJson(json.decode(str));

String topResultToJson(TopResult data) => json.encode(data.toJson());

class TopResult {
  TopResult({
    this.requestHash,
    this.requestCached,
    this.requestCacheExpiry,
    this.top,
  });

  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  List<TopAnime> top;

  factory TopResult.fromJson(Map<String, dynamic> json) => TopResult(
        requestHash: json["request_hash"],
        requestCached: json["request_cached"],
        requestCacheExpiry: json["request_cache_expiry"],
        top: List<TopAnime>.from(json["top"].map((x) => TopAnime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "request_hash": requestHash,
        "request_cached": requestCached,
        "request_cache_expiry": requestCacheExpiry,
        "top": List<dynamic>.from(top.map((x) => x.toJson())),
      };
}

class TopAnime {
  TopAnime({
    this.malId,
    this.rank,
    this.title,
    this.url,
    this.imageUrl,
    this.type,
    this.episodes,
    this.startDate,
    this.endDate,
    this.members,
    this.score,
  });

  int malId;
  int rank;
  String title;
  String url;
  String imageUrl;
  String type;
  int episodes;
  String startDate;
  String endDate;
  int members;
  double score;

  factory TopAnime.fromJson(Map<String, dynamic> json) => TopAnime(
        malId: json["mal_id"],
        rank: json["rank"],
        title: json["title"],
        url: json["url"],
        imageUrl: json["image_url"],
        type: json["type"],
        episodes: json["episodes"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        members: json["members"],
        score: json["score"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "rank": rank,
        "title": title,
        "url": url,
        "image_url": imageUrl,
        "type": type,
        "episodes": episodes,
        "start_date": startDate,
        "end_date": endDate,
        "members": members,
        "score": score,
      };
}
