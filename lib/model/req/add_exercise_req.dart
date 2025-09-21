class AddExerciseReq {
  final int userId;
  final int exerciseId;
  final int time;
  final String levelExercise;
  final String date;

  AddExerciseReq({
    required this.userId,
    required this.exerciseId,
    required this.time,
    required this.levelExercise,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'exerciseId': exerciseId,
      'time': time,
      'levelExercise': levelExercise,
      'date': date,
    };
  }
}
