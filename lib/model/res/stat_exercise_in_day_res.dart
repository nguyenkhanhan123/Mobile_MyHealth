class StatExerciseInDayRes {
  final String message;
  final List<InfoExerciseInDay> list;

  StatExerciseInDayRes({required this.message, required this.list});

  factory StatExerciseInDayRes.fromJson(Map<String, dynamic> json) {
    return StatExerciseInDayRes(
      message: json['message'] as String,
      list:
          (json['statExercises'] as List<dynamic>)
              .map((item) => InfoExerciseInDay.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
}
}

class InfoExerciseInDay {
  final int id;
  final String nameExercise;
  final String thumbnail;
  final String level;
  final int minute;
  final int kcalPerMin;
  final DateTime createdAt;

  InfoExerciseInDay({
    required this.id,
    required this.nameExercise,
    required this.thumbnail,
    required this.level,
    required this.minute,
    required this.kcalPerMin,
    required this.createdAt,
  });

  factory InfoExerciseInDay.fromJson(Map<String, dynamic> json) {
    return InfoExerciseInDay(
      id: json['id'] as int,
      nameExercise: json['nameExercise'] as String,
      thumbnail: json['thumbnail'] as String,
      level: json['level'] as String,
      minute: json['minute'] as int,
      kcalPerMin: json['kcalPerMin'] as int,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

