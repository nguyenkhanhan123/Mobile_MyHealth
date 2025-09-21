class AddExerciseRes {
  final String message;

  AddExerciseRes({required this.message});

  factory AddExerciseRes.fromJson(Map<String, dynamic> json) {
    return AddExerciseRes(
      message: json['message'] as String,
    );
  }
}
