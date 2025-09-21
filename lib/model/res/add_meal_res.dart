class AddMealRes {
  final String message;

  AddMealRes({required this.message});

  factory AddMealRes.fromJson(Map<String, dynamic> json) {
    return AddMealRes(
      message: json['message'] as String,
    );
  }
}
