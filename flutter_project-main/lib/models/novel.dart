class Novel {
  Novel(
      {required this.title,
      required this.writer,
      required this.novel_url,
      required this.image_url,
      required this.description,
      this.likes = 0,
      this.approved = false,
      this.genre = ""});
  int likes;
  String title;
  String writer;
  String genre;
  String novel_url;
  String image_url;
  String description;
  bool approved;

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
      likes: json['likes'],
      title: json['title'],
      writer: json['writer'],
      novel_url: json['novel_url'],
      image_url: json['image_url'],
      description: json['description'],
    );
  }
}
