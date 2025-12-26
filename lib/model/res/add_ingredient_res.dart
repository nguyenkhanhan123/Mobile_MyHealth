class AddIngredientRes {
  final String message;

  AddIngredientRes({required this.message});

  factory AddIngredientRes.fromJson(Map<String, dynamic> json) {
    return AddIngredientRes(
      message: json['message'] as String,
    );
  }
}
