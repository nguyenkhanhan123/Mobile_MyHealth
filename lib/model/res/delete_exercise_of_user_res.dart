class DeleteExerciseOfUserRes {
  final String message;

  DeleteExerciseOfUserRes({required this.message});

  factory DeleteExerciseOfUserRes.fromJson(Map<String, dynamic> json) {
    return DeleteExerciseOfUserRes(
      message: json['message'] as String,
    );
  }
}
