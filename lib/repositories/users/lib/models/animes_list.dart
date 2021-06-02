class AnimesList {
  String id;
  String imageUrl;
  String title;
  String episodes;
  String watched;
  String status;

  AnimesList(
      {this.id,
      this.imageUrl,
      this.title,
      this.episodes,
      this.watched,
      this.status});

  factory AnimesList.fromData(Map<String, dynamic> data) => AnimesList(
        id: data['id'],
        imageUrl: data['imageUrl'],
        title: data['title'],
        episodes: data['episodes'],
        watched: data['watched'],
        status: data['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'episodes': episodes,
        'watched': watched,
        'status': status,
      };
}
