class ListDishRes {
  final String message;
  final List<InfoDish> similar;

  ListDishRes({required this.message, required this.similar});

  factory ListDishRes.fromJson(Map<String, dynamic> json) {
    return ListDishRes(
      message: json['message'] as String,
      similar:
          (json['similar'] as List<dynamic>)
              .map((item) => InfoDish.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }
}

class InfoDish {
  final int id;
  final String name;
  final String thumbnail;
  final int totalKcal;
  final int totalGram;
  final int isConfirm;

  InfoDish({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.totalKcal,
    required this.totalGram,
    required this.isConfirm,
  });

  factory InfoDish.fromJson(Map<String, dynamic> json) {
    return InfoDish(
      id: json['id'] as int,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      totalKcal: (json['totalKcal'] as num).round(),
      totalGram: (json['totalGram'] as num).round(),
      isConfirm: json['isConfirm'] as int,
    );
  }
}
