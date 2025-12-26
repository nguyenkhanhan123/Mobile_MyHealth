import '../res/get_meal_plan_res.dart';

class ReplaceMealReq {
  final String userId;
  final MealItem foodOld;

  ReplaceMealReq({
    required this.userId,
    required this.foodOld,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'food_old': foodOld.toJson(),
    };
  }
}
