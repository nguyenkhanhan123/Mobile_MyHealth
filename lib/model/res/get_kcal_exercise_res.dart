class GetKcalExerciseRes {
  final String message;
  final double totalKcal;

  GetKcalExerciseRes({required this.message,required this.totalKcal});

  factory GetKcalExerciseRes.fromJson(Map<String, dynamic> json) {
    return GetKcalExerciseRes(
      message: json['message'] as String,
      totalKcal: (json['totalKcal'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
