import 'dart:convert';

Anime animeFromJson(String str) => Anime.fromJson(json.decode(str));
String animesToJson(Anime data) => json.encode(data.toJson());

class Anime {
  Anime({
    this.malId,
    this.url,
    this.imageUrl,
    this.title,
    this.airing,
    this.synopsis,
    this.type,
    this.episodes,
    this.score,
    this.startDate,
    this.endDate,
    this.members,
    this.rated,
  });

  int malId;
  String url;
  String imageUrl;
  String title;
  bool airing;
  String synopsis;
  String type;
  int episodes;
  double score;
  DateTime startDate;
  DateTime endDate;
  int members;
  String rated;

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
        malId: json["mal_id"],
        url: json["url"],
        imageUrl: json["image_url"],
        title: json["title"],
        airing: json["airing"],
        synopsis: json["synopsis"],
        type: json["type"],
        episodes: json["episodes"],
        score: json["score"].toDouble(),
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        members: json["members"],
        rated: json["rated"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "image_url": imageUrl,
        "title": title,
        "airing": airing,
        "synopsis": synopsis,
        "type": type,
        "episodes": episodes,
        "score": score,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "members": members,
        "rated": rated,
      };
}
