class GetKcalExerciseReq {
  final String date;
  final int userId;

  GetKcalExerciseReq({
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
