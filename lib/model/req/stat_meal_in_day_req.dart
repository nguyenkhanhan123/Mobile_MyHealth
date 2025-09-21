class StatMealInDayReq {
  final String date;
  final int userId;
  final String mealType;

  StatMealInDayReq({
    required this.date,
    required this.userId,
    required this.mealType
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'userId': userId,
      'mealType': mealType,
    };
  }
}
