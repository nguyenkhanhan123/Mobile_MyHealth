class GetMealPlanReq {
  final String userId;
  final List<String> mealsToGenerate;

  GetMealPlanReq({
    required this.userId,
    required this.mealsToGenerate,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'meals_to_generate': mealsToGenerate,
    };
  }
}
