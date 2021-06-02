import 'dart:convert';

AnimeReviews animeReviewsFromJson(String str) =>
    AnimeReviews.fromJson(json.decode(str));

String animeReviewsToJson(AnimeReviews data) => json.encode(data.toJson());

class AnimeReviews {
  AnimeReviews({
    this.requestHash,
    this.requestCached,
    this.requestCacheExpiry,
    this.reviews,
  });

  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  List<Review> reviews;

  factory AnimeReviews.fromJson(Map<String, dynamic> json) => AnimeReviews(
        requestHash: json["request_hash"],
        requestCached: json["request_cached"],
        requestCacheExpiry: json["request_cache_expiry"],
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "request_hash": requestHash,
        "request_cached": requestCached,
        "request_cache_expiry": requestCacheExpiry,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
      };
}

class Review {
  Review({
    this.malId,
    this.url,
    this.type,
    this.helpfulCount,
    this.date,
    this.reviewer,
    this.content,
  });

  int malId;
  String url;
  dynamic type;
  int helpfulCount;
  DateTime date;
  Reviewer reviewer;
  String content;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        malId: json["mal_id"],
        url: json["url"],
        type: json["type"],
        helpfulCount: json["helpful_count"],
        date: DateTime.parse(json["date"]),
        reviewer: Reviewer.fromJson(json["reviewer"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "type": type,
        "helpful_count": helpfulCount,
        "date": date.toIso8601String(),
        "reviewer": reviewer.toJson(),
        "content": content,
      };
}

class Reviewer {
  Reviewer({
    this.url,
    this.imageUrl,
    this.username,
    this.episodesSeen,
    this.scores,
  });

  String url;
  String imageUrl;
  String username;
  int episodesSeen;
  Scores scores;

  factory Reviewer.fromJson(Map<String, dynamic> json) => Reviewer(
        url: json["url"],
        imageUrl: json["image_url"],
        username: json["username"],
        episodesSeen: json["episodes_seen"],
        scores: Scores.fromJson(json["scores"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "image_url": imageUrl,
        "username": username,
        "episodes_seen": episodesSeen,
        "scores": scores.toJson(),
      };
}

class Scores {
  Scores({
    this.overall,
    this.story,
    this.animation,
    this.sound,
    this.character,
    this.enjoyment,
  });

  int overall;
  int story;
  int animation;
  int sound;
  int character;
  int enjoyment;

  factory Scores.fromJson(Map<String, dynamic> json) => Scores(
        overall: json["overall"],
        story: json["story"],
        animation: json["animation"],
        sound: json["sound"],
        character: json["character"],
        enjoyment: json["enjoyment"],
      );

  Map<String, dynamic> toJson() => {
        "overall": overall,
        "story": story,
        "animation": animation,
        "sound": sound,
        "character": character,
        "enjoyment": enjoyment,
      };
}
