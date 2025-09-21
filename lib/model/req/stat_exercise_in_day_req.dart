class StatExerciseInDayReq {
  final String date;
  final int userId;

  StatExerciseInDayReq({
    required this.date,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'userId': userId,
    };
  }
}
