class AddMealReq {
  final int userId;
  final int dishId;
  final String mealType;
  final double weight;
  final String date;

  AddMealReq({
    required this.userId,
    required this.dishId,
    required this.mealType,
    required this.weight,
    required this.date
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'dishId': dishId,
      'mealType': mealType,
      'weight': weight,
      'date': date
    };
  }
}
