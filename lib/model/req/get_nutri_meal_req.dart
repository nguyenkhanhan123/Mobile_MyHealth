class GetNutriMealReq {
  final String date;
  final int userId;

  GetNutriMealReq({
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
