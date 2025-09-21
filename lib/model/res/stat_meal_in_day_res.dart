class StatMealInDayRes {
  final String message;
  final List<InfoMealInDay> list;

  StatMealInDayRes({required this.message, required this.list});

  factory StatMealInDayRes.fromJson(Map<String, dynamic> json) {
    return StatMealInDayRes(
      message: json['message'] as String,
      list:
          (json['statMeals'] as List<dynamic>)
              .map((item) => InfoMealInDay.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
}
}

class InfoMealInDay {
  final int id;
  final String name;
  final String thumbnail;
  final double weight;
  final int isConfirm;
  final DateTime createdAt;
  final double kcal;

  InfoMealInDay({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.weight,
    required this.isConfirm,
    required this.createdAt,
    required this.kcal,
  });

  factory InfoMealInDay.fromJson(Map<String, dynamic> json) {
    return InfoMealInDay(
      id: json['id'] as int,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      weight: (json['weight'] as num).toDouble(),
      isConfirm: json['isConfirm'] as int,
      createdAt: DateTime.parse(json['createdAt']),
      kcal: (json['kcal'] as num).toDouble(),
    );
  }
}

