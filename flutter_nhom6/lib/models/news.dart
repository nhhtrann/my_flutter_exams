class News {
  final int id;
  final String title;
  final String description;
  final String thumbnail;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      thumbnail: json["thumbnail"],
    );
  }
}
