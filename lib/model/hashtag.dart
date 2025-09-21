class Hashtag {
  int id;
  String title;

  Hashtag({required this.id, required this.title});

  factory Hashtag.fromJson(Map<String, dynamic> json) {
    return Hashtag(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}
