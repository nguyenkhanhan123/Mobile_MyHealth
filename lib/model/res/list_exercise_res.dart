class ListExerciseRes {
  final String message;
  final List<InfoExercise> exercises;

  ListExerciseRes({required this.message, required this.exercises});

  factory ListExerciseRes.fromJson(Map<String, dynamic> json) {
    return ListExerciseRes(
      message: json['message'] as String,
      exercises:
          (json['exercises'] as List<dynamic>)
              .map((item) => InfoExercise.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }
}

class InfoExercise {
  final int id;
  final String nameExercise;
  final String thumbnail;
  final String detail;

  InfoExercise({
    required this.id,
    required this.nameExercise,
    required this.thumbnail,
    required this.detail
  });

  factory InfoExercise.fromJson(Map<String, dynamic> json) {
    return InfoExercise(
      id: json['id'] as int,
      nameExercise: json['nameExercise'] as String,
      thumbnail: json['thumbnail'] as String,
      detail: json['detail'] as String,
    );
  }
}
