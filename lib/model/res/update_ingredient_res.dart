class UpdateIngredientRes {
  final String message;

  UpdateIngredientRes({required this.message});

  factory UpdateIngredientRes.fromJson(Map<String, dynamic> json) {
    return UpdateIngredientRes(
      message: json['message'] as String,
    );
  }
}
